set -euxo pipefail

cd "$(dirname "$0")"
cwd="$(pwd)"

# Associative array: destination -> source (relative to repo)
declare -A SYMLINKS=(
    ["$HOME/.vimrc"]=".vimrc"
    ["$HOME/.tmux.conf"]=".tmux.conf"
    ["$HOME/.zshrc"]=".zshrc"
)

git pull origin main

for dest in "${!SYMLINKS[@]}"; do
    mkdir -p "$(dirname "$dest")"
    ln -sf "$cwd/${SYMLINKS[$dest]}" "$dest"
done
