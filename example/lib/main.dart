import 'package:example/pages/managed_token.dart';
import 'package:flutter/material.dart';
import 'package:sui/constants.dart';
import 'package:sui/cryptography/publickey.dart';
import 'package:sui/serialization/hex_buffer.dart';
import 'package:sui/sui.dart';
import 'package:sui/utils/hex.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sui Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sui Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String mnemonics ="hat amused night mixed update exhibit elephant ticket trophy diagram monitor oval";
  BigInt _balance = BigInt.zero;
  late SuiAccount account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
  late SuiClient suiClient = SuiClient(Constants.devnetAPI, account: account);

  void _requestFaucet() async {
    final resp = await suiClient.provider.getBalance(account.getAddress());
    _balance = resp.totalBalance;
    if (_balance <= BigInt.zero) {
      final faucet = FaucetClient(Constants.faucetDevAPI);
      await faucet.requestSui(account.getAddress());
    }
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _balance = _balance;
    });
  }

  void _navigateToTokenManage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ManagedToken(client: suiClient)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              Text(
                '${_balance.toString()} SUI',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _requestFaucet, child: const Text("Faucet")),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SelectableText(account.getAddress()),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: _balance != 0 ? FloatingActionButton(
        onPressed: _navigateToTokenManage,
        tooltip: 'TokenManager',
        child: const Icon(Icons.menu),
      ) : null,
    );
  }
}
