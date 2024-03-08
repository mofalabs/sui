import 'package:example/components/button.dart';
import 'package:example/helper/helper.dart';
import 'package:example/widget/markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sui/sui.dart';
import 'package:sui/types/faucet.dart';

class FaucetExample extends StatefulWidget {
  const FaucetExample({super.key});

  @override
  State<StatefulWidget> createState() => _FaucetExampleState();
}

class _FaucetExampleState extends State<FaucetExample> {
  BigInt balance = BigInt.zero;

  var code = '';
  SuiAccount? account;

  var network = 0;
  var showCode = false;
  final rpcUrl = [
    SuiUrls.devnet,
    SuiUrls.testnet,
  ];
  final faucetUrl = [
    SuiUrls.faucetDev,
    SuiUrls.faucetTest,
  ];

  @override
  void initState() {
    super.initState();
    _getCode();
    account = SuiAccount.ed25519Account();
    setState(() {});
    _getBalance();
  }

  _getCode() async {
    final value = await rootBundle.loadString('assets/introduce.md');
    final list = value.split('?');
    code = list[2];
    setState(() {});
  }

  bool requestingFaucet = false;

  _getBalance() async {
    final coinBalance =
        await SuiClient(rpcUrl[network]).getBalance(account!.getAddress());
    setState(() {
      balance = coinBalance.totalBalance;
    });
  }

  void _requestFaucet() async {
    if (requestingFaucet) return;
    final address = account!.getAddress();
    _getBalance();
    if (balance <= BigInt.zero) {
      setState(() {
        requestingFaucet = true;
      });
      try {
        final faucet = FaucetClient(faucetUrl[network]);
        final faucetResp = await faucet.requestSuiFromFaucetV1(address);
        if (faucetResp.task != null) {
          while (true) {
            final statusResp =
                await faucet.getFaucetRequestStatus(faucetResp.task!);
            if (statusResp.status.status == BatchSendStatus.SUCCEEDED) {
              break;
            } else {
              await Future.delayed(const Duration(seconds: 3));
            }
          }
        }
      } catch (e) {
        showSnackBar(context, e.toString());
      } finally {
        setState(() {
          requestingFaucet = false;
        });
      }
    }
    _getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: account == null ? Container() : _buildConnect(),
    );
  }

  _buildConnect() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        Row(
          children: [
            const Text(
              'SUI Network',
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(width: 30),
            DropdownButton(
              items: const [
                DropdownMenuItem(value: 0, child: Text('devnet')),
                DropdownMenuItem(value: 1, child: Text('testnet')),
              ],
              onChanged: (value) {
                network = value ?? 0;
                _getBalance();
              },
              value: network,
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.code,
                color: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  showCode = !showCode;
                });
              },
            ),
          ],
        ),
        if (showCode && code.isNotEmpty) Markdown(code),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SelectableText(
            account?.getAddress() ?? "",
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '${balance / BigInt.from(10).pow(9)} SUI',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        Button(requestingFaucet ? "Fauceting" : "Faucet", _requestFaucet),
      ],
    );
  }
}
