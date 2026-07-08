#!/usr/bin/env bash
#
# Regenerate the Dart protobuf message classes under lib/grpc/proto from the
# official Sui API protos (`sui.rpc.v2`).
#
# Requirements:
#   - protoc            (brew install protobuf)
#   - protoc-gen-dart   (dart pub global activate protoc_plugin)
#
# Usage:
#   tool/generate_proto.sh                 # clones sui-apis into a temp dir
#   SUI_APIS_DIR=/path/to/sui-apis tool/generate_proto.sh   # use a local checkout
#
# Notes:
#   - Only message types are generated (no gRPC service stubs); the services are
#     driven by lib/grpc/transport/grpc_web_transport.dart.
#   - Pin SUI_APIS_REF to the sui-apis commit/tag you want to track.
set -euo pipefail

SUI_APIS_REPO="https://github.com/MystenLabs/sui-apis.git"
SUI_APIS_REF="${SUI_APIS_REF:-main}"

# Repo root (this script lives in <pkg>/tool).
PKG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="$PKG_DIR/lib/grpc/proto"

# Ensure protoc-gen-dart is on PATH.
export PATH="$PATH:$HOME/.pub-cache/bin"
command -v protoc >/dev/null || { echo "error: protoc not found (brew install protobuf)"; exit 1; }
command -v protoc-gen-dart >/dev/null || {
  echo "protoc-gen-dart not found; installing protoc_plugin..."
  dart pub global activate protoc_plugin
}

# Resolve the sui-apis proto source (local checkout or a shallow clone).
CLEANUP_DIR=""
if [[ -n "${SUI_APIS_DIR:-}" ]]; then
  PROTO_ROOT="$SUI_APIS_DIR/proto"
else
  CLEANUP_DIR="$(mktemp -d)"
  echo "Cloning $SUI_APIS_REPO@$SUI_APIS_REF ..."
  git clone --depth 1 --branch "$SUI_APIS_REF" "$SUI_APIS_REPO" "$CLEANUP_DIR" >/dev/null 2>&1 \
    || git clone --depth 1 "$SUI_APIS_REPO" "$CLEANUP_DIR" >/dev/null
  PROTO_ROOT="$CLEANUP_DIR/proto"
fi
[[ -d "$PROTO_ROOT/sui/rpc/v2" ]] || { echo "error: protos not found at $PROTO_ROOT"; exit 1; }

echo "Regenerating Dart protos into $OUT_DIR ..."
rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"

( cd "$PROTO_ROOT" && protoc -I . --dart_out="$OUT_DIR" \
    sui/rpc/v2/*.proto \
    google/protobuf/*.proto \
    google/rpc/*.proto )

[[ -n "$CLEANUP_DIR" ]] && rm -rf "$CLEANUP_DIR"

COUNT="$(find "$OUT_DIR" -name '*.dart' | wc -l | tr -d ' ')"
echo "Done: generated $COUNT Dart files."
echo "Review with: git diff lib/grpc/proto && (cd $PKG_DIR && flutter analyze lib/grpc/proto)"
