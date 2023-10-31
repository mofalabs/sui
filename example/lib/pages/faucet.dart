
import 'package:example/components/button.dart';
import 'package:example/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:sui/sui.dart';
import 'package:sui/types/faucet.dart';

class Faucet extends StatefulWidget {
  const Faucet(this.account, {super.key});

  final SuiAccount account;

  @override
  State<StatefulWidget> createState() => _FaucetState();

}

class _FaucetState extends State<Faucet> {

  BigInt balance = BigInt.zero;

  @override
  void initState() {
    super.initState();

    suiClient.getBalance(widget.account.getAddress()).then((res) {
      setState(() {
        balance = res.totalBalance;
      });
    });
  }

  bool requestingFaucet = false;

  void _requestFaucet() async {
    if (requestingFaucet) return;

    final address = widget.account.getAddress();

    var resp = await suiClient.getBalance(address);
    balance = resp.totalBalance;
    if (balance <= BigInt.zero) {
      setState(() {
        requestingFaucet = true;
      });

      try {
        final faucet = FaucetClient(Constants.faucetDevAPI);
        final faucetResp =
            await faucet.requestSuiFromFaucetV1(address);
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

    resp = await suiClient.getBalance(address);
    setState(() {
      balance = resp.totalBalance;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: size.height / 4),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SelectableText(widget.account.getAddress(), style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              Text(
                '${balance / BigInt.from(10).pow(9)} SUI',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Button(requestingFaucet ? "Fauceting" : "Faucet", _requestFaucet),

            ],
          ),
        ),
      ),
    );
  }

}