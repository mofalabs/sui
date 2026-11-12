// Run with the pinned official repository's tsx binary and its path as argv[2].
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';
import { execFileSync } from 'node:child_process';
const repo = process.argv[2];
if (!repo) throw new Error('Usage: tsx generate_upstream_fixtures.mts /path/to/ts-sdks');
const expected = 'de91ff2fbb484e09b6e72c4ed5a92789692b2ab8';
if (execFileSync('git', ['-C', repo, 'rev-parse', 'HEAD'], { encoding: 'utf8' }).trim() !== expected) {
  throw new Error(`Official SDK checkout must be at ${expected}`);
}
const { bcs } = await import(pathToFileURL(resolve(repo, 'packages/sui/src/bcs/index.ts')).href);
const digest='11111111111111111111111111111111';
const fixtures=[];
function add(name, type, input) {fixtures.push({name,type,input,hex:bcs[type].serialize(input,{maxSize:100000}).toHex()});}
const window={minEpoch:'10',maxEpoch:'12',minTimestamp:'1792900000123',maxTimestamp:'1792900060456',chain:digest,nonce:1234};
add('validity','TransactionExpiration',{Validity:{...window,allowedProposers:{epoch:'11',proposers:[0,3,4294967295]}}});
add('valid-during','TransactionExpiration',{ValidDuring:window});
add('allowance','CallArg',{FundsWithdrawal:{reservation:{MaxAmountU64:'18446744073709551615'},typeArg:{Balance:'0x2::sui::SUI'},withdrawFrom:{SenderAllowance:{funder:'0xabc',allowance:'0x123'}}}});
add('epoch','TransactionKind',{ChangeEpoch:{epoch:'1',protocolVersion:'138',storageCharge:'2',computationCharge:'3',storageRebate:'4',nonRefundableStorageFee:'5',epochStartTimestampMs:'100',systemPackages:[['2',[[1,2,3]],['0x2']]]}});
add('genesis','TransactionKind',{Genesis:{objects:[{RawObject:{data:{Move:{type:{GasCoin:true},hasPublicTransfer:true,version:'1',contents:[1,2]}},owner:{AddressOwner:'0xabc'}}}]}});
add('end-of-epoch','TransactionKind',{EndOfEpochTransaction:[{AuthenticatorStateCreate:true},{BridgeStateCreate:digest},{WriteAccumulatorStorageCost:{storageCost:'25'}},{ForwardingAddressRegistryCreate:true}]});
add('prologue-v4','TransactionKind',{ConsensusCommitPrologueV4:{epoch:'1',round:'2',subDagIndex:'3',commitTimestampMs:'100',consensusCommitDigest:digest,consensusDeterminedVersionAssignments:{CancelledTransactionsV2:[[digest,[[['0x123','2'],'3']]]]},additionalStateDigest:digest}});
add('programmable-system','TransactionKind',{ProgrammableSystemTransaction:{inputs:[],commands:[]}});
const ref={objectId:'0x123',version:'1',digest};const gas={computationCost:'1',storageCost:'2',storageRebate:'3',nonRefundableStorageFee:'4'};
add('effects-v1','TransactionEffects',{V1:{status:{Success:true},executedEpoch:'1',gasUsed:gas,modifiedAtVersions:[],sharedObjects:[],transactionDigest:digest,created:[[ref,{AddressOwner:'0xabc'}]],mutated:[],unwrapped:[],deleted:[],unwrappedThenDeleted:[],wrapped:[],gasObject:[ref,{AddressOwner:'0xabc'}],eventsDigest:null,dependencies:[digest]}});
add('effects-v2','TransactionEffects',{V2:{status:{Success:true},executedEpoch:'2',gasUsed:gas,transactionDigest:digest,gasObjectIndex:null,eventsDigest:null,dependencies:[],lamportVersion:'3',changedObjects:[['0x123',{inputState:{NotExist:true},outputState:{AccumulatorWriteV1:{address:{address:'0xabc',ty:'0x2::sui::SUI'},operation:{Merge:true},value:{Integer:'5'}}},idOperation:{Created:true}}]],unchangedConsensusObjects:[],auxDataDigest:null}});
console.log(JSON.stringify({source:'MystenLabs/ts-sdks@de91ff2f, @mysten/sui 2.37.0',fixtures},null,2));
