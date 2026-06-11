---
name: surgical-scope
description: Use when building a feature for an early-stage/prototype project, when about to add robustness/abstractions/error-handling beyond what was asked, when editing config/shared state, or when modifying code in a file you didn't write.
---

# Surgical Scope

## Overview
Two failure modes, one root: doing more than the task requires. Over-building dressed as thoroughness wastes the stage's real budget; "local" edits with unnamed dependents surface later as mysterious failures. **Build the minimum that solves the actual concern, and touch only what you must.**

(Converges with Andrej Karpathy's "Simplicity First" + "Surgical Changes" guidelines — and was reached independently from this author's own mistakes log.)

## The rules

- **right-size-to-stage** — Build the lean thing that covers the *actual* concern for the *current* stage. At prototype/POC stage, knowing what **not** to build is the senior move. Whatever you defer, **name it explicitly** so it reads as a decision, not an oversight. Don't add auth, retries, multi-tenant handling, or edge-case branches for conditions that can't occur yet.
- **name-the-dependents** — Before editing config or shared state, list what *reads or caches* it. The classic bites: a value the running process cached at startup (the edit does nothing until restart); a shared asset/constant that several other places reference by their own hardcoded copy (change one, the others still point at the old one); a setting toggle that silently breaks an unrelated subsystem. Restart the consumer; sweep **all** the references; check cross-cutting side-effects.
- **surgical-changes** — Touch only what the task requires. Preserve the surrounding style. Don't "improve" unrelated code. Remove only the imports/variables/dead code **your** change made obsolete — not pre-existing cruft.

## Quick reference

| Before you… | Ask |
|---|---|
| Add a feature | Does the *current stage* need it? If deferring, did I say so? |
| Edit a config / shared value | What reads or caches this? Restart needed? Other copies? |
| Touch a file you didn't write | Am I changing only what the task needs, in the existing style? |

## Common mistakes
- Gold-plating an early prototype with production-grade robustness, then being pulled back.
- Updating one of several references to a shared value from memory and missing the rest (reuse a written checklist — see `process-and-collaboration`).
- "Simplifying" or refactoring unrelated code mid-task, expanding the blast radius and the review surface.

## Red flags — STOP
- "While I'm here, let me also improve / abstract / harden…"
- "This is a local change, it's side-effect-free" (name the dependents first)
- Adding flexibility / config "for the future" nobody asked for
