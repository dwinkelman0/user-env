---
name: test-coverage
description: Unit and integration test coverage principles. Load when writing, reviewing, or pruning tests.
---

# Test Coverage

Complements the coding skill's test-coverage section: be stingy, match the phase, and spend coverage where breakage is likely or costly.

## Skip trivial and transparent code

- Skip wrappers that add no assumptions or mutations: pure delegation, pass-through overloads, constructors that only assign fields.
- Skip getters, setters, and simple accessors with no logic worth asserting.
- Skip transparent code: fits on one screen, simple, does what its name implies, and is widely consumed so other tests exercise it incidentally.

OK — no dedicated test for `get_name` returning `self.name`, or for `format_user` that only interpolates already-tested fields.

Not OK — leaving a hand-rolled parser untested because a thin wrapper around it is covered.

## Test functionality resting on assumptions likely to evolve

- Explicitly test behavior that depends on assumptions likely to change: ordering, string formats, boundary values, error mappings, retry and timeout policy.
- Each such test pins one assumption so breakage surfaces as a failing test, not a silent behavior change.
- When the assumption changes deliberately, update the test alongside the code.

OK — asserting the exact retry count and backoff for a flaky downstream call.

Not OK — asserting the exact wording of a user-facing message that churns weekly.

## Cover hot and warm branches only

- Give each core concern light, non-redundant class coverage: one test per behavior, no overlapping tests that fail for the same reason.
- Cover hot branches (the paths production takes most) and warm branches (likely failure modes, meaningful alternatives) by default.
- Skip cold edges unless the phase demands it: mature codebases cover every edge case, early ones cover the happy path plus wiring.

OK — `parse_input` tests for the happy path, one malformed input, and one boundary value.

Not OK — ten near-identical parametrizations of the same malformed-input path.

## Keep integration tests light and high-value

- Apply the same principles at integration scope: test likely-to-break seams (schema migrations, API contracts, queue and job wiring) and hot-path end-to-end flows.
- Prefer one test proving the pieces wire together over many tests re-proving unit-covered logic through the full stack.
- Avoid drowning in low-value tests for low-value or low-probability failure modes; delete integration tests that only ever fail for the same reason as a cheaper unit test.
