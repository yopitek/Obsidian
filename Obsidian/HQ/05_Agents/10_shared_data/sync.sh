#!/bin/bash
# sync.sh — copies Obsidian agent/skill files to Claude Code
# Run from anywhere: bash ~/Downloads/n8n_project/obsidian/Obsidian/HQ/04_Work/05_Agents/10_shared_data/sync.sh
# Compatible with macOS bash 3.2+

set -e

AGENTS_DIR="$HOME/Downloads/n8n_project/obsidian/Obsidian/HQ/04_Work/05_Agents"

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
  fi

  if [ -f "$skill_src" ]; then
    cp "$skill_src" "$HOME/.claude/skills/$name.md"
    echo "  ✓ skills/$name.md"
  else
    echo "  ✗ MISSING: $skill_src"
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

echo "Sync complete."
