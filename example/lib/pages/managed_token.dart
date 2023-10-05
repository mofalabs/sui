
import 'package:another_flushbar/flushbar.dart';
import 'package:example/contracts/contract_bytes.dart';
import 'package:example/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/sui_client.dart';
import 'package:sui/types/objects.dart';

class ManagedToken extends StatefulWidget {
  const ManagedToken({required this.client, Key? key}): super(key: key);

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
  List<SuiObject>? suiObjects;
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
            if (suiObjects != null) const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Token List:", style: TextStyle(fontSize: 16)),
              )
            ),
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
                        100000000
                      );

                      final burnResp = await widget.client.executeMoveCall(txCall);
                      if (burnResp.confirmedLocalExecution == true) {
                        debugPrint(burnResp.digest);
      
                        showSnackBar(context1, "Burned token object txn ${burnResp.digest}");
      
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
          /// Pulish Package
          if (packageId == null) ElevatedButton(onPressed: () async {
            final pulishTx = PublishTransaction(ContractBytes.modules, ContractBytes.dependencies, 100000000);
            final resp = await widget.client.publish(pulishTx);
            final objectChanges = resp.objectChanges as List;
            final package = objectChanges.firstWhere((e) => e["type"] == "published");
            packageId = package["packageId"].toString();
            final treasuryCapObj = objectChanges.firstWhere((e) => e["type"] == "created" && e["objectType"].toString().contains("coin::TreasuryCap"));
            objectId = treasuryCapObj["objectId"].toString();
            transactionModule = package["modules"][0].toString();

            setState(() {});
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50)
          ), 
          child: const Text("Publish Managed Token Package")),
          if(packageId != null) Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: TextField(
              controller: mintTextController,
              decoration: const InputDecoration(
                hintText: "Token Amount",
                border: OutlineInputBorder(),
              )
            ),
          ),
          /// Mint
          if (packageId != null) ElevatedButton(onPressed: () async {
            final amount = mintTextController.text;
            if (int.tryParse(amount) == null) return;
            /// mint coin
            final callTx = MoveCallTransaction(
              packageId!,
              transactionModule!, 
              "mint", 
              [], 
              [
               objectId!, amount, widget.client.getAddress() 
              ],
              100000000
            );
            final resp = await widget.client.executeMoveCall(callTx);
            if (resp.confirmedLocalExecution == true) {
              coinType = "${packageId!}::${transactionModule!}::MANAGED";
              final balance = await widget.client.getBalance(
                widget.client.getAddress(), 
                coinType: coinType!
              );
              debugPrint(balance.toString());

              final coinObjects = await queryCoinObjects();
              setState(() {
                suiObjects = coinObjects;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            textStyle: const TextStyle(fontSize: 18)
          ), child: const Text("Mint")),
        ],
    ));
  }

  Future<List<SuiObject>> queryCoinObjects() async {
    final objectsResp = await widget.client.getOwnedObjects(
      widget.client.getAddress(),
      options: SuiObjectDataOptions(showType: true, showContent: true),
    );
    final coinObjects = objectsResp.data.where((obj) => obj.data?.type == "0x2::coin::Coin<$coinType>")
      .map((x) => x.data!).toList();
    return coinObjects;
  }

}