
import 'package:example/pages/managed_nft.dart';
import 'package:example/pages/managed_token.dart';
import 'package:example/pages/transfer_coin.dart';
import 'package:flutter/material.dart';
import 'package:sui/sui_client.dart';

class TokenMenu extends StatefulWidget {
  const TokenMenu({required this.client, Key? key}): super(key: key);

  final SuiClient client;

  @override
  State<StatefulWidget> createState() => _TokenMenuState();
}

class _TokenMenuState extends State<TokenMenu> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text("Menu"), centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TransferCoin(client: widget.client))
                  );
                }, child: const Text("Transfer SUI")),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ManagedToken(client: widget.client))
                  );
                }, child: const Text("Mint Token")),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ManagedNFT(client: widget.client))
                  );
                }, child: const Text("Mint NFT")),
            ],
          ),
        ),
      );
  }

}