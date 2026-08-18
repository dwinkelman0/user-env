#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

CANDIDATES=(
    /opt/homebrew/bin/bash
    /usr/local/bin/bash
    /bin/bash
)

for candidate in "${CANDIDATES[@]}"; do
    if [[ -x "$candidate" ]]; then
        exec "$candidate" "$SCRIPT_DIR/setup.sh" "$@"
    fi
done

echo "error: no bash found" >&2
exit 1
