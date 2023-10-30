
import 'dart:math';

import 'package:example/components/button.dart';
import 'package:example/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:sui/sui.dart';

class Split extends StatefulWidget {
  const Split(this.account, { Key? key }) : super(key: key);

  final SuiAccount account;

  @override
  _SplitState createState() => _SplitState();
}

class _SplitState extends State<Split> {

  final amountTextController = TextEditingController();
  bool sending = false;

  Future splitSui(String amount, String to) async {
    double? value = double.tryParse(amount);
    if(value == null) return;

    if (sending) return;
    setState(() {sending = true;});
    
    final amountValue = value * pow(10, 9);
    final txb = TransactionBlock();
    txb.setGasBudget(BigInt.from(20000000));
    final result = txb.splitCoins(txb.gas, [txb.pureInt(amountValue.toInt())]);
    txb.transferObjects([result], txb.pureAddress(to));
    try {
      await suiClient.signAndExecuteTransactionBlock(widget.account, txb);
      showToast(context, "Transaction Send Success");
    } catch(e) {
      showErrorToast(context, e.toString());
    } finally {
      setState(() {sending = false;});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Column(
        children: [
          TextField(
            controller: amountTextController,
            decoration: const InputDecoration(
              suffixText: "SUI"
            ),
          ),
          const SizedBox(height: 50),
          Button(sending ? 'Sending': 'Split', () {
            splitSui(amountTextController.text, widget.account.getAddress());
          })
        ],
      ),
    );
  }
}