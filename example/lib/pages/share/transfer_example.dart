import 'dart:math';

import 'package:example/components/button.dart';
import 'package:example/helper/helper.dart';
import 'package:example/widget/markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sui/sui.dart';

class TransferExample extends StatefulWidget {
  const TransferExample({super.key});

  @override
  State<StatefulWidget> createState() => _TransferExampleState();
}

class _TransferExampleState extends State<TransferExample> {
  TextEditingController amountTextController = TextEditingController(text: "1");
  TextEditingController receiverTextController = TextEditingController(
      text:
          "0xcf31225365ee778b9a48a15d902b5f1ab987f9dcf5db7843291fb2a85e2e5a34");
  BigInt balance = BigInt.zero;

  bool sending = false;
  SuiAccount? account;
  var showCode = false;
  var code = '';
  bool requestingFaucet = false;

  late SuiClient suiClient;

  @override
  void initState() {
    super.initState();
    _getCode();
    Future.delayed(const Duration(milliseconds: 250), () {
      const mnemonic =
          "buffalo apple awkward journey crystal unveil receive strategy worth link size orient";
      account = SuiAccount.fromMnemonics(mnemonic, SignatureScheme.Secp256k1);
      suiClient = SuiClient(Constants.faucetTestAPI, account: account);
      setState(() {});
      _getBalance();
    });
  }

  _getBalance() async {
    final coinBalance = await suiClient.getBalance(account!.getAddress());
    setState(() {
      balance = coinBalance.totalBalance;
    });
  }

  _getCode() async {
    final value = await rootBundle.loadString('assets/introduce.md');
    final list = value.split('?');
    code = list[3];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return account == null ? Container() : _buildContent();
  }

  _buildContent() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        const Text(
          'Account',
          style: TextStyle(color: Colors.blue),
        ),
        const SizedBox(height: 10),
        SelectableText(
          account?.getAddress() ?? "",
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              '${balance / BigInt.from(10).pow(9)} SUI',
              style: const TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Button(requestingFaucet ? "Fauceting" : "Faucet", _requestFaucet),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            const Text(
              'Transfer',
              style: TextStyle(color: Colors.blue),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.code,
                color: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  showCode = !showCode;
                });
              },
            ),
          ],
        ),
        if (showCode && code.isNotEmpty) Markdown(code),
        _transferContent()
      ],
    );
  }

  void _requestFaucet() async {
    if (requestingFaucet) return;
    final address = account!.getAddress();
    if (balance <= BigInt.zero) {
      setState(() {
        requestingFaucet = true;
      });
      try {
        final faucet = FaucetClient(Constants.faucetTestAPI);
        await faucet.requestSuiFromFaucetV1(address);
        _getBalance();
      } catch (e) {
        showSnackBar(context, e.toString());
      } finally {
        setState(() {
          requestingFaucet = false;
        });
      }
    }
  }

  _transferContent() {
    return Column(
      children: [
        TextField(
            controller: amountTextController,
            decoration: const InputDecoration(
              hintText: "Token Amount",
              suffixText: 'SUI',
              border: OutlineInputBorder(),
            )),
        const SizedBox(height: 30),
        TextField(
            controller: receiverTextController,
            decoration: const InputDecoration(
              hintText: "Receiver Address",
              border: OutlineInputBorder(),
            )),
        const SizedBox(height: 50),
        Button(sending ? 'Sending' : 'Send', () async {
          var amount = double.tryParse(amountTextController.text);
          if (amount == null) return;
          amount = amount * pow(10, 9);

          final receiver = receiverTextController.text;
          if (!SuiAccount.isValidAddress(receiver)) return;

          try {
            if (sending) return;
            setState(() {
              sending = true;
            });

            final txb = TransactionBlock();
            txb.setGasBudget(BigInt.from(20000000));
            final result =
                txb.splitCoins(txb.gas, [txb.pureInt(amount.toInt())]);
            txb.transferObjects([result], txb.pureAddress(receiver));
            final resp = await suiClient.signAndExecuteTransactionBlock(
              account!,
              txb,
              requestType: ExecuteTransaction.WaitForLocalExecution,
            );
            if (resp.confirmedLocalExecution == true) {
              showToast(context, "Transaction Send Success");
              _getBalance();
            } else {
              showErrorToast(context, "Transaction Send Failed");
            }
          } catch (e) {
            showErrorToast(context, e.toString());
          } finally {
            setState(() {
              sending = false;
            });
          }
        })
      ],
    );
  }
}
