#!/bin/bash
set -euo pipefail

RED='\033[91m'
GREEN='\033[92m'
YELLOW='\033[93m'
GREY='\033[90m'
RESET='\033[0m'

log()   { printf "${GREY}%s${RESET}\n" "$1"; }
ok()    { printf "${GREEN}%s${RESET}\n" "$1"; }
warn()  { printf "${YELLOW}%s${RESET}\n" "$1" >&2; }
err()   { printf "${RED}%s${RESET}\n" "$1" >&2; }

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
    ["$HOME/.config/opencode/AGENTS.md"]="files/home/.config/opencode/AGENTS.md"
    ["$HOME/.config/opencode/opencode.json"]="files/home/.config/opencode/opencode.json"
    ["$HOME/.config/opencode/skills/bash/SKILL.md"]="files/home/.config/opencode/skills/bash/SKILL.md"
)

log "Fetching from origin..."
git fetch origin

if git diff --quiet && git diff --cached --quiet; then
    if git merge-base --is-ancestor HEAD origin/main; then
        git merge --ff-only origin/main
        ok "Fast-forwarded to latest origin/main"
    else
        warn "HEAD is not in main's history, skipping update"
    fi
else
    warn "Working tree has uncommitted changes, skipping update"
fi

for dest in "${!SYMLINKS[@]}"; do
    mkdir -p "$(dirname "$dest")"
    if [[ -e "$dest" || -L "$dest" ]]; then
        if [[ -L "$dest" ]]; then
            link_target="$(readlink "$dest")"
            if [[ "$link_target" == "$cwd/${SYMLINKS[$dest]}" ]]; then
                log "Symlink already correct: $dest -> ${SYMLINKS[$dest]}"
                continue
            fi
            case "$link_target" in
                "$cwd"/*)
                    rm "$dest"
                    ok "Replaced existing symlink: $dest"
                    ;;
                *)
                    err "error: $dest is a symlink but does not point within this repo: $link_target"
                    exit 1
                    ;;
            esac
        else
            err "error: $dest already exists and is not a symlink."
            exit 1
        fi
    fi
    ln -s "$cwd/${SYMLINKS[$dest]}" "$dest"
    ok "Created symlink: $dest -> ${SYMLINKS[$dest]}"
done
