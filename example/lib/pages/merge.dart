
import 'dart:math';

import 'package:example/components/button.dart';
import 'package:example/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:sui/sui.dart';

class Merge extends StatefulWidget {
  const Merge(this.account,{ Key? key }) : super(key: key);

  final SuiAccount account;

  @override
  _MergeState createState() => _MergeState();
}

class _MergeState extends State<Merge> {

  final coins = <CoinStruct>[];
  final coinsSelected = <bool>[];

  bool sending = false;

  void getCoins() {
    suiClient.getCoins(widget.account.getAddress()).then((res) {
      setState(() {
        coinsSelected.clear();
        coinsSelected.addAll(List<bool>.filled(res.data.length, false));
        coins.clear();
        coins.addAll(res.data);
      });
    });
  }

  @override
  void initState() {
    super.initState();

    getCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: ListView.builder(itemBuilder: (context, index) {
        if (index == coins.length) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: Button(sending ? 'Sending' : 'Merge', () async {

              if (sending) return;
              if (coinsSelected.where((e) => e == true).length < 2) {
                showErrorToast(context, "Must be select more than two coins");
              }

              try {
                setState(() {
                  sending = true;
                });

                var checkedCoins = <CoinStruct>[];
                for (var i = 0; i < coinsSelected.length; i++) {
                  if (coinsSelected[i] == true) {
                    checkedCoins.add(coins[i]);
                  }
                }

                final txb = TransactionBlock();
                txb.setGasBudget(BigInt.from(20000000));
                final destCoin = txb.objectId(checkedCoins.first.coinObjectId);
                final sourceCoins = checkedCoins.skip(1).map((e) => txb.objectId(e.coinObjectId)).toList();
                txb.mergeCoins(destCoin, sourceCoins);
                await suiClient.signAndExecuteTransactionBlock(widget.account, txb);
                showToast(context, 'Merge Coins Success');
                getCoins();
              } catch(e) {
                showErrorToast(context, e.toString());
              } finally {
                setState(() {
                  sending = false;
                });
              }

            }),
          );
        }

        final bal = int.parse(coins[index].balance) / pow(10, 9);

        return CheckboxListTile(
          title: Column(
            children: [
              Text(coins[index].coinObjectId, textAlign: TextAlign.center),
              SizedBox(height: 8),
              Text("(${bal.toStringAsFixed(10)}) SUI", textAlign: TextAlign.center),
            ],
          ),
          value: coinsSelected[index],
          onChanged: ((value) {
            if (value == true && coinsSelected.where((e) => e == false).length <= 1) {
              showErrorToast(context, "You have to leave on coin for gas");
              return;
            }

            setState(() {
              coinsSelected[index] = value!;
            });
          }),
        );
      }, itemCount: coins.isNotEmpty ? coins.length + 1 : 0),
    );
  }
}