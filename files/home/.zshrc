# Homebrew should take precedence over all else
eval "$(/opt/homebrew/bin/brew shellenv)"

# Key bindings
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# TODO: ^? deletes whole word on some systems
#bindkey "^?" backward-kill-word
export PATH="$HOME/.local/bin:$PATH"
