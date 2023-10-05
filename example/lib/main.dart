import 'package:example/pages/token_menu.dart';
import 'package:flutter/material.dart';
import 'package:sui/sui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

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
  const MyHomePage({Key? key, required this.title}): super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  BigInt _balance = BigInt.zero;
  late SuiAccount account = SuiAccount.ed25519Account();
  late SuiClient suiClient = SuiClient(Constants.devnetAPI, account: account);

  void _requestFaucet() async {
    var resp = await suiClient.getBalance(account.getAddress());
    _balance = resp.totalBalance;
    if (_balance <= BigInt.zero) {
      final faucet = FaucetClient(Constants.faucetDevAPI);
      await faucet.requestSuiFromFaucetV1(account.getAddress());
    }
    await Future.delayed(const Duration(seconds: 2));

    resp = await suiClient.getBalance(account.getAddress());
    _balance = resp.totalBalance;

    setState(() {
      _balance = _balance;
    });
  }

  void _navigateToTokenManage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TokenMenu(client: suiClient)));
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
      floatingActionButton: _balance != BigInt.zero ? FloatingActionButton(
        onPressed: _navigateToTokenManage,
        tooltip: 'TokenManager',
        child: const Icon(Icons.menu),
      ) : null,
    );
  }
}
