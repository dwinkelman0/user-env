---
name: coding
description: General-purpose coding conventions and naming rules, applied in any language. Load when writing, editing, or reviewing code.
---

# Code Style

## Function and method names are verbs

Every function or method name must be a predicate: an imperative verb or verb phrase, never a bare noun. Apply the rule in any language's casing, e.g. `get_length` / `getLength`.

OK — verbs and verb phrases:

- `get_length`, `find_user`, `initialize`, `send`, `run`, `parse_input`, `compute_total`, `load_config`

Not OK — bare nouns:

- `length`, `count`, `action`, `price`, `total`, `config`

Verb-prefixed names improve comprehension and searchability.

Bare nouns are fine for variables and parameters.

## Boolean-returning functions are predicates too

Functions that return a boolean should be named with `is_…`, `has_…`, `can_…`, or `should_…` so they read as assertions:

- `is_valid`, `has_children`, `can_edit`, `should_retry`

## Test coverage

Be stingy with test coverage. Skip tests for simple code with a high probability of working; a passing test there documents nothing you couldn't verify by reading the code. Effort scales with a codebase's maturity:

- Phase 1 (early): a handful of medium-complexity tests that exercise the happy path and prove the core pieces wire together.
- Phase 2 (starting to lock down): high-complexity, more integrative tests that cover interactions across modules.
- Phase 3 (mature): cover every little edge case, including error paths and boundary conditions.

Match the phase, not your personal appetite for coverage.
