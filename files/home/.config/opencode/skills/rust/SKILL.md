---
name: rust
description: Rust style guide and conventions. Load when writing, editing, or reviewing Rust code.
---

# Rust Style

## Use Clap for CLIs

Build command-line interfaces with the `clap` crate (derive API where practical) instead of hand-rolled argument parsing.

## Prefer imports over fully qualified names

Strongly avoid fully qualified names in code. Import with `use` and refer to items by their short name: `use std::fmt::Debug;` and then just `Debug`; `use tokio::sync::mpsc::channel;` and then just `channel`.

Only fall back to a fully qualified path when it genuinely decreases ambiguity, e.g. two in-scope items clash after import, or the qualified form makes a call site meaningfully clearer.

## Prefer functional style over imperative

Favor iterators and combinators (`map`, `filter`, `fold`, `collect`, closures) over explicit mutable loops and accumulators. Reserve imperative loops for cases that are genuinely clearer that way.

## Idiomatic Rust

Avoid bare `.unwrap()` outside tests; prefer `?`. When a panic is genuinely the behavior you want, use `expect` with a message that explains why it can't happen.

Use `let-else` to bind and bail early, and `if let` / `match` instead of defensive nesting.

Borrow by default: take `&str` / `&[T]` parameters rather than owned types, and clone only when independent ownership is truly required.

Prefer `Option`/`Result` combinators (`map`, `and_then`, `ok_or`, `filter_map`) over manual `match` where they read clearly.

## Dependencies

Use `serde` (derive `Serialize`/`Deserialize`) for any serialization or deserialization need. Never hand-write JSON parsing.

## Observability

Use `tracing` (spans, field recording) instead of `println!` for behavior you'll need to debug.

## Error handling

If the errors are well-defined and demanded by the domain, model them with an error enum (e.g. `thiserror`-derived). Otherwise — for file IO, network, tokio, and other off-the-shelf failures — use `anyhow::Result`. Don't invent enums around errors you don't control.