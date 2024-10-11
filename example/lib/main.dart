import 'package:example/pages/faucet.dart';
import 'package:example/pages/home.dart';
import 'package:example/pages/merge.dart';
import 'package:example/pages/share_example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:sui/sui.dart';

import 'helper/helper.dart';
import 'pages/split.dart';
import 'pages/token_menu.dart';
import 'pages/transfer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sui Dart Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(84, 150, 229, 1),
          selectionColor: Colors.yellow,
          selectionHandleColor: Colors.black,
        ),
      ),
      home: const MyHomePage(title: 'Sui Dart Demo'),
      builder: FToastBuilder(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SuiAccount? account;

  String localNetwork = "devnet";

  @override
  void initState() {
    super.initState();

    getLocalSuiAccount().then((value) {
      setState(() {
        account = value;
      });
    });
  }

  void _navigateToTokenManage() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TokenMenu(client: suiClient)));
  }

  int menuIndex = 0;

  Widget contentPage(int menuIndex) {
    if (account == null) return Container();

    final acc = account!;
    switch (menuIndex) {
      case 0:
        return const Home();
      case 1:
        return Faucet(acc);
      case 2:
        return SplitPage(acc);
      case 3:
        return Merge(acc);
      case 4:
        return Transfer(acc);
    }

    return Container();
  }

  void menuClick(int menu) {
    setState(() {
      menuIndex = menu;
    });
  }

  void switchNet(String network) {
    switch (network) {
      case "devnet":
        suiClient = SuiClient(SuiUrls.devnet);
        localNetwork = "devnet";
        break;
      case "testnet":
        suiClient = SuiClient(SuiUrls.testnet);
        localNetwork = "testnet";
        break;
      case "mainnet":
        suiClient = SuiClient(SuiUrls.mainnet);
        localNetwork = "mainnet";
        break;
    }

    menuClick(0);
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
        onFocusGained: () {
          // _requestFaucet();
        },
        child: Scaffold(
          appBar: AppBar(title: Text(widget.title), actions: [
            MenuAnchor(
                builder: (context, controller, child) {
                  return CupertinoButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      child: Text(localNetwork,
                          style: const TextStyle(color: Colors.white)));
                },
                menuChildren: [
                  MenuItemButton(
                      child: const SizedBox(
                          width: 80,
                          child: Text("devnet", textAlign: TextAlign.center)),
                      onPressed: () {
                        switchNet("devnet");
                      }),
                  MenuItemButton(
                      child: const SizedBox(
                          width: 80,
                          child: Text("testnet", textAlign: TextAlign.center)),
                      onPressed: () {
                        switchNet("testnet");
                      }),
                  MenuItemButton(
                      child: const SizedBox(
                          width: 80,
                          child: Text("mainnet", textAlign: TextAlign.center)),
                      onPressed: () {
                        switchNet("mainnet");
                      }),
                ]),
          ]),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(84, 150, 229, 1)),
                    child: Center(
                      child: Column(
                        children: [
                          const Text("Sui Dart",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          const SizedBox(height: 30),
                          if (account != null)
                            SelectableText(
                              account!.getAddress(),
                              showCursor: true,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                              onTap: () {
                                print(account!.getAddress());
                              },
                            ),
                        ],
                      ),
                    )),
                ListTile(
                  title: const Text("Home"),
                  onTap: () {
                    Navigator.pop(context);
                    menuClick(0);
                  },
                ),
                ListTile(
                  title: const Text("Faucet"),
                  onTap: () {
                    Navigator.pop(context);
                    menuClick(1);
                  },
                ),
                ListTile(
                  title: const Text("Split SUI"),
                  onTap: () {
                    Navigator.pop(context);
                    menuClick(2);
                  },
                ),
                ListTile(
                  title: const Text(("Merge Sui")),
                  onTap: () {
                    Navigator.pop(context);
                    menuClick(3);
                  },
                ),
                ListTile(
                  title: const Text(("Transfer Sui")),
                  onTap: () {
                    Navigator.pop(context);
                    menuClick(4);
                  },
                ),
                ListTile(
                  title: const Text(("Share example")),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShareDemo(),
                      ),
                    );
                  },
                ),
                // ListTile(
                //   title: const Text(("Publish Package")),
                //   onTap: () {
                //     print("tap Publish...");
                //   },
                // )
              ],
            ),
          ),
          body: Center(child: contentPage(menuIndex)),
        ));
  }
}
