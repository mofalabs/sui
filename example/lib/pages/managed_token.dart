
import 'package:another_flushbar/flushbar.dart';
import 'package:example/contracts/contract_bytes.dart';
import 'package:example/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/sui_client.dart';
import 'package:sui/types/objects.dart';

class ManagedToken extends StatefulWidget {
  const ManagedToken({super.key, required this.client});

  final SuiClient client;

  @override
  State<StatefulWidget> createState() => _ManagedTokenState();

}

class _ManagedTokenState extends State<ManagedToken> {

  TextEditingController mintTextController = TextEditingController(text: "10000");
  TextEditingController burnTextController = TextEditingController();

  String? packageId;
  String? objectId;
  String? transactionModule;
  List<SuiObjectInfo>? suiObjects;
  String? coinType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Token"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: CustomScrollView(
          slivers:[
            sliverListButtons(),
            if (suiObjects != null) SliverFixedExtentList(delegate: 
              SliverChildBuilderDelegate(
                  (context1, index) => GestureDetector(
                    child: ListTile(title: Text(suiObjects![index].objectId, overflow: TextOverflow.ellipsis,)),
                    onTap: () async {
                      final txCall = MoveCallTransaction(
                        packageId!, 
                        transactionModule!, 
                        "burn", 
                        [], 
                        [objectId!, suiObjects![index].objectId],
                        10000
                      );

                      final burnResp = await widget.client.executeMoveCall(txCall);
                      if (burnResp.confirmedLocalExecution == true) {
                        debugPrint(burnResp.certificate?.transactionDigest);
      
                        showSnackBar(context1, "Burned token object tx ${burnResp.certificate?.transactionDigest}");
      
                        final coinObjects = await queryCoinObjects();
                        setState(() {
                          suiObjects = coinObjects;
                        });
      
                      }
                    },
                  ),
                  childCount: suiObjects?.length ?? 0
                ),
                itemExtent: 50,
              )
          ]
        ),
      )
    );
  }

  SliverList sliverListButtons() {
    return SliverList(
      delegate: SliverChildListDelegate([
          ElevatedButton(onPressed: () async {
            final pulishTx = PublishTransaction([ContractBytes.managedTokenBytes], 10000);
            final resp = await widget.client.publish(pulishTx);
            if (resp.confirmedLocalExecution == true) {
              debugPrint(resp.certificate!.transactionDigest);
              final events = resp.effectsCert!.effects.events ?? [];
              final event = events.firstWhere((e) => e["newObject"] != null && e["newObject"]["objectType"].toString().startsWith("0x2::coin::TreasuryCap"));
              final obj = event["newObject"];
              packageId = obj["packageId"];
              objectId = obj["objectId"];
              transactionModule = obj["transactionModule"];
            }
            setState(() {});
          }, 
          child: Text("Publish Managed Token Package"),
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50)
          )),
          if(packageId != null) TextField(
            controller: mintTextController,
          ),
          if (packageId != null) ElevatedButton(onPressed: () async {
            final amount = mintTextController.text;
            if (int.tryParse(amount) == null) return;

            final callTx = MoveCallTransaction(
              packageId!,
              transactionModule!, 
              "mint", 
              [], 
              [
               objectId!, amount, widget.client.getAddress() 
              ],
              10000
            );
            final resp = await widget.client.executeMoveCall(callTx);
            if (resp.confirmedLocalExecution == true) {
              coinType = "${packageId!}::${transactionModule!}::MANAGED";
              final balance = await widget.client.provider.getBalance(
                widget.client.getAddress(), 
                coinType: coinType!
              );
              debugPrint(balance.toString());

              final coinObjects = await queryCoinObjects();
              setState(() {
                suiObjects = coinObjects;
              });
            }
          }, child: Text("Mint"),
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
            textStyle: TextStyle(fontSize: 18)
          )),
        ],
    ));
  }

  Future<List<SuiObjectInfo>> queryCoinObjects() async {
      final objects = await widget.client.getObjectsOwnedByAddress(widget.client.getAddress());
      final coinObjects = objects.where((obj) => obj.type == "0x2::coin::Coin<$coinType>").toList();
      return coinObjects;
  }

}