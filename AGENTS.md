# user-env

Personal dotfiles repository. Sets up symlinks from `$HOME` to dot files maintained in this repo.

## Structure

- `files/home/` — dot files (`~/.vimrc`, `~/.zshrc`, `~/.tmux.conf`)
- `src/` — utility scripts (e.g. `find-bash.sh`)
- `instructions/` — shared style guides loaded globally via opencode
- `setup.sh` — main entry point; fetches latest, creates symlinks

## Running

```bash
./setup.sh
```
