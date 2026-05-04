#!/bin/bash
# home_download.sh - Pull latest from GitHub to Home
VAULT_PATH="/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ"

cd "$VAULT_PATH" || { echo "Error: Could not enter vault directory"; exit 1; }

if [ ! -d .git ]; then
    echo "Error: Git not initialized. Run home_upload.sh first."
    exit 1
fi

git pull origin main
