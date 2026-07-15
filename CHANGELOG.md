## 0.0.1

* Initial version, created by Mofa Labs.

## 0.0.3

* SuiNS
* Websocket
* Secp256r1

* Programmable Transactions Block

## 0.0.4

* Add requestSuiFromFaucetV1
* Fix TransactionBlock decode json data

## 0.1.0

* Refactor JsonRpcProvider
* Add more rpc methods
* Update readme

## 0.1.1

* Add Events API

## 0.1.2

* Add Web Support

## 0.1.3

* Fix query gas object
* Fix setSigner
* Add Web Demo

## 0.1.4

* Fix TransactionBlock
* Rename ED25519 to Ed25519

## 0.1.5

* Fix TransactionBlock Input Type, Estimate Gas

## 0.1.6

* Add zkLogin

## 0.1.7

* Fix hex pad

## 0.2.0

* Add MultiSig
* Add zkLogin Test

## 0.2.1

* export bech32 private key

## 0.3.0

* Refactor Transaction & BCS

## 0.3.1

* Fix dio use default transformer

## 0.3.2

* Fix bugs

## 0.3.3

* Fix example
* Clean code

## 0.3.4

* Perf: resolve move modules
* Bump BCS

## 0.3.5

* Fix map equality in transaction arguments

## 0.3.6

* Fix parse subIndex failed

## 0.3.7

* Config request options

## 0.4.1

* Support a custom gRPC-web endpoint: `SuiGrpcClient`, `GrpcCoreClient` and
  `SuiGrpcCompat` accept an optional `endpoint` to point reads/writes at a
  self-hosted or third-party full node. `network` still selects the GraphQL /
  MVR endpoints and chain semantics. Backward compatible (defaults to the
  public endpoint for the network).
* `SuiGrpcCompat` object reads now map the object's Display output and parsed
  Move fields into the legacy `display.data` / `content.fields` shapes (fixes
  empty NFT lists in wallets that classify objects by their Display).
* Fix `SuiGrpcCompat.getOwnedObjects` client-side filters (`StructType` /
  `Package` / `MoveModule`) comparing short-form addresses against gRPC's
  fully-normalized types — `MatchNone` coin exclusion silently failed, so pages
  filled with coins and NFT lists came back empty. Addresses are now normalized
  on both sides (`normalizeTypeAddresses`).
* Fix `SuiGrpcCompat.getDynamicFields`: for a dynamic **object** field, report
  the wrapped child object id (matching JSON-RPC), not the `Field<…>` wrapper —
  a `multiGetObjects` on it previously returned a display-less wrapper, leaving
  kiosk-held NFTs blank in wallet lists.
* `SuiGrpcCompat.getStakes` now resolves each stake's `validatorAddress` (via
  its staking pool id), which wallets match against the validator list — stakes
  were previously dropped for having an empty address — and estimates
  `estimatedReward` from the validator APY and stake age (the legacy RPC
  returned it directly).
* `SuiGrpcCompat.dryRunTransactionBlock` now returns balance changes, object
  changes and the effects' created/mutated/deleted sets from the simulated
  transaction — dApp sign previews were blank and could crash iterating a null
  objectChanges list.
* `SuiGrpcCompat.getTransactions` now returns each transaction's timestamp,
  execution status and balance changes (amount / coin / owner), not just the
  digest — wallet activity lists were showing rows with no date, amount or
  direction.
* `SuiGrpcCompat.dryRunTransactionBlock` now returns balance changes, object
  changes and the effects' created/mutated/deleted sets from the simulated
  transaction — dApp sign previews were blank and could crash iterating a null
  objectChanges list.
* `SuiGrpcCompat.getValidatorsApy` now estimates real APY from each pool's
  token exchange rate instead of returning 0 (unreliable young-pool estimates
  are filtered). `ValidatorInfo` exposes `stakingPoolId` and `activationEpoch`.

## 0.4.0

Major transport migration ahead of Sui's JSON-RPC decommission (fully off 2026-07-31).

