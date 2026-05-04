#!/bin/bash
# office_download.sh - Pull latest from GitHub to Office
VAULT_PATH="/Users/benny/Downloads/n8n_project/obsidian/Obsidian/"

cd "$VAULT_PATH" || { echo "Error: Could not enter vault directory"; exit 1; }

if [ ! -d .git ]; then
    echo "Error: Git not initialized. Run office_upload.sh first."
    exit 1
fi

git pull origin main
