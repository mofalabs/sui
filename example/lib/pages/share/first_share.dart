import 'package:example/common/constants.dart';
import 'package:example/pages/share/info_page.dart';
import 'package:flutter/material.dart';

class FirstShare extends StatelessWidget {
  const FirstShare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Share'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _button(context, 'Account', 0),
          _button(context, 'Faucet', 1),
          _button(context, 'Transfer', 2),
        ],
      ),
    );
  }

  _button(context, name, type) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InfoPage(Constants.first_share1[type]),
            ),
          );
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
