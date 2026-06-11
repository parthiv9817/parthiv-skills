---
name: verifying-before-claiming
description: Use when about to state a root cause, declare something "works"/"fixed"/"done", assert a fact, API name, or behavior, or read ambiguous evidence (logs, screenshots, build/compile output) — especially when a user with direct runtime observation contradicts your inference.
---

# Verifying Before Claiming

## Overview
The most expensive and most frequent failure mode: stating a confident claim when a sub-60-second check would have confirmed or killed it. **A claim is a hypothesis until it has touched the real surface.**

Core rule: **if you can verify in <60s and being wrong costs >5min, verify first.**

## The rules

- **verify-before-assert** — No "root cause found", "this works", "X exists" without running the check first. The check is cheaper than being wrong, every time.
- **compiles-is-not-validated** — A successful compile / import / type-check / lint / clean `git status` is **not** validation. The gate is a real end-to-end run on the actual surface — the live request, the running app, the actual user-facing path. Gate "done" (and commits) on the e2e, not the build.
- **measure-don't-theorize** — Isolate and measure the suspected variable before asserting a mechanism. One datapoint, or an abandoned run, is not a cause.
- **ground-truth-wins** — The actual running system / source / on-disk state beats the spec, the docs, your notes, a vendor's label, your memory, and your inference. When the user reports what they directly observe at runtime, believe the running system over your log-reading — logs lag, buffer, and drop.
- **hypothesis-not-verdict** — Frame fixes as *"might be it — test via X"*, never "ROOT CAUSE FOUND", until empirically proven. False certainty doubles the cost on failure: the bug, plus the lost credibility.

## Quick reference

| About to say… | Do first |
|---|---|
| "The root cause is X" | Reproduce/measure X in isolation |
| "It's fixed / it works" | Run the real end-to-end path |
| "X function / flag / API exists" | Read the actual source / signature |
| "It's running my change" | Confirm which build/version/branch is actually live |
| User: "I see Y when I run it" | Believe their observation; verify your counter-theory before voicing it |

## Common mistakes
- Substituting a cheap proxy check (imports pass, partial count looks right) for the real one, then claiming the stronger conclusion.
- Defending an inference when the user's direct observation contradicts it. The user's observation of the running system wins — go verify.
- Treating a long command's success as proof the *artifact it produced* matches what the failing system actually needs.

## Red flags — STOP
- "I already checked it" (did you check the *real* surface, or a proxy?)
- "It builds, so it's done"
- "The screenshot/log looks right" (reading ambiguous evidence in the direction you want it to point)
- "Surely the default / label / spec is correct"
