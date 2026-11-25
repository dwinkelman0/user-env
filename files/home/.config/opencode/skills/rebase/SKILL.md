---
name: rebase
description: Safe git rebase workflow. Load when rebasing, resolving rebase conflicts, or rewriting local history.
---

# Rebase

## Prerequisites

- Confirm the explicit rebase target and the exact commit stack before starting; do not start until both are stated.
- Confirm the remote already has all local changes (pushed / backed up) before starting; abort if not — the remote is the recovery point, not a local branch or tag backup.
- Start from a clean tree (`git status --porcelain` empty: stash or commit first, no autostash reliance) with the target freshly fetched; do not fetch or retarget mid-rebase.

OK — `git log --oneline origin/main..HEAD` shows 3 intended commits, remote has them, tree is clean, then `git rebase origin/main`.

Not OK — starting with an unpushed stack, a dirty tree, or only a vague idea of which commits will be rewritten.

## Resolve commit by commit

- Resolve one stopped commit at a time; stage a file only when it is genuinely resolved.
- Assume each resolution is correct pending the final check: verify only absence of conflict markers plus a compile and/or typecheck check (no test execution per commit), then continue fast.
- If a per-commit build check fails, note whether it also fails on the pre-rebase / remote state to distinguish pre-existing failure from resolution error, but default to continuing.
- Abort if a stop conflicts in files the listed stack never touched, or the stopped commit is not in the Prerequisites stack.
- Drop commits emptied by already-upstream changes and note the reduced stack count.

OK — resolve this commit, confirm no markers plus compile/typecheck passes, then continue.

Not OK — running tests at every stopped commit, deep-verifying intent per commit, or keeping empty already-upstream commits.

## Finish

- Verify final log shape (accounting for fixup/squash/drops) and confirm the tip-vs-recovery diff contains only the new base plus intended reshaping, then run the full test suite once.
- On regression after finish, assume deterministic failures by default and bisect the rebased stack to find the culprit commit; bisect does not apply to flaky tests — reproduce twice at tip first.
- Publish a rewritten branch with lease-based force-push only, never on shared branches.

OK — finish rebase, check log shape and tip-vs-recovery diff, run full tests once, bisect deterministic failures.

Not OK — running the full suite per commit during the rebase, skipping post-rebase verification, or force-pushing without a lease or to a shared branch.
