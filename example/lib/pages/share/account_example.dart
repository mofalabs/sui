import 'package:example/widget/markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sui/sui.dart';
import 'package:sui/utils/hex.dart';

class AccountExample extends StatefulWidget {
  const AccountExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountExampleState();
}

class _AccountExampleState extends State<AccountExample> {
  var mnemonic = '';
  var length = 12;

  int get strength => (length - 12) ~/ 3 * 32 + 128;

  var accountScheme = SignatureScheme.Secp256k1;

  SuiAccount get account {
    return SuiAccount.fromMnemonics(mnemonic, accountScheme);
  }

  List<String> introduce = [];

  var showFirst = false;
  var showSecond = false;

  @override
  void initState() {
    super.initState();
    _getCode();
    Future.delayed(const Duration(milliseconds: 250), () {
      mnemonic = SuiAccount.generateMnemonic(strength: strength);
      setState(() {});
    });
  }

  _getCode() async {
    final value = await rootBundle.loadString('assets/introduce.md');
    final list = value.split('?');
    introduce = list.sublist(0, 2);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return mnemonic.isEmpty
        ? Container()
        : ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Row(
                children: [
                  const Text(
                    'Mnemonic Length',
                    style: TextStyle(color: Colors.blue),
                  ),
                  const SizedBox(width: 30),
                  DropdownButton(
                    items: const [
                      DropdownMenuItem(value: 12, child: Text('12')),
                      DropdownMenuItem(value: 15, child: Text('15')),
                      DropdownMenuItem(value: 18, child: Text('18')),
                      DropdownMenuItem(value: 21, child: Text('21')),
                      DropdownMenuItem(value: 24, child: Text('24')),
                    ],
                    onChanged: (value) {
                      if (length != value) {
                        length = value as int;
                        mnemonic =
                            SuiAccount.generateMnemonic(strength: strength);
                        setState(() {});
                      }
                    },
                    value: length,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.code,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        showFirst = !showFirst;
                      });
                    },
                  ),
                ],
              ),
              if (showFirst && introduce.isNotEmpty) Markdown(introduce.first),
              Text(
                mnemonic,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Text(
                    'SignatureScheme type',
                    style: TextStyle(color: Colors.blue),
                  ),
                  const SizedBox(width: 30),
                  DropdownButton(
                    items: const [
                      DropdownMenuItem(
                        value: SignatureScheme.Secp256k1,
                        child: Text('Secp256k1'),
                      ),
                      DropdownMenuItem(
                        value: SignatureScheme.Secp256r1,
                        child: Text('Secp256r1'),
                      ),
                      DropdownMenuItem(
                        value: SignatureScheme.ED25519,
                        child: Text('Ed25519'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        accountScheme = value as SignatureScheme;
                      });
                    },
                    value: accountScheme,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.code,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        showSecond = !showSecond;
                      });
                    },
                  ),
                ],
              ),
              if (showSecond && introduce.isNotEmpty) Markdown(introduce.last),
              _richText('address ', account.getAddress()),
              _richText('privateKey ', account.privateKeyHex()),
              _richText('publicKey ', Hex.encode(account.getPublicKey())),
            ],
          );
  }

  _richText(name, value) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: '$name ',
        style: const TextStyle(color: Colors.green, height: 1.5),
        children: <TextSpan>[
          TextSpan(
            text: value,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
