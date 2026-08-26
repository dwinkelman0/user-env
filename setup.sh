set -euxo pipefail

cd "$(dirname "$0")"
cwd="$(pwd)"

# Associative array: destination -> source (relative to repo)
declare -A SYMLINKS=(
    ["$HOME/.vimrc"]="files/home/.vimrc"
    ["$HOME/.tmux.conf"]="files/home/.tmux.conf"
    ["$HOME/.zshrc"]="files/home/.zshrc"
)

git pull origin main

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
