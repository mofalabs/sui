
import 'package:example/contracts/contract_bytes.dart';
import 'package:flutter/material.dart';
import 'package:sui/constants.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/sui_client.dart';

class ManagedToken extends StatefulWidget {
  const ManagedToken({super.key});

  @override
  State<StatefulWidget> createState() => _ManagedTokenState();

}

class _ManagedTokenState extends State<ManagedToken> {

  SuiClient _suiClient = SuiClient(Constants.devnetAPI);


  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          ElevatedButton(onPressed: () async {
            final pulishTx = PublishTransaction([ContractBytes.managedTokenBytes], 10000);
            final resp = await _suiClient.publish(pulishTx);
          }, child: Text("Publish Package"))
        ],
      ),
    );
  }

}