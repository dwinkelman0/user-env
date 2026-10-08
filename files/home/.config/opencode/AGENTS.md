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
Default to reusing an existing subagent whose context already aligns with the task, by resuming its session with its `task_id`, rather than spawning a fresh one.
Create a new subagent only for a genuinely new task that demands substantial new context, or when you need parallelism and all suitably-aligned agents are already busy.
Match tier to task: fast for read-only lookup, medium for implementation, heavy for architecture and deep debugging.
