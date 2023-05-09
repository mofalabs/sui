import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';

typedef EpochId = String;

class ValidatorsApy {
  ValidatorsApy({
    required this.apys,
    required this.epoch,
  });

  late final List<Apys> apys;
  late final String epoch;

  ValidatorsApy.fromJson(Map<String, dynamic> json) {
    apys = List.from(json['apys']).map((e) => Apys.fromJson(e)).toList();
    epoch = json['epoch'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['apys'] = apys.map((e) => e.toJson()).toList();
    _data['epoch'] = epoch;
    return _data;
  }
}

class Apys {
  Apys({
    required this.address,
    required this.apy,
  });

  late final SuiAddress address;
  late final double apy;

  Apys.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    apy = json['apy'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address'] = address;
    _data['apy'] = apy;
    return _data;
  }
}

class SuiValidatorSummary {
  SuiValidatorSummary({
    required this.suiAddress,
    required this.protocolPubkeyBytes,
    required this.networkPubkeyBytes,
    required this.workerPubkeyBytes,
    required this.proofOfPossessionBytes,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.projectUrl,
    required this.netAddress,
    required this.p2pAddress,
    required this.primaryAddress,
    required this.workerAddress,
    this.nextEpochProtocolPubkeyBytes,
    this.nextEpochProofOfPossession,
    this.nextEpochNetworkPubkeyBytes,
    this.nextEpochWorkerPubkeyBytes,
    this.nextEpochNetAddress,
    this.nextEpochP2pAddress,
    this.nextEpochPrimaryAddress,
    this.nextEpochWorkerAddress,
    required this.votingPower,
    required this.operationCapId,
    required this.gasPrice,
    required this.commissionRate,
    required this.nextEpochStake,
    required this.nextEpochGasPrice,
    required this.nextEpochCommissionRate,
    required this.stakingPoolId,
    this.stakingPoolActivationEpoch,
    this.stakingPoolDeactivationEpoch,
    required this.stakingPoolSuiBalance,
    required this.rewardsPool,
    required this.poolTokenBalance,
    required this.pendingStake,
    required this.pendingTotalSuiWithdraw,
    required this.pendingPoolTokenWithdraw,
    required this.exchangeRatesId,
    required this.exchangeRatesSize,
  });

  late final SuiAddress suiAddress;
  late final String protocolPubkeyBytes;
  late final String networkPubkeyBytes;
  late final String workerPubkeyBytes;
  late final String proofOfPossessionBytes;
  late final String name;
  late final String description;
  late final String imageUrl;
  late final String projectUrl;
  late final String netAddress;
  late final String p2pAddress;
  late final String primaryAddress;
  late final String workerAddress;
  late final String? nextEpochProtocolPubkeyBytes;
  late final String? nextEpochProofOfPossession;
  late final String? nextEpochNetworkPubkeyBytes;
  late final String? nextEpochWorkerPubkeyBytes;
  late final String? nextEpochNetAddress;
  late final String? nextEpochP2pAddress;
  late final String? nextEpochPrimaryAddress;
  late final String? nextEpochWorkerAddress;
  late final String votingPower;
  late final String operationCapId;
  late final String gasPrice;
  late final String commissionRate;
  late final String nextEpochStake;
  late final String nextEpochGasPrice;
  late final String nextEpochCommissionRate;
  late final String stakingPoolId;
  late final String? stakingPoolActivationEpoch;
  late final String? stakingPoolDeactivationEpoch;
  late final String stakingPoolSuiBalance;
  late final String rewardsPool;
  late final String poolTokenBalance;
  late final String pendingStake;
  late final String pendingTotalSuiWithdraw;
  late final String pendingPoolTokenWithdraw;
  late final String exchangeRatesId;
  late final String exchangeRatesSize;

