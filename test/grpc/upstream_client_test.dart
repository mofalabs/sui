import 'dart:convert';

import 'package:dio/dio.dart' show CancelToken, DioException;
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart'
    hide Ordering, TransactionEffects, ExecutionStatus;
import 'package:sui/grpc/proto/sui/rpc/v2/ledger_service.pb.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/executed_transaction.pb.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/query_options.pb.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/transaction.pb.dart' as pb;
import 'package:sui/grpc/proto/sui/rpc/v2/transaction_execution_service.pb.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/effects.pb.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/execution_status.pb.dart';
import 'package:sui/grpc/proto/google/protobuf/timestamp.pb.dart';
import 'package:sui/grpc/grpc_transaction_mapper.dart';
import 'package:sui/utils/proto_int.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/state_service.pb.dart';
import '../support/grpc_fixture_transport.dart';

void main() {
  test(
    'ledger lookahead resumes after last returned item without skipping',
    () async {
      final token = CancelToken();
      final transport = GrpcFixtureTransport(
        onStream: (method, bytes) async* {
          expect(method, 'ListTransactions');
          final request = ListTransactionsRequest.fromBuffer(bytes);
          expect(request.options.limit, 3);
          expect(request.options.ordering, Ordering.ORDERING_DESCENDING);
          expect(request.options.before, [0]);
          for (var i = 1; i <= 3; i++) {
            yield ListTransactionsResponse(
              transaction: ExecutedTransaction(digest: '$i'),
              watermark: Watermark(cursor: [i]),
              end: i == 3
                  ? QueryEnd(reason: QueryEndReason.QUERY_END_REASON_ITEM_LIMIT)
                  : null,
            ).writeToBuffer();
          }
        },
      );
      final client = SuiGrpcClient(
        network: SuiNetwork.localnet,
        transport: transport,
      );
      final page = await client.core.listTransactions(
        limit: 2,
        before: base64Encode([0]),
        cancelToken: token,
      );
      expect(page.items.map((tx) => tx.digest), ['1', '2']);
      expect(page.cursor, base64Encode([2]));
      expect(page.hasNextPage, isTrue);
      expect(transport.lastCancelToken, same(token));
    },
  );

  test(
    'empty filtered scan keeps progress; missing end marker fails',
    () async {
      var complete = true;
      final transport = GrpcFixtureTransport(
        onStream: (_, __) async* {
          yield ListEventsResponse(
            watermark: Watermark(cursor: [9], checkpoint: Int64(100)),
            end: complete
                ? QueryEnd(reason: QueryEndReason.QUERY_END_REASON_SCAN_LIMIT)
                : null,
          ).writeToBuffer();
        },
      );
      final core = GrpcCoreClient(
        network: SuiNetwork.localnet,
        transport: transport,
      );
      final page = await core.listEvents();
      expect(page.items, isEmpty);
      expect(page.cursor, base64Encode([9]));
      expect(page.hasNextPage, isTrue);
      expect(page.checkpoint, BigInt.from(100));
      complete = false;
      await expectLater(core.listEvents(), throwsFormatException);
    },
  );

  test('transaction polling retries only typed missing transactions', () async {
    var calls = 0;
    final transport = GrpcFixtureTransport(
      onUnary: (_, __) {
        calls++;
        if (calls == 1) throw GrpcWebException(GrpcStatus.notFound, 'missing');
        return GetTransactionResponse(
          transaction: ExecutedTransaction(digest: 'found'),
        ).writeToBuffer();
      },
    );
    final core = GrpcCoreClient(
      network: SuiNetwork.localnet,
      transport: transport,
    );
    expect(
      (await core.waitForTransaction(
        'found',
        pollInterval: const Duration(milliseconds: 1),
      )).digest,
      'found',
    );
    expect(calls, 2);
    final failing = GrpcCoreClient(
      network: SuiNetwork.localnet,
      transport: GrpcFixtureTransport(
        onUnary: (_, __) =>
            throw GrpcWebException(GrpcStatus.unavailable, 'offline'),
      ),
    );
    await expectLater(
      failing.waitForTransaction('x'),
      throwsA(isA<GrpcWebException>()),
    );
  });

  test('name misses return null while network errors remain visible', () async {
    var status = GrpcStatus.notFound;
    final core = GrpcCoreClient(
      network: SuiNetwork.localnet,
      transport: GrpcFixtureTransport(
        onUnary: (_, __) => throw GrpcWebException(status, 'fixture'),
      ),
    );
    expect(await core.defaultNameServiceName('0x1'), isNull);
    expect(await core.resolveNameServiceAddress('@missing'), isNull);
    status = GrpcStatus.unavailable;
    await expectLater(
      core.resolveNameServiceAddress('@missing'),
      throwsA(isA<GrpcWebException>()),
    );
  });

  test('uint64 metadata and balances retain their unsigned value', () {
    final max = (BigInt.one << 64) - BigInt.one;
    final encoded = bigIntToUint64(max);
    expect(uint64ToBigInt(encoded), max);
    expect(SuiBalance.fromProto(Balance(balance: encoded)).totalBalance, max);
    final result = SuiExecutionResult.fromProto(
      ExecutedTransaction(
        checkpoint: encoded,
        timestamp: Timestamp(seconds: Int64(100), nanos: 123000000),
      ),
    );
    expect(result.checkpoint, max);
    expect(
      result.timestamp,
      DateTime.fromMillisecondsSinceEpoch(100123, isUtc: true),
    );
    expect(result.gasObjectId, isNull);
    final sim = SimulateTransactionResponse(
      transaction: ExecutedTransaction(
        effects: TransactionEffects(
          gasObject: ChangedObject(objectId: mockedGasObjectId),
        ),
      ),
    );
    expect(sim.gasPaymentMocked, isTrue);
    expect(() => bigIntToUint64(BigInt.one << 64), throwsArgumentError);
    expect(() => bigIntToUint64(-BigInt.one), throwsArgumentError);
  });

  test(
    'transaction polling can be cancelled during the polling delay',
    () async {
      final token = CancelToken();
      final core = GrpcCoreClient(
        network: SuiNetwork.localnet,
        transport: GrpcFixtureTransport(
          onUnary: (_, __) =>
              throw GrpcWebException(GrpcStatus.notFound, 'missing'),
        ),
      );
      final pending = core.waitForTransaction(
        'missing',
        cancelToken: token,
        pollInterval: const Duration(seconds: 30),
      );
      Future<void>.delayed(
        const Duration(milliseconds: 5),
        () => token.cancel(),
      );
      await expectLater(pending, throwsA(isA<DioException>()));
    },
  );

  test(
    'gas resolution applies resolved body and preserves all validity bounds',
    () async {
      final data = TransactionBlockDataBuilder()
        ..sender = normalizeSuiAddress('0x1');
      final returned = transactionDataToGrpcTransaction(data);
      returned.expiration = pb.TransactionExpiration(
        kind: pb.TransactionExpiration_TransactionExpirationKind.VALIDITY,
        minEpoch: Int64(1),
        epoch: Int64(2),
        chain: '11111111111111111111111111111111',
        nonce: 7,
        minTimestamp: Timestamp(seconds: Int64(100), nanos: 123000000),
        maxTimestamp: Timestamp(seconds: Int64(200), nanos: 456000000),
        allowedProposers: pb.AllowedProposers(
          epoch: Int64(1),
          proposers: [0, 2],
        ),
      );
      returned.gasPayment = pb.GasPayment(budget: Int64(10), price: Int64(2));
      data.commands = [
        {
          'MoveCall': {
            'package': '0x2',
            'module': 'coin',
            'function': 'zero',
            'typeArguments': ['0x2::sui::SUI'],
            'arguments': [],
          },
        },
      ];
      final transport = GrpcFixtureTransport(
        onUnary: (method, bytes) {
          expect(method, 'SimulateTransaction');
          final request = SimulateTransactionRequest.fromBuffer(bytes);
          expect(
            request.readMask.paths,
            containsAll([
              'transaction.transaction.kind',
              'transaction.transaction.expiration',
            ]),
          );
          expect(request.doGasSelection, isTrue);
          return SimulateTransactionResponse(
            transaction: ExecutedTransaction(
              transaction: returned,
              effects: TransactionEffects(
                status: ExecutionStatus(success: true),
                epoch: Int64(1),
              ),
            ),
          ).writeToBuffer();
        },
      );
      final adapter = GrpcBuilderAdapter(
        GrpcCoreClient(network: SuiNetwork.localnet, transport: transport),
      );
      final resolved = await adapter.resolveGasData(data);
      expect(resolved!.payment, isEmpty);
      expect(resolved.budget, BigInt.from(10));
      expect(data.commands, isEmpty);
      expect(data.expiration!.validity!['minTimestamp'], '100123');
      expect(data.expiration!.validity!['maxTimestamp'], '200456');
      expect(data.expiration!.validity!['allowedProposers'], {
        'epoch': '1',
        'proposers': [0, 2],
      });
      final roundTrip = transactionDataToGrpcTransaction(data);
      expect(
        roundTrip.expiration.writeToBuffer(),
        returned.expiration.writeToBuffer(),
      );
    },
  );

  test(
    'kind-only server resolution disables checks and preserves absent sender',
    () async {
      final core = GrpcCoreClient(
        network: SuiNetwork.localnet,
        transport: GrpcFixtureTransport(
          onUnary: (method, bytes) {
            expect(method, 'SimulateTransaction');
            final request = SimulateTransactionRequest.fromBuffer(bytes);
            expect(
              request.checks,
              SimulateTransactionRequest_TransactionChecks.DISABLED,
            );
            expect(request.doGasSelection, isFalse);
            expect(request.transaction.hasSender(), isTrue);
            final resolved = request.transaction.deepCopy();
            resolved.sender = normalizeSuiAddress('0x9');
            return SimulateTransactionResponse(
              transaction: ExecutedTransaction(transaction: resolved),
            ).writeToBuffer();
          },
        ),
      );
      final tx = Transaction();
      await tx.build(
        BuildOptions(
          onlyTransactionKind: true,
          client: GrpcBuilderAdapter(core),
        ),
      );
      expect(tx.getData().sender, isNull);
    },
  );

  test('kind-only mapping preserves an absent sender and missing gas', () {
    final data = TransactionBlockDataBuilder();
    final tx = transactionDataToGrpcTransaction(data, includeGas: false);
    expect(tx.hasSender(), isFalse);
    expect(tx.hasGasPayment(), isFalse);
  });
}
