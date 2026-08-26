#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BASH="$("$SCRIPT_DIR/src/find-bash.sh")"
exec "$BASH" "$SCRIPT_DIR/setup.sh" "$@"
