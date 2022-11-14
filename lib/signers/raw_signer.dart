
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/signers/signer_with_provider.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/types/common.dart';

class RawSigner extends SignerWithProvider {
  late final Keypair _keypair;

  RawSigner(
    Keypair keypair,
    {String? endpoint,
    bool? skipDataValidation,
    TxnDataSerializer? serializer}
  ): super(endpoint ?? "", skipDataValidation ?? true, serializer) {
    _keypair = keypair;
  }

  @override
  SuiAddress getAddress() {
    return _keypair.getPublicKey().toSuiAddress();
  }

  @override
  SignaturePubkeyPair signData(Base64DataBuffer data) {
    return SignaturePubkeyPair(
      _keypair.getKeyScheme(),
      _keypair.signData(data),
      _keypair.getPublicKey()
    );
  }
}
