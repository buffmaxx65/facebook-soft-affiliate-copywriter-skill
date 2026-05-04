#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/buffmaxx65/facebook-soft-affiliate-copywriter-skill.git"
SKILL_NAME="facebook-soft-affiliate-copywriter"
SCOPE="${SCOPE:-shared}"

if [[ -z "${SKILL_DIR:-}" ]]; then
  case "$SCOPE" in
    shared) SKILL_DIR="$HOME/.openclaw/skills/$SKILL_NAME" ;;
    agent)  SKILL_DIR="$HOME/.agents/skills/$SKILL_NAME" ;;
    *) echo "Unknown SCOPE='$SCOPE'. Use 'shared' or 'agent'." >&2; exit 1 ;;
  esac
fi

mkdir -p "$(dirname "$SKILL_DIR")"
if [[ -d "$SKILL_DIR/.git" ]]; then
  git -C "$SKILL_DIR" pull --ff-only
else
  if [[ -e "$SKILL_DIR" ]]; then
    echo "ERROR: $SKILL_DIR exists but is not a git repo. Aborting." >&2
    exit 1
  fi
  git clone --depth=1 "$REPO_URL" "$SKILL_DIR"
fi

echo "==> Installed $SKILL_NAME"
