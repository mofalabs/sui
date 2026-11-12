import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/rpc/faucet_pow.dart';
import 'package:sui/utils/hex.dart';

class _Adapter implements HttpClientAdapter {
  _Adapter(this.handle);
  final Future<ResponseBody> Function(RequestOptions) handle;
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) => handle(options);
  @override
  void close({bool force = false}) {}
}

void main() {
  final vector =
      jsonDecode(File('test/fixtures/faucet_pow.json').readAsStringSync())
          as Map<String, dynamic>;
  Map<String, dynamic> challenge([Map<String, dynamic> overrides = const {}]) =>
      {
        ...vector['inputs'] as Map<String, dynamic>,
        'version': 1,
        'domain': vector['domain'],
        'algorithm': 'argon2d',
        'argon2Version': 19,
        'salt': vector['salt'],
        'memorySize': 8192,
        'iterations': 1,
        'parallelism': 1,
        'hashLength': 32,
        'difficulty': '2',
        'threshold': '9223372036854775808',
        'amountMist': '1000000000',
        'windowSeconds': 600,
        ...overrides,
      };

  for (final entry in vector['cases'] as List) {
    test(
      'official faucet Argon2d vector: ${entry['note']}, nonce ${entry['nonce']}',
      () async {
        final proof = FaucetChallenge.fromJson(
          challenge({'randomBytes': entry['randomBytes']}),
        );
        final nonce = BigInt.parse(entry['nonce'] as String);
        expect(proof.preimage(nonce), entry['preimage']);
        final hash = await proof.hashProof(nonce);
        expect(Hex.encode(hash), entry['hash']);
      },
    );
  }

  test(
    'rejects untrusted resource parameters and malformed numeric fields',
    () {
      for (final override in <Map<String, dynamic>>[
        {'memorySize': 16384},
        {'iterations': 2},
        {'parallelism': 2},
        {'difficulty': '1'},
        {'threshold': '9223372036854775807'},
        {'checkpointSeq': '1e3'},
        {'amountMist': '-1'},
        {'windowSeconds': 0},
        {'recipient': '0x1'},
        {'chainId': 'not-a-digest'},
      ]) {
        expect(
          () => FaucetChallenge.fromJson(challenge(override)),
          throwsA(anything),
        );
      }
    },
  );

  test('caller cancellation before a request performs no HTTP calls', () async {
    var calls = 0;
    final dio = Dio()
      ..httpClientAdapter = _Adapter((_) async {
        calls++;
        return ResponseBody.fromString('{}', 200);
      });
    final token = CancelToken()..cancel('user cancelled');
    await expectLater(
      requestFaucetV3(
        'https://faucet.test',
        '0x1',
        dio: dio,
        cancelToken: token,
      ),
      throwsA(
        isA<DioException>().having(
          (e) => e.type,
          'type',
          DioExceptionType.cancel,
        ),
      ),
    );
    expect(calls, 0);
  });

  test(
    'payout HTTP failures are submitted once and preserve the digest',
    () async {
      var challenges = 0;
      var payouts = 0;
      final recipient = vector['inputs']['recipient'] as String;
      final digest = vector['inputs']['chainId'] as String;
      final dio = Dio()
        ..httpClientAdapter = _Adapter((request) async {
          if (request.uri.path == '/v3/challenge') {
            challenges++;
            expect(request.uri.queryParameters['recipient'], recipient);
            return ResponseBody.fromString(
              jsonEncode(challenge()),
              200,
              headers: {
                Headers.contentTypeHeader: ['application/json'],
              },
            );
          }
          payouts++;
          expect(request.uri.path, '/v3/gas');
          final data = request.data is String
              ? jsonDecode(request.data as String) as Map
              : request.data as Map;
          expect(data['recipient'], recipient);
          expect(data['hashHex'], matches(RegExp(r'^[0-9a-f]{64}$')));
          return ResponseBody.fromString(
            jsonEncode({
              'error': 'pending',
              'code': 'payout_pending',
              'digest': digest,
            }),
            503,
            headers: {
              Headers.contentTypeHeader: ['application/json'],
            },
          );
        });
      await expectLater(
        requestFaucetV3('https://faucet.test', recipient, dio: dio),
        throwsA(
          isA<FaucetException>().having((e) => e.digest, 'digest', digest),
        ),
      );
      expect(challenges, 1);
      expect(payouts, 1);
    },
    timeout: const Timeout(Duration(minutes: 1)),
  );

  test(
    'recipient mismatch rejects challenge before mining or submitting',
    () async {
      var calls = 0;
      final dio = Dio()
        ..httpClientAdapter = _Adapter((_) async {
          calls++;
          return ResponseBody.fromString(
            jsonEncode(challenge()),
            200,
            headers: {
              Headers.contentTypeHeader: ['application/json'],
            },
          );
        });
      await expectLater(
        requestFaucetV3('https://faucet.test', '0x1', dio: dio),
        throwsFormatException,
      );
      expect(calls, 1);
    },
  );
}