* Add **gRPC-web** transport (`SuiGrpcClient`) — works on Mobile/Web/Desktop with no proxy:
  * Reads: `getObject(s)`, `listOwnedObjects`, `getBalance`/`listBalances`/`listCoins`,
    `getCoinInfo`, `getTransaction`, `getCheckpoint`, `getEpoch`, `getCurrentSystemState`,
    `getPackage`/`getFunction`, `listDynamicFields`, `getDynamicFieldObject`/`getDynamicObjectField`,
    name service.
  * Writes: `simulateTransaction`, `executeTransaction`, and one-call
    `signAndExecuteTransaction` with automatic gas price / coin selection / budget estimation.
  * `moveCall` with object arguments now resolves objects and Move signatures over gRPC.
  * `waitForTransaction`, `subscribeCheckpoints` (server-streaming, replaces WebSocket),
    `verifySignature`.
* Add **GraphQL** client (`SuiGraphQLClient`) for advanced queries: filtered transactions,
  events, active validators, stakes, epoch summary.
* Add **Move Registry (MVR)** resolution (`@org/app` names) wired into `moveCall`, `listCoins`
  and dynamic-field lookups.
* Add transport-neutral models (`SuiBalance`, `SuiCoin`, `SuiObjectInfo`, `SuiExecutionResult`, …)
  and `deriveDynamicFieldID`.
* Deprecate the JSON-RPC stack (`JsonRpcProvider`, `SuiClient` JSON-RPC methods, `WebsocketClient`).
  Kept for compatibility; will stop working when Sui removes JSON-RPC.
* Add `SuiGrpcCompat` — a drop-in-ish bridge exposing the legacy `SuiClient` API
  over gRPC-web/GraphQL, so apps migrate by swapping the client construction only.
* Vendor `bip32` / `bip39` (into `lib/cryptography`) to drop the git dependencies
  and make the package publishable; add hosted `crypto` and `bs58check`.
* Deps: add `protobuf` and `fixnum`; bump `bcs`, `dio`, `pointycastle` (4.0),
  `freezed`/`freezed_annotation` (3.0), `web_socket_channel` (3.0).

## 0.4.2

* Migrate to `bcs` 0.2.0 (full rewrite of the BCS package). **Breaking for apps
  that imported `package:bcs/...` internals through this SDK**: the legacy
  registry API (`LegacyBCS`), `fromB64`/`toB64`, `fromHEX`/`toHEX`,
  `fromB58`/`toB58` and split libraries (`bcs/utils.dart`, `bcs/hex.dart`, ...)
  are gone. Use `dart:convert` for base64 and `package:bcs/bcs.dart`
  (`hexEncode`/`hexDecode`, `base58Encode`/`base58Decode`) instead.
* `SuiObjectRef.version` / `SharedObjectRef.initialSharedVersion` now parse
  back from BCS as `int`, matching the SDK's object-ref types.
* Deprecate `Transactions` in favor of `Commands`; its methods now delegate to
  `Commands` and produce the `$kind`-style command maps the serialization
  pipeline expects (the old flat `kind` maps no longer serialized correctly).
* `Transaction.pureInt` now honors its `type` argument (previously always
  serialized as `u64`).
* `SenderTransactionPage.digests` convenience getter (GraphQL client).

## 0.4.3

* **Breaking:** faucet migrated to the `/v2/gas` route. The `/gas` (V0) and
  `/v1/gas` (V1) routes are deprecated upstream — devnet already rejects them
  with `Route deprecated. Use /v2/gas instead.` — so
  `requestSuiFromFaucetV0`, `requestSuiFromFaucetV1` and
  `getFaucetRequestStatus` are removed in favor of a single
  `requestSuiFromFaucetV2`, which throws when the faucet reports a
  non-success status. `FaucetResponse` now mirrors the v2 payload
  (`coinsSent` + `isSuccess`/`error`); `BatchFaucetResponse`,
  `BatchSendStatus`, `BatchSendStatusType` and `BatchStatusFaucetResponse`
  are gone.

## 0.4.4

* **Breaking:** `SuiGraphQLClient.queryTransactionsBySender` is renamed to
  `queryTransactionsByAddress` and now filters by `affectedAddress` instead of
  `sentAddress`, so an account's transaction history includes both sent and
  received transactions (the old query dropped every incoming transfer). The
  `getTransactions` compatibility helper keeps the same signature and gains the
  received transactions automatically.

## 0.4.5

* Restore `SuiGraphQLClient.queryTransactionsBySender` (the `sentAddress`
  sender-only primitive) alongside `queryTransactionsByAddress` (`affectedAddress`,
  sent + received). 0.4.4 replaced the former with the latter, which removed a
  valid query; both now coexist. `getTransactions` continues to use
  `affectedAddress` for a complete wallet history. Additive over 0.4.4 — no
  breaking changes.
