import 'package:example/pages/token_menu.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:sui/sui.dart';
import 'package:sui/types/faucet.dart';

import 'helper/helper.dart';

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
  late SuiClient suiClient;
  SuiAccount? account;

  @override
  void initState() {
    super.initState();

    getLocalSuiAccount().then((value) {
      setState(() {
        account = value;
        suiClient = SuiClient(Constants.devnetAPI, account: account);
      });
    });
  }

  bool requestingFaucet = false;

  void _requestFaucet() async {
    if (requestingFaucet || account == null) return;

    var resp = await suiClient.getBalance(account!.getAddress());
    _balance = resp.totalBalance;
    if (_balance <= BigInt.zero) {
      setState(() {
        requestingFaucet = true;
      });

      try {
        final faucet = FaucetClient(Constants.faucetDevAPI);
        final faucetResp = await faucet.requestSuiFromFaucetV1(account!.getAddress());
        if (faucetResp.task != null) {
          while(true) {
            final statusResp = await faucet.getFaucetRequestStatus(faucetResp.task!);
            if (statusResp.status.status == BatchSendStatus.SUCCEEDED) {
              break;
            } else {
              await Future.delayed(const Duration(seconds: 3));
            }
          }
        } 
      } finally {
        setState(() {
          requestingFaucet = false;
        });
      }
    }

    resp = await suiClient.getBalance(account!.getAddress());
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
    return FocusDetector(
      onFocusGained: () {
        _requestFaucet();
      },
      child:Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              Text(
                '${_balance / BigInt.from(10).pow(9)} SUI',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _requestFaucet, 
                child: Text(requestingFaucet ? "Inprogress" : "Faucet")),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SelectableText(account?.getAddress() ?? ''),
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
    ));
  }
}
