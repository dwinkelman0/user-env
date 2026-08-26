---
name: bash
description: Bash scripting style guide and conventions. Load when editing shell scripts.
---

# Bash Style

## Safety

- Always start scripts with `set -euo pipefail`
- Use `[[ ]]` for conditionals, never `[ ]`
- Quote all variable expansions
- Use `$(...)` for command substitution, never backticks

## Formatting

- Use 4-space indentation
- Use POSIX-compatible syntax unless a bash feature is explicitly needed

## Output

- Use color logging helpers (`log`, `ok`, `warn`, `err`) with bright color variants for terminal output
- Write interactive messages or output to stdout
- Write logging, warnings, and errors to stderr
