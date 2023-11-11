import 'package:example/pages/share/first_share.dart';
import 'package:flutter/material.dart';

class ShareDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share example'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _button(context, 'Mnemonic/Account/Faucet/Transfer', 1),
        ],
      ),
    );
  }

  _button(context, name, type) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
      child: ElevatedButton(
        onPressed: () {
          if (type == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FirstShare(),
              ),
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: 40,
          child: Text(name),
        ),
      ),
    );
  }
}
