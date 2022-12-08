
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/signers/signer_with_provider.dart';
import 'package:sui/sui_account.dart';
import 'package:sui/types/common.dart';

class SuiClient extends SignerWithProvider {
  late final SuiAccount? _account;

  SuiClient(
    String endpoint,
    {SuiAccount? account}
  ): super(endpoint) {
    _account = account;
  }

  @override
  SuiAddress getAddress() {
    return _account!.getAddress();
  }

  @override
  SignaturePubkeyPair signData(Base64DataBuffer data) {
    return _account!.signData(data);
  }

}