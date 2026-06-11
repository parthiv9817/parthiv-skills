---
name: process-and-collaboration
description: Use when adding a fallback/degraded path, debugging a multi-variable bug across several attempts, deciding how to present options to a user, about to commit or push, starting a risky/long operation, or judging when a piece of work is "good enough" to stop.
---

# Process & Collaboration

## Overview
A cluster of working-discipline guardrails that protect the loop around the code: how failure paths behave, how to debug without thrashing, how to communicate, when to persist, when to stop.

## The rules

- **fail-loud** — No silent or warning-only fallback paths in code you're actively debugging. A degraded path that only logs a warning makes you debug a *different* code path than you think. Make fallbacks loud (error + visible) or remove them while debugging.
- **test-matrix-by-attempt-3** — On a multi-variable bug, by the third attempt write a `{variables → outcome}` matrix. Never propose a state that already failed. When two reviewers/auditors contradict each other, that's a signal to **investigate the layer below**, not to average them.
- **decision-not-menu** — Default to **one** recommendation plus its justification. Surface a menu of options only on explicit request or a genuine close call. Match the register to the audience: domain-first and concise for an expert; decision-forward and maturity-matched for a stakeholder; never lead with "X is broken."
- **persist-before-risk** — Push to a remote and brain-dump in-flight reasoning to a durable doc **before** closing a session or running a risky/irreversible experiment. Local-only history and an unsaved train of thought are single points of failure.
- **commit-on-explicit-go** — Never auto-commit. Stage freely; commit only on explicit approval, and only after the gating end-to-end check has passed. Build → e2e → then commit, in that order.
- **set-the-good-enough-bar** — Define a falsifiable "done" *before* polishing — without a bar, polish runs forever. When a limit is foundation/hardware-bound rather than effort-bound, prove it cheaply (a minimal falsification) and **park it** instead of grinding.

## Quick reference

| Situation | Move |
|---|---|
| Adding a fallback | Make it loud, or remove it while debugging |
| 3rd attempt on a bug | Write the `{var → outcome}` matrix; don't re-try a failed state |
| Presenting to a user | One recommendation + why; menu only on request |
| About to close a session / risky op | Push + brain-dump first |
| About to commit | Approved? e2e passed? Only then. |
| Polishing | Is "done" defined? Is this a real ceiling? Park it if so. |

## Common mistakes
- A warning-only guard sending you down the wrong code path for hours.
- Re-proposing a configuration that an earlier attempt already disproved.
- Dumping a menu of options on someone who needed a decision; over-explaining to an expert; leading a stakeholder with a problem instead of a plan.

## Red flags — STOP
- "I'll add a quiet fallback so it doesn't crash" (while debugging)
- "Let me just commit this real quick" (no approval, no e2e)
- "One more polish pass" (no defined bar; possibly past a real ceiling)
- Closing the terminal with un-pushed code or un-captured reasoning
