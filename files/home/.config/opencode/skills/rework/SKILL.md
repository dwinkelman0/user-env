---
name: rework
description: Code refactoring goals and patterns. Load when refactoring, cleaning up, or restructuring code.
---

# Rework

## Correct abstraction boundaries

- Put logic at the level where it belongs: orchestration up top, details pushed down.
- A caller should not reach through an abstraction to manipulate its internals.
- When a function needs intimate knowledge of another module's data structures, move the behavior next to the data.

OK — behavior lives with the data it operates on.

Not OK — a caller unpacking another module's internals to make a decision for it.

## Remove vestigial functionality

- Delete flags, options, and branches that exist for a past requirement nobody holds anymore.
- When a parameter is always passed the same value, inline it and drop the parameter.
- Prefer deleting a compatibility shim over extending it.

## Remove change-narrating comments

- Delete comments that describe what changed instead of adding genuinely new information.
- A comment should explain why something surprising is correct, not narrate the edit history; git already records that.

OK — `// Retry with backoff: the API returns 429 under burst load.`

Not OK — `// Changed to retry 3 times`, `// Refactored for cleanup`, `// Updated logic`.

## Reuse at N=3, or N=2 with a compelling reason

- Extract a shared helper on the third duplication (N=3).
- At N=2, extract only with a compelling reason: the logic is subtle, error-prone, or certain to spread.
- Name the helper after what it means, not after the two call sites it happens to serve.

## Reduce conditional logic

- Replace flag parameters and `if/else` chains with separate functions, polymorphism, or lookup tables where they clarify intent.
- Flatten nesting with early returns instead of deeply nested branches.
- Prefer exhaustive handling (match/switch with no default-swallowing) over chains of loosely related conditions.

OK — two small functions, `render_empty` and `render_rows`, instead of one function switching on `is_empty` throughout.

Not OK — a boolean parameter that toggles half the behavior of a function.

## Single-concern classes

- Each class or module owns one concern; split it when it accumulates unrelated responsibilities.
- Group methods by the state they share; disjoint state is a signal to split.
- Keep public surface minimal: expose what callers need, hide the rest.

## Delete dead code paths

- Remove unreachable branches, unused functions, and commented-out code outright.
- Do not leave dead code "just in case"; version control preserves it if it is ever needed.
- After deleting, remove the now-unused imports, parameters, and tests that only covered the dead path.

## Prefer explicit over clever

- Choose straightforward code a new reader can follow over a compact trick.
- Avoid metaprogramming, implicit magic, and overloaded meanings when a plain function or explicit argument works.
- Cleverness must pay for itself in a measurable reduction of real duplication or risk; otherwise spell it out.
