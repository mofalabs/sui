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
