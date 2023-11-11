import 'package:example/model/page_info.dart';
import 'package:example/pages/share/account_example.dart';
import 'package:example/pages/share/faucet_example.dart';
import 'package:example/pages/share/transfer_example.dart';

class Constants {
  static List<PageInfo> first_share1 = [
    PageInfo('Account', 'account_example.dart', const AccountExample()),
    PageInfo('Faucet', 'faucet_example.dart', const FaucetExample()),
    PageInfo('Transfer SUI', 'transfer_example.dart', const TransferExample())
  ];
}
