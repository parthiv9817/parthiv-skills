---
name: delegation-and-model-routing
description: Use when about to spawn subagents or fan out work, when a "do research / analyze X" request tempts a heavy multi-agent workflow, or when deciding which model a subagent should run on. Prevents token blowouts from over-weight tooling and frontier-model workers on cheap tasks.
---

# Delegation & Model Routing

## Overview
Two levers decide the bill on agentic work: **how much you fan out**, and **which model each worker runs on**. The default failure is firing a heavy multi-agent workflow at a bounded question, with every worker inheriting the frontier model — paying top price for a task a cheap model does identically.

Governing principle: **match the tool weight AND the model to the cognitive demand of the specific delegated task — which is almost always lower than the orchestrator's.** The conductor stays frontier; the section players go cheaper.

## The rules

- **match-tool-weight-to-scope** — A bounded question (one lookup, one fact, read these N files) gets a lightweight tool: a direct read, a grep, a single search, or one subagent. Reserve heavy multi-agent fan-out for genuinely broad, contested, or parallelizable work. "Research X" is not a license for a 100-agent sweep.
- **route every worker explicitly** — Never leave subagents on `inherit` of a frontier model. Assign each one a model by the task's actual demand (table below).
- **cap the fan-out** — Bound the number of concurrent agents. Prefer subagents for *context-isolation* (offloading bulky reads so they don't bloat the main context), not for everything.
- **subagents return summaries, not dumps** — A worker's return value is re-billed in your context every turn after. Have it return distilled findings, not raw file contents.

## Model routing (current pricing, per 1M tokens)

| Model | Input | Output | Role |
|---|---|---|---|
| Fable 5 | $10 | $50 | Hardest reasoning only; usually the orchestrator's tier |
| Opus 4.8 | $5 | $25 | Orchestrator; subagents doing genuine reasoning/synthesis |
| Sonnet 4.6 | $3 | $15 | Write / summarize-with-judgment / codegen / research synthesis |
| Haiku 4.5 | $1 | $5 | Read / search / gather / extract / classify / format |

| Subagent role | Use | Cost vs frontier |
|---|---|---|
| **Read / search / gather / extract** | **Haiku 4.5** | 5× cheaper than Opus, 10× cheaper than Fable |
| **Write / summarize / codegen / synthesize** | **Sonnet 4.6** | ~40% cheaper than Opus, ~3.3× cheaper than Fable |
| **Genuine reasoning / pattern synthesis** | **Opus 4.8** | the orchestrator's tier; use only when the *delegated* task truly reasons |

**Context-window caveat:** Haiku 4.5's window is **200K tokens** vs **1M** for Fable/Opus/Sonnet. For a single subagent that must ingest a very large corpus in one pass, the cheap model can overflow — **bump that one worker to Sonnet** (1M) even though it's "just reading." Match the model to *both* the reasoning demand and the input size.

**Session-wide ceiling:** `CLAUDE_CODE_SUBAGENT_MODEL` forces every subagent onto one model — a hard cost cap. But it also governs the planning agent, so don't floor it to Haiku (a weak planner causes compounding downstream errors). Use it as a deliberate ceiling, not a default.

## Quick reference

| Situation | Move |
|---|---|
| "Research / analyze X" | Is X bounded? If so, one read/search — not a fan-out |
| Spawning workers | Set each one's model explicitly by the table |
| A worker must read a huge corpus | Bump it to Sonnet (1M window), not Haiku (200K) |
| Need a hard cost cap | `CLAUDE_CODE_SUBAGENT_MODEL` — but not floored to Haiku |

## Red flags — STOP
- Firing a heavy multi-agent workflow at a single-doc lookup
- Letting workers `inherit` the frontier model by default
- A reading/searching subagent running on Fable/Opus
- Subagents returning raw dumps instead of summaries
