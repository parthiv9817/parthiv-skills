# parthiv-skills

A portable, project-agnostic set of engineering guardrails for Claude Code —
distilled from two months of my own documented mistakes, cross-checked against
Andrej Karpathy's coding guidelines and Anthropic's subagent/cost guidance.

**The point:** the best skills to encode are the ones you've already paid for in
real failures. These ride with me into every project, alongside `superpowers`.

## Architecture (hybrid)

Two layers, by token economics:

- **Always-on core** — the ~8 highest-frequency, universal one-liners live in my
  global `~/.claude/CLAUDE.md` (loaded every turn; kept terse on purpose).
- **Modular on-demand skills** — the detailed versions live here as separate
  `SKILL.md` files, loaded only when the situation calls for one (progressive
  disclosure, like `superpowers`).

## The skills

| Skill | Use when |
|---|---|
| `verifying-before-claiming` | About to state a root cause, declare "works/done", or read ambiguous evidence |
| `investigation-economics` | Stuck in a guess-fix-retry loop on a costly cycle; about to ask an AI before searching |
| `surgical-scope` | Over-building for the stage; editing config/shared state; touching code you didn't write |
| `delegation-and-model-routing` | Spawning subagents / fanning out; choosing which model a worker runs on |
| `process-and-collaboration` | Fallback paths, multi-attempt debugging, committing, risky ops, "good enough" calls |

## Install

These are personal Claude Code skills. To make Claude Code load them, symlink (or
copy) each into your personal skills directory:

```bash
mkdir -p ~/.claude/skills
for d in ~/Documents/parthiv-skills/skills/*/; do
  ln -sfn "$d" ~/.claude/skills/"$(basename "$d")"
done
```

(Symlinks let you keep editing in the repo and push to GitHub while Claude Code
loads the live versions.)

## Relationship to superpowers

Complementary, not competing. `superpowers` provides heavy process *methodologies*
(TDD, systematic-debugging, writing-plans). `parthiv-skills` provides behavioral
*guardrails* — the verify/scope/delegation discipline that sits underneath any
methodology. Run both.

## Provenance

- **DS1** — Karpathy's `andrej-karpathy-skills` (Think-Before-Coding, Simplicity-First,
  Surgical-Changes, Goal-Driven-Verification) + Anthropic subagent/model-routing guidance.
- **DS2** — my own `diaries/` + `mistakes/` + `epilogue/` corpus (the failures these
  guardrails are built to prevent).

The two sources converged on the same principles independently — which is the
reason to trust them.
