#!/bin/bash
set -euo pipefail

CANDIDATES=(
    /opt/homebrew/bin/bash
    /usr/local/bin/bash
    /bin/bash
)

for candidate in "${CANDIDATES[@]}"; do
    if [[ -x "$candidate" ]]; then
        echo "$candidate"
        exit 0
    fi
done

echo "error: no bash found" >&2
exit 1
