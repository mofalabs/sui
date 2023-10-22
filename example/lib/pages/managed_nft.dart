
import 'package:another_flushbar/flushbar.dart';
import 'package:example/contracts/contract_bytes.dart';
import 'package:example/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/sui_client.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/transactions.dart';

class ManagedNFT extends StatefulWidget {
  const ManagedNFT({required this.client, Key? key}): super(key: key);

  final SuiClient client;

  @override
  State<StatefulWidget> createState() => _ManagedNFTState();

}

class _ManagedNFTState extends State<ManagedNFT> {

  TextEditingController nameTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();
  TextEditingController urlTextController = TextEditingController();
  TextEditingController burnTextController = TextEditingController();

  String? packageId;
  String? objectId;
  String? transactionModule;
  String? coinType;
  final suiObjects = <SuiObject>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage NFT"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: CustomScrollView(
          slivers:[
            sliverListButtons(context),
            if (suiObjects.isNotEmpty) const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("NFT List:", style: TextStyle(fontSize: 16)),
              )
            ),
            if (suiObjects.isNotEmpty) SliverFixedExtentList(delegate: 
              SliverChildBuilderDelegate(
                  (context1, index) => GestureDetector(
                    child: ListTile(title: Text(suiObjects[index].objectId, overflow: TextOverflow.ellipsis,)),
                    onTap: () async {
                      final txCall = MoveCallTransaction(
                        packageId!, 
                        transactionModule!, 
                        "burn", 
                        [], 
                        [suiObjects[index].objectId],
                        100000000
                      );

                      final burnResp = await widget.client.executeMoveCall(txCall);
                      if (burnResp.confirmedLocalExecution == true) {
                        debugPrint(burnResp.digest);
      
                        showSnackBar(context1, "Burned token object txn ${burnResp.digest}");
      
                        setState(() {
                          suiObjects.removeAt(index);
                        });
      
                      }
                    },
                  ),
                  childCount: suiObjects.length
                ),
                itemExtent: 50,
              )
          ]
        ),
      )
    );
  }

  SliverList sliverListButtons(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
          /// Pulish Package
          if (packageId == null) ElevatedButton(onPressed: () async {
            final pulishTx = PublishTransaction(
              ContractBytes.nft_modules, 
              ContractBytes.nft_dependencies, 
              100000000
            );
            final resp = await widget.client.publish(pulishTx);
            if (resp.effects?.status.status == ExecutionStatusType.failure) {
              showSnackBar(context, resp.effects?.status.error ?? "");
              return;
            }
            final objectChanges = resp.objectChanges as List;
            final package = objectChanges.firstWhere((e) => e["type"] == "published");
            packageId = package["packageId"].toString();
            transactionModule = package["modules"][0].toString();

            setState(() {});
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50)
          ), 
          child: const Text("Publish Managed NFT Package")),
          if(packageId != null) Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(
              children: [
                TextField(
                  controller: nameTextController,
                  decoration: const InputDecoration(
                    hintText: "name",
                    border: OutlineInputBorder(),
                  )
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descTextController,
                  decoration: const InputDecoration(
                    hintText: "desc",
                    border: OutlineInputBorder(),
                  )
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: urlTextController,
                  decoration: const InputDecoration(
                    hintText: "url",
                    border: OutlineInputBorder(),
                  )
                ),
              ],
            ),
          ),
          /// Mint
          if (packageId != null) ElevatedButton(onPressed: () async {
            final nftName = nameTextController.text;
            final nftDesc = descTextController.text;
            final nftUrl = urlTextController.text;

            /// mint coin
            final callTx = MoveCallTransaction(
              packageId!,
              transactionModule!, 
              "mint", 
              [], 
              [
               nftName, nftDesc, nftUrl
              ],
              100000000
            );
            final resp = await widget.client.executeMoveCall(callTx);
            if (resp.confirmedLocalExecution == true) {
              final createdObjs = resp.objectChanges?.where((e) => e["type"] == "created");
              final nftObjects = createdObjs?.map<SuiObject>((e) => SuiObject.fromJson(e)).toList();

              setState(() {
                suiObjects.addAll(nftObjects ?? []);
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

}