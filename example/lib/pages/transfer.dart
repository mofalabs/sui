
import 'dart:math';

import 'package:example/components/button.dart';
import 'package:example/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:sui/sui.dart';

class Transfer extends StatefulWidget {
  const Transfer(this.account, {Key? key}): super(key: key);

  final SuiAccount account;

  @override
  State<StatefulWidget> createState() => _TransferState();

}

class _TransferState extends State<Transfer> {

  TextEditingController amountTextController = TextEditingController(text: "1");
  TextEditingController receiverTextController = TextEditingController();

  bool sending = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: 400,
      child: Padding(
        padding: EdgeInsets.only(top: size.height / 4),
        child: Column(
            children: [
              TextField(
                controller: amountTextController,
                decoration: const InputDecoration(
                  hintText: "Token Amount",
                  suffixText: 'SUI',
                  border: OutlineInputBorder(),
                )
              ),
              const SizedBox(height: 30),
              TextField(
                controller: receiverTextController,
                decoration: const InputDecoration(
                  hintText: "Receiver Address",
                  border: OutlineInputBorder(),
                )
              ),
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
                  final result = txb.splitCoins(txb.gas, [txb.pureInt(amount.toInt())]);
                  txb.transferObjects([result], txb.pureAddress(receiver));
                  final resp = await suiClient.signAndExecuteTransactionBlock(
                    widget.account, 
                    txb,
                    requestType: ExecuteTransaction.WaitForLocalExecution
                  );
                  if(resp.confirmedLocalExecution == true) {
                    showToast(context, "Transaction Send Success");
                  } else {
                    showErrorToast(context, "Transaction Send Failed");
                  }
                } catch(e) {
                    showErrorToast(context, e.toString());
                } finally {
                  setState(() {
                    sending = false;
                  });
                }
              })
            ],
          ),
      )
    );
  }

}