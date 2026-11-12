#!/usr/bin/env bash
#
# Regenerate the Dart protobuf message classes under lib/grpc/proto from the
# official Sui API protos (`sui.rpc.v2`).
#
# Requirements:
#   - protoc            (brew install protobuf)
#   - protoc-gen-dart   (protoc_plugin 22.4.0; installed if necessary)
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
SUI_APIS_REF="${SUI_APIS_REF:-aa9ba2c13b2a9348059b38110e64af39849a0377}"

# Repo root (this script lives in <pkg>/tool).
PKG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="$PKG_DIR/lib/grpc/proto"

# Use the pinned global plugin, even if another version appears first on PATH.
PROTOC_PLUGIN_VERSION="22.4.0"
DART_PUB_CACHE="${PUB_CACHE:-$HOME/.pub-cache}"
command -v protoc >/dev/null || { echo "error: protoc not found (brew install protobuf)"; exit 1; }
if [[ "$(dart pub global list | sed -n 's/^protoc_plugin //p')" != "$PROTOC_PLUGIN_VERSION" ]]; then
  echo "Installing protoc_plugin $PROTOC_PLUGIN_VERSION..."
  dart pub global activate protoc_plugin "$PROTOC_PLUGIN_VERSION"
fi
PROTOC_DART="$DART_PUB_CACHE/bin/protoc-gen-dart"

# Resolve the sui-apis proto source (local checkout or a shallow clone).
CLEANUP_DIR="$(mktemp -d)"
trap 'rm -rf "$CLEANUP_DIR"' EXIT
if [[ -n "${SUI_APIS_DIR:-}" ]]; then
  EXPECTED_COMMIT="$(git -C "$SUI_APIS_DIR" rev-parse "$SUI_APIS_REF^{commit}")"
  ACTUAL_COMMIT="$(git -C "$SUI_APIS_DIR" rev-parse HEAD)"
  [[ "$ACTUAL_COMMIT" == "$EXPECTED_COMMIT" ]] || {
    echo "error: local sui-apis HEAD differs from $SUI_APIS_REF; checkout that ref or set SUI_APIS_REF explicitly"
    exit 1
  }
  git -C "$SUI_APIS_DIR" diff --quiet HEAD -- proto || {
    echo "error: local protobuf sources have uncommitted changes"
    exit 1
  }
  # git diff does not include untracked (or ignored) source files, but the
  # protoc glob below would compile them and silently change pinned output.
  if [[ -n "$(git -C "$SUI_APIS_DIR" ls-files --others -- proto)" ]]; then
    echo "error: local protobuf sources contain untracked files"
    exit 1
  fi
  PROTO_ROOT="$SUI_APIS_DIR/proto"
else
  echo "Cloning $SUI_APIS_REPO@$SUI_APIS_REF ..."
  git -C "$CLEANUP_DIR" init -q
  git -C "$CLEANUP_DIR" remote add origin "$SUI_APIS_REPO"
  git -C "$CLEANUP_DIR" fetch -q --depth 1 origin "$SUI_APIS_REF"
  git -C "$CLEANUP_DIR" checkout -q --detach FETCH_HEAD
  PROTO_ROOT="$CLEANUP_DIR/proto"
fi
[[ -d "$PROTO_ROOT/sui/rpc/v2" ]] || { echo "error: protos not found at $PROTO_ROOT"; exit 1; }

echo "Regenerating Dart protos into $OUT_DIR ..."
GENERATED_DIR="$CLEANUP_DIR/generated"
mkdir -p "$GENERATED_DIR"

( cd "$PROTO_ROOT" && protoc -I . --plugin="protoc-gen-dart=$PROTOC_DART" --dart_out="$GENERATED_DIR" \
    sui/rpc/v2/*.proto \
    google/protobuf/*.proto \
    google/rpc/*.proto )

# Keep generated output consistent with checked-in Dart source formatting.
dart format "$GENERATED_DIR" >/dev/null

# Replace checked-in output only after protoc succeeds.
rm -rf "$OUT_DIR"
mv "$GENERATED_DIR" "$OUT_DIR"

COUNT="$(find "$OUT_DIR" -name '*.dart' | wc -l | tr -d ' ')"
echo "Done: generated $COUNT Dart files."
echo "Review with: git diff lib/grpc/proto && (cd $PKG_DIR && flutter analyze lib/grpc/proto)"
