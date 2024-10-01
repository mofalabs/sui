import 'dart:typed_data';

import 'package:bcs/bcs.dart';
import 'package:bcs/bcs_type.dart';
import 'package:sui/bcs/type_tag_serializer.dart';
import 'package:sui/types/common.dart';

class SuiBcs {

  static const SUI_ADDRESS_LENGTH = 32;

	static final U8 = Bcs.u8();
	static final U16 = Bcs.u16();
	static final U32 = Bcs.u32();
	static final U64 = Bcs.u64();
	static final U128 = Bcs.u128();
	static final U256 = Bcs.u256();
	static final ULEB128 = Bcs.uleb128();
  static final BOOL = Bcs.boolean();
	static final STRING = Bcs.string();
  static final VECTOR = Bcs.vector;

  static BcsType<int, dynamic> unsafe_u64([BcsTypeOptions<int, dynamic>? options]) {
    return Bcs.u64(
      BcsTypeOptions(
        name: 'unsafe_u64',
        validate: options?.validate,
      )
    ).transform(
      input: (dynamic val) => val is int ? val : int.parse(val.toString()),
      output: (BigInt val) => val.toInt(),
    );
  }

  static BcsType<Map<String, dynamic>, dynamic> OptionEnum<T>(BcsType<T, dynamic> type) {
    return Bcs.enumeration('Option', {
      'None': null,
      'Some': type,
    });
  }

  static final Address = Bcs.bytes(SUI_ADDRESS_LENGTH).transform(
    validate: (dynamic val) {
      final address = val is String ? val : toHEX(val);
      if (address.isEmpty || !isValidSuiAddress(normalizeSuiAddress(address))) {
        throw Exception('Invalid Sui address $address');
      }
    },
    input: (dynamic val) => 
      val is String ? fromHEX(normalizeSuiAddress(val)) : val,
    output: (Uint8List val) => normalizeSuiAddress(toHEX(val)),
  );

  static final ObjectDigest = Bcs.vector(Bcs.u8()).transform(
    name: 'ObjectDigest',
    input: (String value) => fromB58(value),
    output: (List<int> value) => toB58(Uint8List.fromList(value)),
    validate: (String value) {
      if (fromB58(value).length != 32) {
        throw Exception('ObjectDigest must be 32 bytes');
      }
    },
  );

  static final SuiObjectRef = Bcs.struct('SuiObjectRef', {
    'objectId': Address,
    'version': Bcs.u64(),
    'digest': ObjectDigest,
  });

  static final SharedObjectRef = Bcs.struct('SharedObjectRef', {
    'objectId': Address,
    'initialSharedVersion': Bcs.u64(),
    'mutable': Bcs.boolean(),
  });

  static final ObjectArg = Bcs.enumeration('ObjectArg', {
    'ImmOrOwnedObject': SuiObjectRef,
    'SharedObject': SharedObjectRef,
    'Receiving': SuiObjectRef,
  });

  static final CallArg = Bcs.enumeration('CallArg', {
    'Pure': Bcs.struct('Pure', {
      'bytes': Bcs.vector(Bcs.u8()).transform(
        input: (dynamic val) => val is String ? fromB64(val) : val,
        output: (List<int> val) => toB64(Uint8List.fromList(val)),
      ),
    }),
    'Object': ObjectArg,
  });

  static final BcsType<dynamic, dynamic> InnerTypeTag = Bcs.enumeration('TypeTag', {
    'bool': null,
    'u8': null,
    'u64': null,
    'u128': null,
    'address': null,
    'signer': null,
    'vector': Bcs.lazy(() => InnerTypeTag),
    'struct': Bcs.lazy(() => StructTag),
    'u16': null,
    'u32': null,
    'u256': null,
  }) as BcsType<dynamic, dynamic>;

  static final TypeTag = InnerTypeTag.transform(
    input: (dynamic typeTag) => 
      typeTag is String ? TypeTagSerializer.parseFromStr(typeTag, true) : typeTag,
    output: (dynamic typeTag) => TypeTagSerializer.tagToString(typeTag),
  );

  static final Argument = Bcs.enumeration('Argument', {
    'GasCoin': null,
    'Input': Bcs.u16(),
    'Result': Bcs.u16(),
    'NestedResult': Bcs.tuple([Bcs.u16(), Bcs.u16()]),
  });

  static final ProgrammableMoveCall = Bcs.struct('ProgrammableMoveCall', {
    'package': Address,
    'module': Bcs.string(),
    'function': Bcs.string(),
    'typeArguments': Bcs.vector(TypeTag),
    'arguments': Bcs.vector(Argument),
  });

