#!/bin/bash
# sync.sh — copies Obsidian agent/skill files to Claude Code
# Run from anywhere: bash <vault>/HQ/05_Agents/13_shared_data/sync.sh
# Compatible with macOS bash 3.2+

set -e

# Derived from this script's own location (HQ/05_Agents/13_shared_data/sync.sh),
# so it works on every machine without a hard-coded home path.
AGENTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$HOME/.claude/agents" "$HOME/.claude/skills"

MISSING_COUNT=0

echo "Syncing agents and skills to ~/.claude/ ..."

sync_agent() {
  local folder="$1"
  local name="$2"
  local agent_src="$AGENTS_DIR/$folder/agent.md"
  local skill_src="$AGENTS_DIR/$folder/skill.md"

  if [ -f "$agent_src" ]; then
    cp "$agent_src" "$HOME/.claude/agents/$name.md"
    echo "  ✓ agents/$name.md"
  else
    echo "  ✗ MISSING: $agent_src"
    MISSING_COUNT=$((MISSING_COUNT + 1))
  fi

  if [ -f "$skill_src" ]; then
    cp "$skill_src" "$HOME/.claude/skills/$name.md"
    echo "  ✓ skills/$name.md"
  else
    echo "  ✗ MISSING: $skill_src"
    MISSING_COUNT=$((MISSING_COUNT + 1))
  fi
}

sync_agent "01_orchestrator"    "orchestrator"
sync_agent "02_Obsidian_Builder" "obsidian-builder"
sync_agent "03_Art_Expert"      "art-expert"
sync_agent "04_Video_Director"  "video-director"
sync_agent "05_Content_Writer"  "content-writer"
sync_agent "06_Financial_Analyst" "financial-analyst"
sync_agent "07_Market_Researcher" "market-researcher"
sync_agent "08_Software_Engineer" "software-engineer"
sync_agent "09_Data_Engineer"   "data-engineer"
sync_agent "10_social_publisher" "social-publisher"
sync_agent "11_Report_Designer" "report-designer"

if [ "$MISSING_COUNT" -gt 0 ]; then
  echo "Sync FAILED: $MISSING_COUNT file(s) missing (source: $AGENTS_DIR)."
  exit 1
fi
echo "Sync complete."
