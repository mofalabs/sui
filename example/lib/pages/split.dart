
import 'dart:convert';
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

  Future splitSui(String amountArr, String to) async {
    if (sending) return;

    List list;
    try {
      list = jsonDecode("[$amountArr]") as List;
    } catch(e) {
      showErrorToast(context, e.toString());
      return;
    }

    setState(() {sending = true;});

    try {
      final txb = TransactionBlock();
      txb.setGasBudget(BigInt.from(20000000));

      final amounts = list.map((e) => txb.pureInt((double.parse(e.toString()) * pow(10, 9)).toInt())).toList();
      final result = txb.splitCoins(txb.gas, amounts);
      final coins = amounts.asMap().keys.map((key) => result[key]).toList();
      txb.transferObjects(coins, txb.pureAddress(to));

      final resp = await suiClient.signAndExecuteTransactionBlock(
        widget.account, 
        txb,
        responseOptions: SuiTransactionBlockResponseOptions(showEffects: true)
      );
      if (resp.effects?.status.status == ExecutionStatusType.success) {
        showToast(context, "Transaction Send Success");
      } else {
        showErrorToast(context, resp.effects?.status.error ?? "Split Coins Fail");
      }
    } catch(e) {
      showErrorToast(context, e.toString());
    } finally {
      setState(() {sending = false;});
    }
  }

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
                suffixText: "SUI",
                hintText: '1, 2, 3'
              ),
            ),
            const SizedBox(height: 50),
            Button(sending ? 'Sending': 'Split', () {
              splitSui(amountTextController.text, widget.account.getAddress());
            })
          ],
        ),
      ),
    );
  }
}