  static final Command = Bcs.enumeration('Command', {
    'MoveCall': ProgrammableMoveCall,
    'TransferObjects': Bcs.struct('TransferObjects', {
      'objects': Bcs.vector(Argument),
      'address': Argument,
    }),
    'SplitCoins': Bcs.struct('SplitCoins', {
      'coin': Argument,
      'amounts': Bcs.vector(Argument),
    }),
    'MergeCoins': Bcs.struct('MergeCoins', {
      'destination': Argument,
      'sources': Bcs.vector(Argument),
    }),
    'Publish': Bcs.struct('Publish', {
      'modules': Bcs.vector(
        Bcs.vector(Bcs.u8()).transform(
          input: (dynamic val) => val is String ? fromB64(val) : val,
          output: (List<int> val) => toB64(Uint8List.fromList(val)),
        ),
      ),
      'dependencies': Bcs.vector(Address),
    }),
    'MakeMoveVec': Bcs.struct('MakeMoveVec', {
      'type': OptionEnum(TypeTag).transform(
        input: (dynamic val) => 
          val == null ? {'None': true} : {'Some': val},
        output: (Map<String, dynamic> val) => val['Some'],
      ),
      'elements': Bcs.vector(Argument),
    }),
    'Upgrade': Bcs.struct('Upgrade', {
      'modules': Bcs.vector(
        Bcs.vector(Bcs.u8()).transform(
          input: (dynamic val) => val is String ? fromB64(val) : val,
          output: (List<int> val) => toB64(Uint8List.fromList(val)),
        ),
      ),
      'dependencies': Bcs.vector(Address),
      'package': Address,
      'ticket': Argument,
    }),
  });

  static final ProgrammableTransaction = Bcs.struct('ProgrammableTransaction', {
    'inputs': Bcs.vector(CallArg),
    'commands': Bcs.vector(Command),
  });

  static final TransactionKind = Bcs.enumeration('TransactionKind', {
    'ProgrammableTransaction': ProgrammableTransaction,
    'ChangeEpoch': null,
    'Genesis': null,
    'ConsensusCommitPrologue': null,
  });

  static final TransactionExpiration = Bcs.enumeration('TransactionExpiration', {
    'None': null,
    'Epoch': unsafe_u64(),
  });

  static final StructTag = Bcs.struct('StructTag', {
    'address': Address,
    'module': Bcs.string(),
    'name': Bcs.string(),
    'typeParams': Bcs.vector(InnerTypeTag),
  });

  static final GasData = Bcs.struct('GasData', {
    'payment': Bcs.vector(SuiObjectRef),
    'owner': Address,
    'price': Bcs.u64(),
    'budget': Bcs.u64(),
  });

  static final TransactionDataV1 = Bcs.struct('TransactionDataV1', {
    'kind': TransactionKind,
    'sender': Address,
    'gasData': GasData,
    'expiration': TransactionExpiration,
  });

  static final TransactionData = Bcs.enumeration('TransactionData', {
    'V1': TransactionDataV1,
  });

  static final IntentScope = Bcs.enumeration('IntentScope', {
    'TransactionData': null,
    'TransactionEffects': null,
    'CheckpointSummary': null,
    'PersonalMessage': null,
  });

  static final IntentVersion = Bcs.enumeration('IntentVersion', {
    'V0': null,
  });

  static final AppId = Bcs.enumeration('AppId', {
    'Sui': null,
  });

  static final Intent = Bcs.struct('Intent', {
    'scope': IntentScope,
    'version': IntentVersion,
    'appId': AppId,
  });

  static BcsType<Map<String, dynamic>, dynamic> IntentMessage<T>(BcsType<T, dynamic> T) {
    return Bcs.struct('IntentMessage<${T.name}>', {
      'intent': Intent,
      'value': T,
    });
  }

  static final CompressedSignature = Bcs.enumeration('CompressedSignature', {
    'Ed25519': Bcs.fixedArray(64, Bcs.u8()),
    'Secp256k1': Bcs.fixedArray(64, Bcs.u8()),
    'Secp256r1': Bcs.fixedArray(64, Bcs.u8()),
    'ZkLogin': Bcs.vector(Bcs.u8()),
  });

  static final PublicKey = Bcs.enumeration('PublicKey', {
    'Ed25519': Bcs.fixedArray(32, Bcs.u8()),
    'Secp256k1': Bcs.fixedArray(33, Bcs.u8()),
    'Secp256r1': Bcs.fixedArray(33, Bcs.u8()),
    'ZkLogin': Bcs.vector(Bcs.u8()),
  });

  static final MultiSigPkMap = Bcs.struct('MultiSigPkMap', {
    'pubKey': PublicKey,
    'weight': Bcs.u8(),
  });

  static final MultiSigPublicKey = Bcs.struct('MultiSigPublicKey', {
    'pk_map': Bcs.vector(MultiSigPkMap),
    'threshold': Bcs.u16(),
  });

  static final MultiSig = Bcs.struct('MultiSig', {
    'sigs': Bcs.vector(CompressedSignature),
    'bitmap': Bcs.u16(),
    'multisig_pk': MultiSigPublicKey,
  });

  static final base64String = Bcs.vector(Bcs.u8()).transform(
    input: (dynamic val) => val is String ? fromB64(val) : val,
    output: (List<int> val) => toB64(Uint8List.fromList(val)),
  );

  static final SenderSignedTransaction = Bcs.struct('SenderSignedTransaction', {
    'intentMessage': IntentMessage(TransactionData),
    'txSignatures': Bcs.vector(base64String),
  });

  static final SenderSignedData = Bcs.vector(SenderSignedTransaction, BcsTypeOptions(name: 'SenderSignedData'));

}