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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  int _balance = 0;

  void _requestFaucet() async {

    debugPrint(mnemonics); 
    final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);

    final client = SuiClient(Constants.devnetAPI);
    final resp = await client.provider.getBalance(account.getAddress());
    _balance = resp['totalBalance'];
    if (_balance <= 0) {
      final faucet = FaucetClient(Constants.faucetDevAPI);
      await faucet.requestSui(account.getAddress());
    }
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _balance = _balance;
    });
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
              Text(
                '',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _requestFaucet,
        tooltip: 'Faucet',
        child: const Icon(Icons.add),
      ),
    );
  }
}
