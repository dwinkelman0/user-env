#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Re-exec under a modern bash if the current one is too old
if [[ "${BASH_VERSION%%.*}" -lt 4 ]]; then
    BASH="$("$SCRIPT_DIR/src/find-bash.sh")"
    exec "$BASH" "$0" "$@"
fi

cd "$SCRIPT_DIR"
cwd="$(pwd)"

declare -A SYMLINKS=(
    ["$HOME/.vimrc"]="files/home/.vimrc"
    ["$HOME/.tmux.conf"]="files/home/.tmux.conf"
    ["$HOME/.zshrc"]="files/home/.zshrc"
)

git fetch origin

if git diff --quiet && git diff --cached --quiet; then
    if git merge-base --is-ancestor HEAD origin/main; then
        git merge --ff-only origin/main
    else
        echo "warning: HEAD is not in main's history, skipping update" >&2
    fi
else
    echo "warning: working tree has uncommitted changes, skipping update" >&2
fi

for dest in "${!SYMLINKS[@]}"; do
    mkdir -p "$(dirname "$dest")"
    if [[ -e "$dest" || -L "$dest" ]]; then
        if [[ -L "$dest" ]]; then
            link_target="$(readlink "$dest")"
            case "$link_target" in
                "$cwd"/*) rm "$dest" ;;
                *) echo "error: $dest is a symlink but does not point within this repo: $link_target" >&2; exit 1 ;;
            esac
        else
            echo "error: $dest already exists and is not a symlink." >&2
            exit 1
        fi
    fi
    ln -s "$cwd/${SYMLINKS[$dest]}" "$dest"
done
