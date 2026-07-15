#!/usr/bin/env bash
# Drop the portable Zoro + guardrails context file into a target agentic IDE.
# Usage: ./install-portable.sh [cursor|codex|windsurf|gemini|generic] [target-dir]
# Default target-dir is the current directory. AGENTS.md is the safe default —
# Cursor and Codex read it natively; other tools want a specific filename.
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)/AGENTS.md"
TOOL="${1:-generic}"
DIR="${2:-$PWD}"

[ -f "$SRC" ] || { echo "error: AGENTS.md not found next to this script"; exit 1; }

case "$TOOL" in
  cursor|codex|agents|generic)
    cp "$SRC" "$DIR/AGENTS.md";       echo "installed -> $DIR/AGENTS.md" ;;
  gemini)
    cp "$SRC" "$DIR/GEMINI.md";       echo "installed -> $DIR/GEMINI.md" ;;
  windsurf)
    cp "$SRC" "$DIR/.windsurfrules";  echo "installed -> $DIR/.windsurfrules" ;;
  *)
    echo "unknown tool: $TOOL (use cursor|codex|windsurf|gemini|generic)"; exit 1 ;;
esac
