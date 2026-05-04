#!/bin/bash
# home_upload.sh - Sync Home to GitHub
VAULT_PATH="/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ"
REPO_URL="https://github.com/yopitek/Obsidian.git"

cd "$VAULT_PATH" || { echo "Error: Could not enter vault directory"; exit 1; }

# Init git if needed
if [ ! -d .git ]; then
    git init
    git remote add origin "$REPO_URL"
fi

# Security: Ensure .gitignore exists and blocks credentials
if ! grep -q "env/" .gitignore 2>/dev/null; then
    echo "env/" >> .gitignore
    echo ".env" >> .gitignore
    echo "*.env" >> .gitignore
    echo "HQ/04_Work/env/" >> .gitignore
fi

git add .gitignore
git commit -m "Update .gitignore for credential protection" 2>/dev/null

# Sync
git add .
git commit -m "Sync Home Obsidian - $(date '+%Y-%m-%d %H:%M')"
git push origin main
