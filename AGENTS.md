# user-env

Personal dotfiles repository. Shell configs and opencode configuration are version-controlled here and symlinked into `$HOME` via `setup.sh`.

## Structure

- `files/home/` — dotfiles that get symlinked into `$HOME`
  - `.vimrc`, `.tmux.conf`, `.zshrc` — shell/editor configs
  - `.config/opencode/` — global opencode config and skills (AGENTS.md, skills, and `opencode.json` are symlinked via the table in `setup.sh`)
  - `.local/bin/` — user-facing CLI tools symlinked into `$HOME/.local/bin` (e.g. `opencode-cost`)
- `src/` — utility scripts (e.g. `find-bash.sh`)
- `setup.sh` — main entry point; fetches latest, creates symlinks

### opencode plugins

Plugins are declared in `files/home/.config/opencode/opencode.json` under the `"plugins"` key, using opencode's native package mechanism (e.g. `opencode-model-router`, unpinned). The repo is the source-of-truth via the symlink created by `setup.sh`; edit `opencode.json` to add, remove, or pin plugins.

The older `ocx` installer and the `kdco/worktree` plugin have been retired — `kdco/worktree` was V1-only and has no V2 port. The `~/.config/opencode/plugins/` directory may still contain legacy unmanaged files from before the migration; do not add new files there. Let `opencode.json` own plugin installation.

## Running

```bash
./setup.sh
```

### What setup.sh does

1. **Bash version check** — If running under Bash < 4, re-execs itself under a modern Bash found by `src/find-bash.sh` (checks Homebrew paths first, then system).
2. **Git auto-update** — Fetches from origin and fast-forwards `origin/main` if the working tree is clean. Warns and skips if dirty or if HEAD isn't in main's history.
3. **Symlink creation** — Creates symlinks from `files/home/*` into `$HOME`. Handles existing destinations carefully:
   - Skips if the symlink is already correct.
   - Replaces existing symlinks that point within the repo.
   - Errors if a non-symlink file exists at the destination (refuses to overwrite).
   - Errors if a symlink points outside the repo.

## Symlink targets

The table in `setup.sh` is the source-of-truth.

## Adding a new opencode skill

1. Create `files/home/.config/opencode/skills/<name>/SKILL.md` with `name` and `description` frontmatter.
2. Add a `["$HOME/.config/opencode/skills/<name>/SKILL.md"]="files/home/.config/opencode/skills/<name>/SKILL.md"` entry to the symlink table in `setup.sh`.
3. Run `./setup.sh` so the symlink is created.
4. Tell the user to quit and restart opencode for the skill to load.

Do not create symlinks or config files inside `~/.config/opencode/` directly; the repo is the source of truth.
