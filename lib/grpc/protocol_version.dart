/// Request header carrying the highest Sui protocol version whose on-chain
/// types this client can decode. Lets the server avoid sending types the SDK
/// cannot parse. Mirrors the official TypeScript SDK's
/// `x-sui-client-protocol-version` header.
const clientProtocolVersionHeader = 'x-sui-client-protocol-version';

/// Highest Sui protocol version whose on-chain types this SDK can decode.
///
/// Bump this when the SDK gains support for types introduced in a newer
/// protocol version — typically together with a proto regeneration
/// (`tool/generate_proto.sh`) — keeping in step with the official TypeScript
/// SDK's `MAX_PROTOCOL_VERSION`.
const maxProtocolVersion = 138;
