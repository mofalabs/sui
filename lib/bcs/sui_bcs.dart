import 'dart:convert';

import 'dart:typed_data';

import 'package:bcs/bcs.dart';
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
  static const VECTOR = Bcs.vector;

  static BcsType<int, dynamic> unsafe_u64([
    BcsTypeOptions<int, dynamic>? options,
  ]) {
    return Bcs.u64(
      BcsTypeOptions(name: 'unsafe_u64', validate: options?.validate),
    ).transform(
      input: (dynamic val) => val is int ? val : int.parse(val.toString()),
      output: (BigInt val) => val.toInt(),
    );
  }

  static BcsType<Map<String, dynamic>, dynamic> OptionEnum<T>(
    BcsType<T, dynamic> type,
  ) {
    return Bcs.enumeration('Option', {'None': null, 'Some': type});
  }

  static final Address = Bcs.bytes(SUI_ADDRESS_LENGTH).transform(
    validate: (dynamic val) {
      final address = val is String ? val : hexEncode(val);
      if (address.isEmpty || !isValidSuiAddress(normalizeSuiAddress(address))) {
        throw Exception('Invalid Sui address $address');
      }
    },
    input: (dynamic val) =>
        val is String ? hexDecode(normalizeSuiAddress(val)) : val,
    output: (Uint8List val) => normalizeSuiAddress(hexEncode(val)),
  );

  static final ObjectDigest = Bcs.vector(Bcs.u8()).transform(
    name: 'ObjectDigest',
    input: (String value) => base58Decode(value),
    output: (List<int> value) => base58Encode(Uint8List.fromList(value)),
    validate: (String value) {
      if (base58Decode(value).length != 32) {
        throw Exception('ObjectDigest must be 32 bytes');
      }
    },
  );

  /// Object versions are `u64` on the wire but represented as `int` across
  /// the SDK (`SuiObjectRef.version`), so parse them back to `int`.
  static final _version = Bcs.u64().transform(
    input: (dynamic value) => value,
    output: (value) => value.toInt(),
  );

  static final SuiObjectRef = Bcs.struct('SuiObjectRef', {
    'objectId': Address,
    'version': _version,
    'digest': ObjectDigest,
  });

  static final SharedObjectRef = Bcs.struct('SharedObjectRef', {
    'objectId': Address,
    'initialSharedVersion': _version,
    'mutable': Bcs.boolean(),
  });

  static final ObjectArg = Bcs.enumeration('ObjectArg', {
    'ImmOrOwnedObject': SuiObjectRef,
    'SharedObject': SharedObjectRef,
    'Receiving': SuiObjectRef,
  });

  // Address-balance withdrawal input, enabling Sui gasless stablecoin
  // transfers. A FundsWithdrawal CallArg reserves an amount from the sender's
  // per-address balance; `0x2::balance::redeem_funds<T>` then materializes it
  // into a `Balance<T>`. Encoded per the on-chain transaction format
  // (sui-types `CallArg::FundsWithdrawal`).
  static final Reservation = Bcs.enumeration('Reservation', {
    'MaxAmountU64': Bcs.u64(),
  });

  static final WithdrawalType = Bcs.enumeration('WithdrawalType', {
    'Balance': Bcs.lazy(() => TypeTag),
  });

  static final WithdrawFrom = Bcs.enumeration('WithdrawFrom', {
    'Sender': null,
    'Sponsor': null,
    'SenderAllowance': Bcs.struct('SenderAllowance', {
      'funder': Address,
      'allowance': Address,
    }),
  });

  static final FundsWithdrawal = Bcs.struct('FundsWithdrawal', {
    'reservation': Reservation,
    'typeArg': WithdrawalType,
    'withdrawFrom': WithdrawFrom,
  });

  // Variant order is fixed by the on-chain transaction format: the index is
  // the on-wire BCS tag, so Pure(0), Object(1), FundsWithdrawal(2) must not be
  // reordered.
  static final CallArg = Bcs.enumeration('CallArg', {
    'Pure': Bcs.struct('Pure', {
      'bytes': Bcs.vector(Bcs.u8()).transform(
        input: (dynamic val) => val is String ? base64Decode(val) : val,
        output: (List<int> val) => base64Encode(Uint8List.fromList(val)),
      ),
    }),
    'Object': ObjectArg,
    'FundsWithdrawal': FundsWithdrawal,
  });

  static final BcsType<dynamic, dynamic> InnerTypeTag =
      Bcs.enumeration('TypeTag', {
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
          })
          as BcsType<dynamic, dynamic>;

  static final TypeTag = InnerTypeTag.transform(
    input: (dynamic typeTag) => typeTag is String
        ? TypeTagSerializer.parseFromStr(typeTag, true)
        : typeTag,
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
          input: (dynamic val) => val is String ? base64Decode(val) : val,
          output: (List<int> val) => base64Encode(Uint8List.fromList(val)),
        ),
      ),
      'dependencies': Bcs.vector(Address),
    }),
    'MakeMoveVec': Bcs.struct('MakeMoveVec', {
      'type': OptionEnum(TypeTag).transform(
        input: (dynamic val) => val == null ? {'None': true} : {'Some': val},
        output: (Map<String, dynamic> val) => val['Some'],
      ),
      'elements': Bcs.vector(Argument),
    }),
    'Upgrade': Bcs.struct('Upgrade', {
      'modules': Bcs.vector(
        Bcs.vector(Bcs.u8()).transform(
          input: (dynamic val) => val is String ? base64Decode(val) : val,
          output: (List<int> val) => base64Encode(Uint8List.fromList(val)),
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

  /// Validity window for a transaction with no gas payment (an address-balance
  /// / gasless transaction): bounded epochs or timestamps plus a nonce, so
  /// validators only need to retain the digest for the window to prevent
  /// equivocation. `chain` is the chain identifier (the genesis checkpoint
  /// digest, base58).
  static final ValidDuring = Bcs.struct('ValidDuring', {
    'minEpoch': Bcs.option(Bcs.u64()),
    'maxEpoch': Bcs.option(Bcs.u64()),
    'minTimestamp': Bcs.option(Bcs.u64()),
    'maxTimestamp': Bcs.option(Bcs.u64()),
    'chain': ObjectDigest,
    'nonce': Bcs.u32(),
  });

  static final AllowedProposers = Bcs.struct('AllowedProposers', {
    'epoch': Bcs.u64(),
    'proposers': Bcs.vector(Bcs.u32()).transform(
      input: (dynamic input) {
        final values = List<int>.from(input as List);
        validateAllowedProposers(values);
        return values;
      },
      output: (List<int> values) {
        if (values.isEmpty) {
          throw const FormatException('Allowed proposers must not be empty');
        }
        return values;
      },
    ),
  });

  static void validateAllowedProposers(List<int> values) {
    if (values.isEmpty) {
      throw ArgumentError('Allowed proposers must not be empty');
    }
    for (var i = 0; i < values.length; i++) {
      if (values[i] < 0 ||
          values[i] > 0xffffffff ||
          (i > 0 && values[i] <= values[i - 1])) {
        throw ArgumentError(
          'Allowed proposers must be strictly increasing u32 values',
        );
      }
    }
  }

  static final Validity = Bcs.struct('Validity', {
    'minEpoch': Bcs.option(Bcs.u64()),
    'maxEpoch': Bcs.option(Bcs.u64()),
    'minTimestamp': Bcs.option(Bcs.u64()),
    'maxTimestamp': Bcs.option(Bcs.u64()),
    'chain': ObjectDigest,
    'nonce': Bcs.u32(),
    'allowedProposers': Bcs.option(AllowedProposers),
  });

  // Variant order is fixed by the on-chain transaction format:
  // None(0), Epoch(1), ValidDuring(2) must not be reordered.
  static final TransactionExpiration =
      Bcs.enumeration('TransactionExpiration', {
        'None': null,
        'Epoch': unsafe_u64(),
        'ValidDuring': ValidDuring,
        'Validity': Validity,
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

  static final IntentVersion = Bcs.enumeration('IntentVersion', {'V0': null});

  static final AppId = Bcs.enumeration('AppId', {'Sui': null});

  static final Intent = Bcs.struct('Intent', {
    'scope': IntentScope,
    'version': IntentVersion,
    'appId': AppId,
  });

  static BcsType<Map<String, dynamic>, dynamic> IntentMessage<T>(
    BcsType<T, dynamic> T,
  ) {
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
    'Passkey': Bcs.vector(Bcs.u8()),
    'MLDSA65': Bcs.fixedArray(3309, Bcs.u8()),
  });

  static final PublicKey = Bcs.enumeration('PublicKey', {
    'Ed25519': Bcs.fixedArray(32, Bcs.u8()),
    'Secp256k1': Bcs.fixedArray(33, Bcs.u8()),
    'Secp256r1': Bcs.fixedArray(33, Bcs.u8()),
    'ZkLogin': Bcs.vector(Bcs.u8()),
    'Passkey': Bcs.fixedArray(33, Bcs.u8()),
    'MLDSA65': Bcs.fixedArray(1952, Bcs.u8()),
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

  /// SIP-9 passkey authenticator. The serialized passkey signature is
  /// `flag(0x06) || BCS(PasskeyAuthenticator)`, where `userSignature` itself is
  /// `flag(secp256r1=0x02) || 64-byte-sig || 33-byte-compressed-pubkey`.
  static final PasskeyAuthenticator = Bcs.struct('PasskeyAuthenticator', {
    'authenticatorData': Bcs.vector(Bcs.u8()),
    'clientDataJson': Bcs.string(),
    'userSignature': Bcs.vector(Bcs.u8()),
  });

  static final base64String = Bcs.vector(Bcs.u8()).transform(
    input: (dynamic val) => val is String ? base64Decode(val) : val,
    output: (List<int> val) => base64Encode(Uint8List.fromList(val)),
  );

  static final SenderSignedTransaction = Bcs.struct('SenderSignedTransaction', {
    'intentMessage': IntentMessage(TransactionData),
    'txSignatures': Bcs.vector(base64String),
  });

  static final SenderSignedData = Bcs.vector(
    SenderSignedTransaction,
    BcsTypeOptions(name: 'SenderSignedData'),
  );

  // Copyright (c) Mysten Labs, Inc. SPDX-License-Identifier: Apache-2.0
  // System transaction and effects schemas ported from MystenLabs/ts-sdks
  // de91ff2f (Apache-2.0); enum order is the on-chain BCS discriminant.
  static final Owner = Bcs.enumeration('Owner', {
    'AddressOwner': Address,
    'ObjectOwner': Address,
    'Shared': Bcs.struct('Shared', {'initialSharedVersion': Bcs.u64()}),
    'Immutable': null,
    'ConsensusAddressOwner': Bcs.struct('ConsensusAddressOwner', {
      'startVersion': Bcs.u64(),
      'owner': Address,
    }),
  });

  static final MoveObjectType = Bcs.enumeration('MoveObjectType', {
    'Other': StructTag,
    'GasCoin': null,
    'StakedSui': null,
    'Coin': TypeTag,
    'AccumulatorBalanceWrapper': null,
  });

  static final TypeOrigin = Bcs.struct('TypeOrigin', {
    'moduleName': Bcs.string(),
    'datatypeName': Bcs.string(),
    'package': Address,
  });

  static final UpgradeInfo = Bcs.struct('UpgradeInfo', {
    'upgradedId': Address,
    'upgradedVersion': Bcs.u64(),
  });

  static final MovePackage = Bcs.struct('MovePackage', {
    'id': Address,
    'version': Bcs.u64(),
    'moduleMap': Bcs.map(Bcs.string(), Bcs.vector(Bcs.u8())),
    'typeOriginTable': Bcs.vector(TypeOrigin),
    'linkageTable': Bcs.map(Address, UpgradeInfo),
  });

  static final MoveObject = Bcs.struct('MoveObject', {
    'type': MoveObjectType,
    'hasPublicTransfer': Bcs.boolean(),
    'version': Bcs.u64(),
    'contents': Bcs.vector(Bcs.u8()),
  });

  static final Data = Bcs.enumeration('Data', {
    'Move': MoveObject,
    'Package': MovePackage,
  });

  static final ObjectInner = Bcs.struct('ObjectInner', {
    'data': Data,
    'owner': Owner,
    'previousTransaction': ObjectDigest,
    'storageRebate': Bcs.u64(),
  });
  static final ChangeEpoch = Bcs.struct('ChangeEpoch', {
    'epoch': Bcs.u64(),
    'protocolVersion': Bcs.u64(),
    'storageCharge': Bcs.u64(),
    'computationCharge': Bcs.u64(),
    'storageRebate': Bcs.u64(),
    'nonRefundableStorageFee': Bcs.u64(),
    'epochStartTimestampMs': Bcs.u64(),
    'systemPackages': Bcs.vector(
      Bcs.tuple([
        Bcs.u64(),
        Bcs.vector(Bcs.vector(Bcs.u8())),
        Bcs.vector(Address),
      ]),
    ),
  });

  static final GenesisObject = Bcs.enumeration('GenesisObject', {
    'RawObject': Bcs.struct('RawObject', {'data': Data, 'owner': Owner}),
  });

  static final GenesisTransaction = Bcs.struct('GenesisTransaction', {
    'objects': Bcs.vector(GenesisObject),
  });

  static final ConsensusCommitPrologue = Bcs.struct('ConsensusCommitPrologue', {
    'epoch': Bcs.u64(),
    'round': Bcs.u64(),
    'commitTimestampMs': Bcs.u64(),
  });

  static final ConsensusCommitPrologueV2 =
      Bcs.struct('ConsensusCommitPrologueV2', {
        'epoch': Bcs.u64(),
        'round': Bcs.u64(),
        'commitTimestampMs': Bcs.u64(),
        'consensusCommitDigest': ObjectDigest,
      });

  static final ConsensusDeterminedVersionAssignments = Bcs.enumeration(
    'ConsensusDeterminedVersionAssignments',
    {
      'CancelledTransactions': Bcs.vector(
        Bcs.tuple([
          ObjectDigest,
          Bcs.vector(Bcs.tuple([Address, Bcs.u64()])),
        ]),
      ),
      'CancelledTransactionsV2': Bcs.vector(
        Bcs.tuple([
          ObjectDigest,
          Bcs.vector(
            Bcs.tuple([
              Bcs.tuple([Address, Bcs.u64()]),
              Bcs.u64(),
            ]),
          ),
        ]),
      ),
    },
  );

  static final ConsensusCommitPrologueV3 =
      Bcs.struct('ConsensusCommitPrologueV3', {
        'epoch': Bcs.u64(),
        'round': Bcs.u64(),
        'subDagIndex': Bcs.option(Bcs.u64()),
        'commitTimestampMs': Bcs.u64(),
        'consensusCommitDigest': ObjectDigest,
        'consensusDeterminedVersionAssignments':
            ConsensusDeterminedVersionAssignments,
      });

  static final ConsensusCommitPrologueV4 =
      Bcs.struct('ConsensusCommitPrologueV4', {
        'epoch': Bcs.u64(),
        'round': Bcs.u64(),
        'subDagIndex': Bcs.option(Bcs.u64()),
        'commitTimestampMs': Bcs.u64(),
        'consensusCommitDigest': ObjectDigest,
        'consensusDeterminedVersionAssignments':
            ConsensusDeterminedVersionAssignments,
        'additionalStateDigest': ObjectDigest,
      });

  static final ActiveJwk = Bcs.struct('ActiveJwk', {
    'jwkId': Bcs.struct('JwkId', {'iss': Bcs.string(), 'kid': Bcs.string()}),
    'jwk': Bcs.struct('JWK', {
      'kty': Bcs.string(),
      'e': Bcs.string(),
      'n': Bcs.string(),
      'alg': Bcs.string(),
    }),
    'epoch': Bcs.u64(),
  });

  static final AuthenticatorStateUpdate =
      Bcs.struct('AuthenticatorStateUpdate', {
        'epoch': Bcs.u64(),
        'round': Bcs.u64(),
        'newActiveJwks': Bcs.vector(ActiveJwk),
        'authenticatorObjInitialSharedVersion': Bcs.u64(),
      });

  static final RandomnessStateUpdate = Bcs.struct('RandomnessStateUpdate', {
    'epoch': Bcs.u64(),
    'randomnessRound': Bcs.u64(),
    'randomBytes': Bcs.vector(Bcs.u8()),
    'randomnessObjInitialSharedVersion': Bcs.u64(),
  });

  static final AuthenticatorStateExpire = Bcs.struct(
    'AuthenticatorStateExpire',
    {'minEpoch': Bcs.u64(), 'authenticatorObjInitialSharedVersion': Bcs.u64()},
  );

  static final ExecutionTimeObservationKey = Bcs.enumeration(
    'ExecutionTimeObservationKey',
    {
      'MoveEntryPoint': Bcs.struct('MoveEntryPoint', {
        'package': Address,
        'module': Bcs.string(),
        'function': Bcs.string(),
        'typeArguments': Bcs.vector(TypeTag),
      }),
      'TransferObjects': null,
      'SplitCoins': null,
      'MergeCoins': null,
      'Publish': null,
      'MakeMoveVec': null,
      'Upgrade': null,
    },
  );

  static final StoredExecutionTimeObservations = Bcs.enumeration(
    'StoredExecutionTimeObservations',
    {
      'V1': Bcs.vector(
        Bcs.tuple([
          ExecutionTimeObservationKey,
          Bcs.vector(
            Bcs.tuple([
              Bcs.vector(Bcs.u8()),
              Bcs.struct('Duration', {'secs': Bcs.u64(), 'nanos': Bcs.u32()}),
            ]),
          ),
        ]),
      ),
    },
  );

  static final WriteAccumulatorStorageCost = Bcs.struct(
    'WriteAccumulatorStorageCost',
    {'storageCost': Bcs.u64()},
  );

  static final EndOfEpochTransactionKind =
      Bcs.enumeration('EndOfEpochTransactionKind', {
        'ChangeEpoch': ChangeEpoch,
        'AuthenticatorStateCreate': null,
        'AuthenticatorStateExpire': AuthenticatorStateExpire,
        'RandomnessStateCreate': null,
        'DenyListStateCreate': null,

        'BridgeStateCreate': ObjectDigest,
        'BridgeCommitteeInit': Bcs.u64(),
        'StoreExecutionTimeObservations': StoredExecutionTimeObservations,
        'AccumulatorRootCreate': null,
        'CoinRegistryCreate': null,
        'DisplayRegistryCreate': null,
        'AddressAliasStateCreate': null,
        'WriteAccumulatorStorageCost': WriteAccumulatorStorageCost,
        'ForwardingAddressRegistryCreate': null,
      });

  static final TransactionKind = Bcs.enumeration('TransactionKind', {
    'ProgrammableTransaction': ProgrammableTransaction,
    'ChangeEpoch': ChangeEpoch,
    'Genesis': GenesisTransaction,
    'ConsensusCommitPrologue': ConsensusCommitPrologue,
    'AuthenticatorStateUpdate': AuthenticatorStateUpdate,
    'EndOfEpochTransaction': Bcs.vector(EndOfEpochTransactionKind),
    'RandomnessStateUpdate': RandomnessStateUpdate,
    'ConsensusCommitPrologueV2': ConsensusCommitPrologueV2,
    'ConsensusCommitPrologueV3': ConsensusCommitPrologueV3,
    'ConsensusCommitPrologueV4': ConsensusCommitPrologueV4,
    'ProgrammableSystemTransaction': ProgrammableTransaction,
  });

  static final PackageUpgradeError = Bcs.enumeration('PackageUpgradeError', {
    'UnableToFetchPackage': Bcs.struct('UnableToFetchPackage', {
      'packageId': Address,
    }),
    'NotAPackage': Bcs.struct('NotAPackage', {'objectId': Address}),
    'IncompatibleUpgrade': null,
    'DigestDoesNotMatch': Bcs.struct('DigestDoesNotMatch', {
      'digest': Bcs.vector(Bcs.u8()),
    }),
    'UnknownUpgradePolicy': Bcs.struct('UnknownUpgradePolicy', {
      'policy': Bcs.u8(),
    }),
    'PackageIDDoesNotMatch': Bcs.struct('PackageIDDoesNotMatch', {
      'packageId': Address,
      'ticketId': Address,
    }),
  });

  static final ModuleId = Bcs.struct('ModuleId', {
    'address': Address,
    'name': Bcs.string(),
  });

  static final MoveLocation = Bcs.struct('MoveLocation', {
    'module': ModuleId,
    'function': Bcs.u16(),
    'instruction': Bcs.u16(),
    'functionName': Bcs.option(Bcs.string()),
  });

  static final CommandArgumentError = Bcs.enumeration('CommandArgumentError', {
    'TypeMismatch': null,
    'InvalidBCSBytes': null,
    'InvalidUsageOfPureArg': null,
    'InvalidArgumentToPrivateEntryFunction': null,
    'IndexOutOfBounds': Bcs.struct('IndexOutOfBounds', {'idx': Bcs.u16()}),
    'SecondaryIndexOutOfBounds': Bcs.struct('SecondaryIndexOutOfBounds', {
      'resultIdx': Bcs.u16(),
      'secondaryIdx': Bcs.u16(),
    }),
    'InvalidResultArity': Bcs.struct('InvalidResultArity', {
      'resultIdx': Bcs.u16(),
    }),
    'InvalidGasCoinUsage': null,
    'InvalidValueUsage': null,
    'InvalidObjectByValue': null,
    'InvalidObjectByMutRef': null,
    'SharedObjectOperationNotAllowed': null,
    'InvalidArgumentArity': null,
    'InvalidTransferObject': null,
    'InvalidMakeMoveVecNonObjectArgument': null,
    'ArgumentWithoutValue': null,
    'CannotMoveBorrowedValue': null,
    'CannotWriteToExtendedReference': null,
    'InvalidReferenceArgument': null,
    'InvalidTxContext': null,
  });

  static final TypeArgumentError = Bcs.enumeration('TypeArgumentError', {
    'TypeNotFound': null,
    'ConstraintNotSatisfied': null,
  });

  static final ExecutionFailureStatus = Bcs.enumeration(
    'ExecutionFailureStatus',
    {
      'InsufficientGas': null,
      'InvalidGasObject': null,
      'InvariantViolation': null,
      'FeatureNotYetSupported': null,
      'MoveObjectTooBig': Bcs.struct('MoveObjectTooBig', {
        'objectSize': Bcs.u64(),
        'maxObjectSize': Bcs.u64(),
      }),
      'MovePackageTooBig': Bcs.struct('MovePackageTooBig', {
        'objectSize': Bcs.u64(),
        'maxObjectSize': Bcs.u64(),
      }),
      'CircularObjectOwnership': Bcs.struct('CircularObjectOwnership', {
        'object': Address,
      }),
      'InsufficientCoinBalance': null,
      'CoinBalanceOverflow': null,
      'PublishErrorNonZeroAddress': null,
      'SuiMoveVerificationError': null,
      'MovePrimitiveRuntimeError': Bcs.option(MoveLocation),
      'MoveAbort': Bcs.tuple([MoveLocation, Bcs.u64()]),
      'VMVerificationOrDeserializationError': null,
      'VMInvariantViolation': null,
      'FunctionNotFound': null,
      'ArityMismatch': null,
      'TypeArityMismatch': null,
      'NonEntryFunctionInvoked': null,
      'CommandArgumentError': Bcs.struct('CommandArgumentError', {
        'argIdx': Bcs.u16(),
        'kind': CommandArgumentError,
      }),
      'TypeArgumentError': Bcs.struct('TypeArgumentError', {
        'argumentIdx': Bcs.u16(),
        'kind': TypeArgumentError,
      }),
      'UnusedValueWithoutDrop': Bcs.struct('UnusedValueWithoutDrop', {
        'resultIdx': Bcs.u16(),
        'secondaryIdx': Bcs.u16(),
      }),
      'InvalidPublicFunctionReturnType': Bcs.struct(
        'InvalidPublicFunctionReturnType',
        {'idx': Bcs.u16()},
      ),
      'InvalidTransferObject': null,
      'EffectsTooLarge': Bcs.struct('EffectsTooLarge', {
        'currentSize': Bcs.u64(),
        'maxSize': Bcs.u64(),
      }),
      'PublishUpgradeMissingDependency': null,
      'PublishUpgradeDependencyDowngrade': null,
      'PackageUpgradeError': Bcs.struct('PackageUpgradeError', {
        'upgradeError': PackageUpgradeError,
      }),
      'WrittenObjectsTooLarge': Bcs.struct('WrittenObjectsTooLarge', {
        'currentSize': Bcs.u64(),
        'maxSize': Bcs.u64(),
      }),
      'CertificateDenied': null,
      'SuiMoveVerificationTimedout': null,
      'SharedObjectOperationNotAllowed': null,
      'InputObjectDeleted': null,
      'ExecutionCancelledDueToSharedObjectCongestion': Bcs.struct(
        'ExecutionCancelledDueToSharedObjectCongestion',
        {'congested_objects': Bcs.vector(Address)},
      ),
      'AddressDeniedForCoin': Bcs.struct('AddressDeniedForCoin', {
        'address': Address,
        'coinType': Bcs.string(),
      }),
      'CoinTypeGlobalPause': Bcs.struct('CoinTypeGlobalPause', {
        'coinType': Bcs.string(),
      }),
      'ExecutionCancelledDueToRandomnessUnavailable': null,
      'MoveVectorElemTooBig': Bcs.struct('MoveVectorElemTooBig', {
        'valueSize': Bcs.u64(),
        'maxScaledSize': Bcs.u64(),
      }),
      'MoveRawValueTooBig': Bcs.struct('MoveRawValueTooBig', {
        'valueSize': Bcs.u64(),
        'maxScaledSize': Bcs.u64(),
      }),
      'InvalidLinkage': null,

      'InsufficientBalanceForWithdraw': null,
      'NonExclusiveWriteInputObjectModified': Bcs.struct(
        'NonExclusiveWriteInputObjectModified',
        {'id': Address},
      ),
    },
  );

  static final ExecutionStatus = Bcs.enumeration('ExecutionStatus', {
    'Success': null,
    'Failure': Bcs.struct('Failure', {
      'error': ExecutionFailureStatus,
      'command': Bcs.option(Bcs.u64()),
    }),
  });

  static final GasCostSummary = Bcs.struct('GasCostSummary', {
    'computationCost': Bcs.u64(),
    'storageCost': Bcs.u64(),
    'storageRebate': Bcs.u64(),
    'nonRefundableStorageFee': Bcs.u64(),
  });

  static final TransactionEffectsV1 = Bcs.struct('TransactionEffectsV1', {
    'status': ExecutionStatus,
    'executedEpoch': Bcs.u64(),
    'gasUsed': GasCostSummary,
    'modifiedAtVersions': Bcs.vector(Bcs.tuple([Address, Bcs.u64()])),
    'sharedObjects': Bcs.vector(SuiObjectRef),
    'transactionDigest': ObjectDigest,
    'created': Bcs.vector(Bcs.tuple([SuiObjectRef, Owner])),
    'mutated': Bcs.vector(Bcs.tuple([SuiObjectRef, Owner])),
    'unwrapped': Bcs.vector(Bcs.tuple([SuiObjectRef, Owner])),
    'deleted': Bcs.vector(SuiObjectRef),
    'unwrappedThenDeleted': Bcs.vector(SuiObjectRef),
    'wrapped': Bcs.vector(SuiObjectRef),
    'gasObject': Bcs.tuple([SuiObjectRef, Owner]),
    'eventsDigest': Bcs.option(ObjectDigest),
    'dependencies': Bcs.vector(ObjectDigest),
  });

  static final VersionDigest = Bcs.tuple([Bcs.u64(), ObjectDigest]);

  static final ObjectIn = Bcs.enumeration('ObjectIn', {
    'NotExist': null,
    'Exist': Bcs.tuple([VersionDigest, Owner]),
  });

  static final AccumulatorAddress = Bcs.struct('AccumulatorAddress', {
    'address': Address,

    'ty': TypeTag,
  });

  static final AccumulatorOperation = Bcs.enumeration('AccumulatorOperation', {
    'Merge': null,
    'Split': null,
  });

  static final AccumulatorValue = Bcs.enumeration('AccumulatorValue', {
    'Integer': Bcs.u64(),
    'IntegerTuple': Bcs.tuple([Bcs.u64(), Bcs.u64()]),

    'EventDigest': Bcs.vector(Bcs.tuple([Bcs.u64(), ObjectDigest])),
  });

  static final AccumulatorWriteV1 = Bcs.struct('AccumulatorWriteV1', {
    'address': AccumulatorAddress,
    'operation': AccumulatorOperation,
    'value': AccumulatorValue,
  });

  static final ObjectOut = Bcs.enumeration('ObjectOut', {
    'NotExist': null,
    'ObjectWrite': Bcs.tuple([ObjectDigest, Owner]),
    'PackageWrite': VersionDigest,
    'AccumulatorWriteV1': AccumulatorWriteV1,
  });

  static final IDOperation = Bcs.enumeration('IDOperation', {
    'None': null,
    'Created': null,
    'Deleted': null,
  });

  static final EffectsObjectChange = Bcs.struct('EffectsObjectChange', {
    'inputState': ObjectIn,
    'outputState': ObjectOut,
    'idOperation': IDOperation,
  });

  static final UnchangedConsensusKind =
      Bcs.enumeration('UnchangedConsensusKind', {
        'ReadOnlyRoot': VersionDigest,
        'MutateConsensusStreamEnded': Bcs.u64(),
        'ReadConsensusStreamEnded': Bcs.u64(),
        'Cancelled': Bcs.u64(),
        'PerEpochConfig': null,
      });

  static final TransactionEffectsV2 = Bcs.struct('TransactionEffectsV2', {
    'status': ExecutionStatus,
    'executedEpoch': Bcs.u64(),
    'gasUsed': GasCostSummary,
    'transactionDigest': ObjectDigest,
    'gasObjectIndex': Bcs.option(Bcs.u32()),
    'eventsDigest': Bcs.option(ObjectDigest),
    'dependencies': Bcs.vector(ObjectDigest),
    'lamportVersion': Bcs.u64(),
    'changedObjects': Bcs.vector(Bcs.tuple([Address, EffectsObjectChange])),
    'unchangedConsensusObjects': Bcs.vector(
      Bcs.tuple([Address, UnchangedConsensusKind]),
    ),
    'auxDataDigest': Bcs.option(ObjectDigest),
  });

  static final TransactionEffects = Bcs.enumeration('TransactionEffects', {
    'V1': TransactionEffectsV1,
    'V2': TransactionEffectsV2,
  });
}
