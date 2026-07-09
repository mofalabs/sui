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
    final data = <String, dynamic>{};
    data['apys'] = apys.map((e) => e.toJson()).toList();
    data['epoch'] = epoch;
    return data;
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
    final data = <String, dynamic>{};
    data['address'] = address;
    data['apy'] = apy;
    return data;
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
    final data = <String, dynamic>{};
    data['suiAddress'] = suiAddress;
    data['protocolPubkeyBytes'] = protocolPubkeyBytes;
    data['networkPubkeyBytes'] = networkPubkeyBytes;
    data['workerPubkeyBytes'] = workerPubkeyBytes;
    data['proofOfPossessionBytes'] = proofOfPossessionBytes;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['projectUrl'] = projectUrl;
    data['netAddress'] = netAddress;
    data['p2pAddress'] = p2pAddress;
    data['primaryAddress'] = primaryAddress;
    data['workerAddress'] = workerAddress;
    data['nextEpochProtocolPubkeyBytes'] = nextEpochProtocolPubkeyBytes;
    data['nextEpochProofOfPossession'] = nextEpochProofOfPossession;
    data['nextEpochNetworkPubkeyBytes'] = nextEpochNetworkPubkeyBytes;
    data['nextEpochWorkerPubkeyBytes'] = nextEpochWorkerPubkeyBytes;
    data['nextEpochNetAddress'] = nextEpochNetAddress;
    data['nextEpochP2pAddress'] = nextEpochP2pAddress;
    data['nextEpochPrimaryAddress'] = nextEpochPrimaryAddress;
    data['nextEpochWorkerAddress'] = nextEpochWorkerAddress;
    data['votingPower'] = votingPower;
    data['operationCapId'] = operationCapId;
    data['gasPrice'] = gasPrice;
    data['commissionRate'] = commissionRate;
    data['nextEpochStake'] = nextEpochStake;
    data['nextEpochGasPrice'] = nextEpochGasPrice;
    data['nextEpochCommissionRate'] = nextEpochCommissionRate;
    data['stakingPoolId'] = stakingPoolId;
    data['stakingPoolActivationEpoch'] = stakingPoolActivationEpoch;
    data['stakingPoolDeactivationEpoch'] = stakingPoolDeactivationEpoch;
    data['stakingPoolSuiBalance'] = stakingPoolSuiBalance;
    data['rewardsPool'] = rewardsPool;
    data['poolTokenBalance'] = poolTokenBalance;
    data['pendingStake'] = pendingStake;
    data['pendingTotalSuiWithdraw'] = pendingTotalSuiWithdraw;
    data['pendingPoolTokenWithdraw'] = pendingPoolTokenWithdraw;
    data['exchangeRatesId'] = exchangeRatesId;
    data['exchangeRatesSize'] = exchangeRatesSize;
    return data;
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
    final data = <String, dynamic>{};
    data['epoch'] = epoch;
    data['protocolVersion'] = protocolVersion;
    data['systemStateVersion'] = systemStateVersion;
    data['storageFundTotalObjectStorageRebates'] =
        storageFundTotalObjectStorageRebates;
    data['storageFundNonRefundableBalance'] = storageFundNonRefundableBalance;
    data['referenceGasPrice'] = referenceGasPrice;
    data['safeMode'] = safeMode;
    data['safeModeStorageRewards'] = safeModeStorageRewards;
    data['safeModeComputationRewards'] = safeModeComputationRewards;
    data['safeModeStorageRebates'] = safeModeStorageRebates;
    data['safeModeNonRefundableStorageFee'] = safeModeNonRefundableStorageFee;
    data['epochStartTimestampMs'] = epochStartTimestampMs;
    data['epochDurationMs'] = epochDurationMs;
    data['stakeSubsidyStartEpoch'] = stakeSubsidyStartEpoch;
    data['maxValidatorCount'] = maxValidatorCount;
    data['minValidatorJoiningStake'] = minValidatorJoiningStake;
    data['validatorLowStakeThreshold'] = validatorLowStakeThreshold;
    data['validatorVeryLowStakeThreshold'] = validatorVeryLowStakeThreshold;
    data['validatorLowStakeGracePeriod'] = validatorLowStakeGracePeriod;
    data['stakeSubsidyBalance'] = stakeSubsidyBalance;
    data['stakeSubsidyDistributionCounter'] = stakeSubsidyDistributionCounter;
    data['stakeSubsidyCurrentDistributionAmount'] =
        stakeSubsidyCurrentDistributionAmount;
    data['stakeSubsidyPeriodLength'] = stakeSubsidyPeriodLength;
    data['stakeSubsidyDecreaseRate'] = stakeSubsidyDecreaseRate;
    data['totalStake'] = totalStake;
    data['pendingActiveValidatorsId'] = pendingActiveValidatorsId;
    data['pendingActiveValidatorsSize'] = pendingActiveValidatorsSize;
    data['pendingRemovals'] = pendingRemovals;
    data['stakingPoolMappingsId'] = stakingPoolMappingsId;
    data['stakingPoolMappingsSize'] = stakingPoolMappingsSize;
    data['inactivePoolsId'] = inactivePoolsId;
    data['inactivePoolsSize'] = inactivePoolsSize;
    data['validatorCandidatesId'] = validatorCandidatesId;
    data['validatorCandidatesSize'] = validatorCandidatesSize;
    data['atRiskValidators'] = atRiskValidators;
    data['validatorReportRecords'] = validatorReportRecords;
    data['activeValidators'] =
        activeValidators.map((e) => e.toJson()).toList();
    return data;
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
    final data = <String, dynamic>{};
    data['stakedSuiId'] = stakedSuiId;
    data['stakeRequestEpoch'] = stakeRequestEpoch;
    data['stakeActiveEpoch'] = stakeActiveEpoch;
    data['principal'] = principal;
    data['status'] = status;
    data['estimatedReward'] = estimatedReward;
    return data;
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
    final data = <String, dynamic>{};
    data['validatorAddress'] = validatorAddress;
    data['stakingPool'] = stakingPool;
    data['stakes'] = stakes.map((e) => e.toJson()).toList();
    return data;
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
    final data = <String, dynamic>{};
    data['epoch'] = epoch;
    data['validators'] = validators;
    return data;
  }
}
