---
name: investigation-economics
description: Use when stuck in a guess-fix-retry loop on a slow or costly feedback cycle, when about to consult another AI before searching the exact error string, when tempted to stage several fixes in parallel, or when starting a migration/plan whose viability rests on one unproven assumption.
---

# Investigation Economics

## Overview
When a feedback cycle is expensive — long builds, CI runs, deploys, costly compute or API calls — the cost gap between *researching* and *iterating* is enormous, yet the instinct under pressure is to iterate. **One careful read of the whole log/source usually ends a loop that ten retries would not.**

## The rules

- **research-before-iterate** — On any loop where one cycle costs more than a few minutes, the **second** failure is the stop signal: stop guessing, read the entire log/source/docs before the next attempt. The deciding clue is usually already in the first output you skimmed past.
- **primary-sources-first** — For a named error, symbol, API, capability, or version: grep the codebase / search the **exact string** before deduction or an AI second-opinion. AIs hallucinate confident, plausible-looking falsehoods (a wrong version number, a dead URL). They're backup, not the first move.
- **cheapest-test-first** — Try the one-line local change before researching expensive alternatives or staging variant ladders. Sequential, one step at a time — not premature parallel. The cheap option often closes the loop and turns the staged work into sunk cost.
- **kill-shot-on-day-zero** — Before any migration or multi-step plan, ask *"what single fact, if false, kills this?"* and test **that** first. Finding the deal-breaker late wastes the whole runway.

## Quick reference

| Situation | Move |
|---|---|
| 2nd retry failed on a slow cycle | Stop. Read the full log/source. Don't retry on a guess. |
| Named error / API / version | Search the exact string first; AI opinion is backup |
| Several possible fixes | Try the cheapest one-liner first, sequentially |
| Starting a migration/plan | Test the load-bearing assumption on day zero |

## Common mistakes
- Treating an expensive cycle as if it were free, then spending many of them guessing.
- Averaging two contradicting AI/reviewer opinions instead of reading the disagreement as a signal to **investigate the layer below**.
- Building several untested variants before trying the single cheap local fix.

## Red flags — STOP
- "Let me just try one more thing" (on attempt 3+, with no new information)
- "Another AI says…" (before you searched the exact identifier yourself)
- "I'll stage all the options so they're ready" (before the cheap test ran)