  SuiValidatorSummary.fromJson(Map<String, dynamic> json) {
    suiAddress = json['suiAddress'];
    protocolPubkeyBytes = json['protocolPubkeyBytes'];
    networkPubkeyBytes = json['networkPubkeyBytes'];
    workerPubkeyBytes = json['workerPubkeyBytes'];
    proofOfPossessionBytes = json['proofOfPossessionBytes'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    projectUrl = json['projectUrl'];
    netAddress = json['netAddress'];
    p2pAddress = json['p2pAddress'];
    primaryAddress = json['primaryAddress'];
    workerAddress = json['workerAddress'];
    nextEpochProtocolPubkeyBytes = json['nextEpochProtocolPubkeyBytes'];
    nextEpochProofOfPossession = json['nextEpochProofOfPossession'];
    nextEpochNetworkPubkeyBytes = json['nextEpochNetworkPubkeyBytes'];
    nextEpochWorkerPubkeyBytes = json['nextEpochWorkerPubkeyBytes'];
    nextEpochNetAddress = json['nextEpochNetAddress'];
    nextEpochP2pAddress = json['nextEpochP2pAddress'];
    nextEpochPrimaryAddress = json['nextEpochPrimaryAddress'];
    nextEpochWorkerAddress = json['nextEpochWorkerAddress'];
    votingPower = json['votingPower'];
    operationCapId = json['operationCapId'];
    gasPrice = json['gasPrice'];
    commissionRate = json['commissionRate'];
    nextEpochStake = json['nextEpochStake'];
    nextEpochGasPrice = json['nextEpochGasPrice'];
    nextEpochCommissionRate = json['nextEpochCommissionRate'];
    stakingPoolId = json['stakingPoolId'];
    stakingPoolActivationEpoch = json['stakingPoolActivationEpoch'];
    stakingPoolDeactivationEpoch = json['stakingPoolDeactivationEpoch'];
    stakingPoolSuiBalance = json['stakingPoolSuiBalance'];
    rewardsPool = json['rewardsPool'];
    poolTokenBalance = json['poolTokenBalance'];
    pendingStake = json['pendingStake'];
    pendingTotalSuiWithdraw = json['pendingTotalSuiWithdraw'];
    pendingPoolTokenWithdraw = json['pendingPoolTokenWithdraw'];
    exchangeRatesId = json['exchangeRatesId'];
    exchangeRatesSize = json['exchangeRatesSize'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['suiAddress'] = suiAddress;
    _data['protocolPubkeyBytes'] = protocolPubkeyBytes;
    _data['networkPubkeyBytes'] = networkPubkeyBytes;
    _data['workerPubkeyBytes'] = workerPubkeyBytes;
    _data['proofOfPossessionBytes'] = proofOfPossessionBytes;
    _data['name'] = name;
    _data['description'] = description;
    _data['imageUrl'] = imageUrl;
    _data['projectUrl'] = projectUrl;
    _data['netAddress'] = netAddress;
    _data['p2pAddress'] = p2pAddress;
    _data['primaryAddress'] = primaryAddress;
    _data['workerAddress'] = workerAddress;
    _data['nextEpochProtocolPubkeyBytes'] = nextEpochProtocolPubkeyBytes;
    _data['nextEpochProofOfPossession'] = nextEpochProofOfPossession;
    _data['nextEpochNetworkPubkeyBytes'] = nextEpochNetworkPubkeyBytes;
    _data['nextEpochWorkerPubkeyBytes'] = nextEpochWorkerPubkeyBytes;
    _data['nextEpochNetAddress'] = nextEpochNetAddress;
    _data['nextEpochP2pAddress'] = nextEpochP2pAddress;
    _data['nextEpochPrimaryAddress'] = nextEpochPrimaryAddress;
    _data['nextEpochWorkerAddress'] = nextEpochWorkerAddress;
    _data['votingPower'] = votingPower;
    _data['operationCapId'] = operationCapId;
    _data['gasPrice'] = gasPrice;
    _data['commissionRate'] = commissionRate;
    _data['nextEpochStake'] = nextEpochStake;
    _data['nextEpochGasPrice'] = nextEpochGasPrice;
    _data['nextEpochCommissionRate'] = nextEpochCommissionRate;
    _data['stakingPoolId'] = stakingPoolId;
    _data['stakingPoolActivationEpoch'] = stakingPoolActivationEpoch;
    _data['stakingPoolDeactivationEpoch'] = stakingPoolDeactivationEpoch;
    _data['stakingPoolSuiBalance'] = stakingPoolSuiBalance;
    _data['rewardsPool'] = rewardsPool;
    _data['poolTokenBalance'] = poolTokenBalance;
    _data['pendingStake'] = pendingStake;
    _data['pendingTotalSuiWithdraw'] = pendingTotalSuiWithdraw;
    _data['pendingPoolTokenWithdraw'] = pendingPoolTokenWithdraw;
    _data['exchangeRatesId'] = exchangeRatesId;
    _data['exchangeRatesSize'] = exchangeRatesSize;
    return _data;
  }
}

class SuiSystemStateSummary {
  SuiSystemStateSummary({
    required this.epoch,
    required this.protocolVersion,
    required this.systemStateVersion,
    required this.storageFundTotalObjectStorageRebates,
    required this.storageFundNonRefundableBalance,
    required this.referenceGasPrice,
    required this.safeMode,
    required this.safeModeStorageRewards,
    required this.safeModeComputationRewards,
    required this.safeModeStorageRebates,
    required this.safeModeNonRefundableStorageFee,
    required this.epochStartTimestampMs,
    required this.epochDurationMs,
    required this.stakeSubsidyStartEpoch,
    required this.maxValidatorCount,
    required this.minValidatorJoiningStake,
    required this.validatorLowStakeThreshold,
    required this.validatorVeryLowStakeThreshold,
    required this.validatorLowStakeGracePeriod,
    required this.stakeSubsidyBalance,
    required this.stakeSubsidyDistributionCounter,
    required this.stakeSubsidyCurrentDistributionAmount,
    required this.stakeSubsidyPeriodLength,
    required this.stakeSubsidyDecreaseRate,
    required this.totalStake,
    required this.activeValidators,
    required this.pendingActiveValidatorsId,
    required this.pendingActiveValidatorsSize,
    required this.pendingRemovals,
    required this.stakingPoolMappingsId,
    required this.stakingPoolMappingsSize,
    required this.inactivePoolsId,
    required this.inactivePoolsSize,
    required this.validatorCandidatesId,
    required this.validatorCandidatesSize,
    required this.atRiskValidators,
    required this.validatorReportRecords,
  });

  late final String epoch;
  late final String protocolVersion;
  late final String systemStateVersion;
  late final String storageFundTotalObjectStorageRebates;
  late final String storageFundNonRefundableBalance;
  late final String referenceGasPrice;
  late final bool safeMode;
  late final String safeModeStorageRewards;
  late final String safeModeComputationRewards;
  late final String safeModeStorageRebates;
  late final String safeModeNonRefundableStorageFee;
  late final String epochStartTimestampMs;
  late final String epochDurationMs;
  late final String stakeSubsidyStartEpoch;
  late final String maxValidatorCount;
  late final String minValidatorJoiningStake;
  late final String validatorLowStakeThreshold;
  late final String validatorVeryLowStakeThreshold;
  late final String validatorLowStakeGracePeriod;
  late final String stakeSubsidyBalance;
  late final String stakeSubsidyDistributionCounter;
  late final String stakeSubsidyCurrentDistributionAmount;
  late final String stakeSubsidyPeriodLength;
  late final int stakeSubsidyDecreaseRate;
  late final String totalStake;
  late final List<SuiValidatorSummary> activeValidators;
  late final String pendingActiveValidatorsId;
  late final String pendingActiveValidatorsSize;
  late final List<dynamic> pendingRemovals;
  late final String stakingPoolMappingsId;
  late final String stakingPoolMappingsSize;
  late final String inactivePoolsId;
  late final String inactivePoolsSize;
  late final String validatorCandidatesId;
  late final String validatorCandidatesSize;
  late final List<dynamic> atRiskValidators;
  late final List<dynamic> validatorReportRecords;

  SuiSystemStateSummary.fromJson(Map<String, dynamic> json) {
    activeValidators = [];
    for (var value in json['activeValidators']) {
      activeValidators.add(SuiValidatorSummary.fromJson(value));
    }
    epoch = json['epoch'];
    protocolVersion = json['protocolVersion'];
    systemStateVersion = json['systemStateVersion'];
    storageFundTotalObjectStorageRebates =
        json['storageFundTotalObjectStorageRebates'];
    storageFundNonRefundableBalance = json['storageFundNonRefundableBalance'];
    referenceGasPrice = json['referenceGasPrice'];
    safeMode = json['safeMode'];
    safeModeStorageRewards = json['safeModeStorageRewards'];
    safeModeComputationRewards = json['safeModeComputationRewards'];
    safeModeStorageRebates = json['safeModeStorageRebates'];
    safeModeNonRefundableStorageFee = json['safeModeNonRefundableStorageFee'];
    epochStartTimestampMs = json['epochStartTimestampMs'];
    epochDurationMs = json['epochDurationMs'];
    stakeSubsidyStartEpoch = json['stakeSubsidyStartEpoch'];
    maxValidatorCount = json['maxValidatorCount'];
    minValidatorJoiningStake = json['minValidatorJoiningStake'];
    validatorLowStakeThreshold = json['validatorLowStakeThreshold'];
    validatorVeryLowStakeThreshold = json['validatorVeryLowStakeThreshold'];
    validatorLowStakeGracePeriod = json['validatorLowStakeGracePeriod'];
    stakeSubsidyBalance = json['stakeSubsidyBalance'];
    stakeSubsidyDistributionCounter = json['stakeSubsidyDistributionCounter'];
    stakeSubsidyCurrentDistributionAmount =
        json['stakeSubsidyCurrentDistributionAmount'];
    stakeSubsidyPeriodLength = json['stakeSubsidyPeriodLength'];
    stakeSubsidyDecreaseRate = json['stakeSubsidyDecreaseRate'];
    totalStake = json['totalStake'];
    pendingActiveValidatorsId = json['pendingActiveValidatorsId'];
    pendingActiveValidatorsSize = json['pendingActiveValidatorsSize'];
    pendingRemovals = List.castFrom<dynamic, dynamic>(json['pendingRemovals']);
    stakingPoolMappingsId = json['stakingPoolMappingsId'];
    stakingPoolMappingsSize = json['stakingPoolMappingsSize'];
    inactivePoolsId = json['inactivePoolsId'];
    inactivePoolsSize = json['inactivePoolsSize'];
    validatorCandidatesId = json['validatorCandidatesId'];
    validatorCandidatesSize = json['validatorCandidatesSize'];
    atRiskValidators =
        List.castFrom<dynamic, dynamic>(json['atRiskValidators']);
    validatorReportRecords =
        List.castFrom<dynamic, dynamic>(json['validatorReportRecords']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['epoch'] = epoch;
    _data['protocolVersion'] = protocolVersion;
    _data['systemStateVersion'] = systemStateVersion;
    _data['storageFundTotalObjectStorageRebates'] =
        storageFundTotalObjectStorageRebates;
    _data['storageFundNonRefundableBalance'] = storageFundNonRefundableBalance;
    _data['referenceGasPrice'] = referenceGasPrice;
    _data['safeMode'] = safeMode;
    _data['safeModeStorageRewards'] = safeModeStorageRewards;
    _data['safeModeComputationRewards'] = safeModeComputationRewards;
    _data['safeModeStorageRebates'] = safeModeStorageRebates;
    _data['safeModeNonRefundableStorageFee'] = safeModeNonRefundableStorageFee;
    _data['epochStartTimestampMs'] = epochStartTimestampMs;
    _data['epochDurationMs'] = epochDurationMs;
    _data['stakeSubsidyStartEpoch'] = stakeSubsidyStartEpoch;
    _data['maxValidatorCount'] = maxValidatorCount;
    _data['minValidatorJoiningStake'] = minValidatorJoiningStake;
    _data['validatorLowStakeThreshold'] = validatorLowStakeThreshold;
    _data['validatorVeryLowStakeThreshold'] = validatorVeryLowStakeThreshold;
    _data['validatorLowStakeGracePeriod'] = validatorLowStakeGracePeriod;
    _data['stakeSubsidyBalance'] = stakeSubsidyBalance;
    _data['stakeSubsidyDistributionCounter'] = stakeSubsidyDistributionCounter;
    _data['stakeSubsidyCurrentDistributionAmount'] =
        stakeSubsidyCurrentDistributionAmount;
    _data['stakeSubsidyPeriodLength'] = stakeSubsidyPeriodLength;
    _data['stakeSubsidyDecreaseRate'] = stakeSubsidyDecreaseRate;
    _data['totalStake'] = totalStake;
    _data['pendingActiveValidatorsId'] = pendingActiveValidatorsId;
    _data['pendingActiveValidatorsSize'] = pendingActiveValidatorsSize;
    _data['pendingRemovals'] = pendingRemovals;
    _data['stakingPoolMappingsId'] = stakingPoolMappingsId;
    _data['stakingPoolMappingsSize'] = stakingPoolMappingsSize;
    _data['inactivePoolsId'] = inactivePoolsId;
    _data['inactivePoolsSize'] = inactivePoolsSize;
    _data['validatorCandidatesId'] = validatorCandidatesId;
    _data['validatorCandidatesSize'] = validatorCandidatesSize;
    _data['atRiskValidators'] = atRiskValidators;
    _data['validatorReportRecords'] = validatorReportRecords;
    _data['activeValidators'] =
        activeValidators.map((e) => e.toJson()).toList();
    return _data;
  }
}

class StakeObject {
  StakeObject({
    required this.stakedSuiId,
    required this.stakeRequestEpoch,
    required this.stakeActiveEpoch,
    required this.principal,
    required this.status,
    required this.estimatedReward,
  });

  late final ObjectId stakedSuiId;
  late final EpochId stakeRequestEpoch;
  late final EpochId stakeActiveEpoch;
  late final String principal;
  late final String status;
  late final String? estimatedReward;

  StakeObject.fromJson(Map<String, dynamic> json) {
    stakedSuiId = json['stakedSuiId'];
    stakeRequestEpoch = json['stakeRequestEpoch'];
    stakeActiveEpoch = json['stakeActiveEpoch'];
    principal = json['principal'];
    status = json['status'];
    estimatedReward = json['estimatedReward'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['stakedSuiId'] = stakedSuiId;
    _data['stakeRequestEpoch'] = stakeRequestEpoch;
    _data['stakeActiveEpoch'] = stakeActiveEpoch;
    _data['principal'] = principal;
    _data['status'] = status;
    _data['estimatedReward'] = estimatedReward;
    return _data;
  }
}

class DelegatedStake {
  DelegatedStake({
    required this.validatorAddress,
    required this.stakingPool,
    required this.stakes,
  });

  late final SuiAddress validatorAddress;
  late final ObjectId stakingPool;
  late final List<StakeObject> stakes;

  DelegatedStake.fromJson(Map<String, dynamic> json) {
    validatorAddress = json['validatorAddress'];
    stakingPool = json['stakingPool'];
    stakes =
        List.from(json['stakes']).map((e) => StakeObject.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['validatorAddress'] = validatorAddress;
    _data['stakingPool'] = stakingPool;
    _data['stakes'] = stakes.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CommitteeInfo {
  CommitteeInfo({
    required this.epoch,
    required this.validators,
  });

  late final EpochId epoch;
  late final List<List<String>> validators;

  CommitteeInfo.fromJson(Map<String, dynamic> json) {
    epoch = json['epoch'];
    validators = [];
    for (var validator in json['validators']) {
      validators.add(List.from(validator).map((e) => e.toString()).toList());
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['epoch'] = epoch;
    _data['validators'] = validators;
    return _data;
  }
}
