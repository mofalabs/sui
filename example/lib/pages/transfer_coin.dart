
import 'package:example/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:sui/sui.dart';

class TransferCoin extends StatefulWidget {
  const TransferCoin({required this.client, Key? key}): super(key: key);

  final SuiClient client;

  @override
  State<StatefulWidget> createState() => _TransferCoinState();

}

class _TransferCoinState extends State<TransferCoin> {

  TextEditingController amountTextController = TextEditingController(text: "100000000");
  TextEditingController receiverTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer SUI"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              controller: amountTextController,
              decoration: const InputDecoration(
                hintText: "Token Amount",
                border: OutlineInputBorder(),
              )
            ),
            const SizedBox(height: 50),
            TextField(
              controller: receiverTextController,
              decoration: const InputDecoration(
                hintText: "Receiver Address",
                border: OutlineInputBorder(),
              )
            ),
            const SizedBox(height: 50),
            ElevatedButton(onPressed: () async {
              final amount = int.tryParse(amountTextController.text);
              if (amount == null) return;

              final receiver = receiverTextController.text;
              if (!SuiAccount.isValidAddress(receiver)) return;

              try {
                final txb = TransactionBlock();
                txb.setGasBudget(BigInt.from(20000000));
                final result = txb.splitCoins(txb.gas, [txb.pureInt(amount)]);
                txb.transferObjects([result], txb.pureAddress(receiver));
                final resp = await widget.client.signAndExecuteTransactionBlock(
                  widget.client.account!, 
                  txb,
                  requestType: ExecuteTransaction.WaitForLocalExecution
                );
                if(resp.confirmedLocalExecution == true) {
                  showSnackBar(context, "Send Success");
                } else {
                  showSnackBar(context, resp.effects?.status.error ?? 'Send Failed');
                }
              } catch(e) {
                  showSnackBar(context, e.toString());
              }
            }, child: const Text("Send"))
          ],
        )
      )
    );
  }

}