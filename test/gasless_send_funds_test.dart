import 'package:flutter_test/flutter_test.dart';
import 'package:sui/builder/transaction.dart';
import 'package:sui/builder/transaction_block_data.dart';
import 'package:sui/grpc/grpc_transaction_mapper.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/input.pb.dart';

/// Encoding-layer verification for gasless stablecoin transfers
/// (`0x2::balance::send_funds<T>` sourced from an address-balance withdrawal).
/// Exercises the BCS `FundsWithdrawal` CallArg and the gRPC input mapper
/// without any network / funds.
void main() {
  const usdc =
      '0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC';
  const sender =
      '0x0000000000000000000000000000000000000000000000000000000000000abc';
  const recipient =
      '0x0000000000000000000000000000000000000000000000000000000000000def';
  final amount = BigInt.from(1000000); // 1.0 USDC (6 decimals)

  Transaction buildGasless() {
    final tx = Transaction();
    final balance = tx.balanceWithdrawal(usdc, amount);
    tx.moveCall(
      '0x2::balance::send_funds',
      typeArguments: [usdc],
      arguments: [balance, tx.pureAddress(recipient)],
    );
    tx.setSender(sender);
    tx.setGasPrice(BigInt.zero);
    tx.setGasBudget(BigInt.zero);
    tx.setGasPayment(const []);
    return tx;
  }

  test('FundsWithdrawal input node has the expected shape', () {
    final tx = Transaction();
    final arg = tx.balanceWithdrawal(usdc, amount);
    // Argument returned is Input(0).
    expect(arg[r'$kind'], 'Input');
    expect(arg['Input'], 0);
    final data = tx.getData();
    final input = data.inputs!.first;
    expect(input[r'$kind'], 'FundsWithdrawal');
    final fw = input['FundsWithdrawal'] as Map;
    expect(fw['reservation'], {'MaxAmountU64': '1000000'});
    expect(fw['typeArg'], {'Balance': usdc});
    expect(fw['withdrawFrom'], {'Sender': true});
  });

  test('BCS-serializes the TransactionKind (FundsWithdrawal CallArg) without throwing',
      () async {
    final tx = buildGasless();
    // onlyTransactionKind serializes inputs+commands through the sui BCS,
    // exercising the new CallArg.FundsWithdrawal variant.
    final bytes = await tx.build(BuildOptions(onlyTransactionKind: true));
    expect(bytes, isNotEmpty);
    // Sanity: the send_funds command references the withdrawal input.
    final data = tx.getData();
    expect(data.commands!.length, 1);
    expect(data.inputs!.length, 2); // FundsWithdrawal + recipient pure address
  });

  test('maps the FundsWithdrawal input to the structured gRPC Input', () {
    final tx = buildGasless();
    final grpc = transactionDataToGrpcTransaction(TransactionBlockDataBuilder(tx.getData()),
        includeGas: false);
    final inputs =
        grpc.kind.programmableTransaction.inputs;
    expect(inputs.length, 2); // FundsWithdrawal + recipient pure address
    final input = inputs.first;
    expect(input.kind, Input_InputKind.FUNDS_WITHDRAWAL);
    expect(input.fundsWithdrawal.amount.toInt(), 1000000);
    expect(input.fundsWithdrawal.coinType, usdc);
    expect(input.fundsWithdrawal.source, FundsWithdrawal_Source.SENDER);
  });
}
