# Global

Personal rules applied to all projects.

Language-specific style guides are loaded automatically via `opencode.json`.

## Config file maintenance

When you notice opportunities to improve your own instruction files, skills, or configuration in `~/.config/opencode/`, proactively suggest the change.
Only suggest changes you are confident about.

Note that some `~/.config/opencode` files are synced to a repository.
If adding a new skill file (or similar), follow the existing symlink pattern to also update this repository.

## Markdown Files

Do not insert line-breaks in the middle of sentences or bullets.
Sentences within a paragraph may be placed on consecutive lines.

## Subagent usage

The guiding principle is cost-conscious delegation: use low-cost tokens where quality matters less, and offload to subagents when the main risk is polluting the parent's context window.

- Reuse subagent instances when their contexts overlap, by resuming a session with its `task_id` instead of spawning a fresh one.
- Prefer lightweight or medium subagents for repetitive tasks (e.g. code refactors), inductive tasks (e.g. writing unit tests), or mechanical tasks (e.g. fixing compiler errors, tracing code).
- Prefer heavy subagents for research and other information-gathering tasks that distill a large amount of information into a far more compact useful context, to save context window space.
