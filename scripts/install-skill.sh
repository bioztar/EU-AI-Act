#!/usr/bin/env bash
# install-skill.sh — install the EU AI Act compliance skill into AI-harness skill dirs.
#
# Usage:
#   ./scripts/install-skill.sh            # install to every harness dir that exists
#   ./scripts/install-skill.sh --all      # create + install to all known dirs
#   ./scripts/install-skill.sh --claude   # ~/.claude/skills only
#   ./scripts/install-skill.sh --pi       # ~/.pi/agent/skills only
#   ./scripts/install-skill.sh --codex    # ~/.agents/skills only
#   ./scripts/install-skill.sh --copy     # copy instead of symlink (default: symlink)
#
# Symlink (default) vs copy: symlinks track this repo's updates with zero re-install;
# copies are self-contained and survive repo deletion/moves. Trade-off in one line:
# link for development, copy for stability.
set -euo pipefail

SKILL_NAME="eu-ai-act-compliance"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/../skill"

MODE="existing"   # existing | all | claude | pi | codex
LINK=1

for arg in "$@"; do
  case "$arg" in
    --all)    MODE="all" ;;
    --claude) MODE="claude" ;;
    --pi)     MODE="pi" ;;
    --codex)  MODE="codex" ;;
    --copy)   LINK=0 ;;
    -h|--help) sed -n '2,12p' "$0"; exit 0 ;;
    *) echo "unknown option: $arg" >&2; exit 1 ;;
  esac
done

[ -f "$SRC/SKILL.md" ] || { echo "error: $SRC/SKILL.md not found — run from the repo checkout" >&2; exit 1; }

install_to() {
  local base="$1"
  local dest="$base/$SKILL_NAME"
  mkdir -p "$base"
  rm -rf "$dest"
  if [ "$LINK" -eq 1 ]; then
    ln -s "$(cd "$SRC" && pwd)" "$dest"
  else
    cp -R "$SRC" "$dest"
  fi
  echo "installed -> $dest ($([ "$LINK" -eq 1 ] && echo symlink || echo copy))"
}

case "$MODE" in
  all)
    for d in "$HOME/.claude/skills" "$HOME/.pi/agent/skills" "$HOME/.agents/skills"; do
      install_to "$d"
    done
    ;;
  claude) install_to "$HOME/.claude/skills" ;;
  pi)     install_to "$HOME/.pi/agent/skills" ;;
  codex)  install_to "$HOME/.agents/skills" ;;
  existing)
    found=0
    for d in "$HOME/.claude/skills" "$HOME/.pi/agent/skills" "$HOME/.agents/skills"; do
      if [ -d "$d" ]; then install_to "$d"; found=1; fi
    done
    [ "$found" -eq 1 ] || { echo "no harness skill dirs found; use --all to create them" >&2; exit 1; }
    ;;
esac
