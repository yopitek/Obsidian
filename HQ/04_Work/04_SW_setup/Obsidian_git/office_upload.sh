#!/bin/bash
# office_upload.sh - Sync Office to GitHub
VAULT_PATH="/Users/benny/Downloads/n8n_project/obsidian/Obsidian/"
REPO_URL="https://github.com/yopitek/Obsidian.git"

cd "$VAULT_PATH" || { echo "Error: Could not enter vault directory"; exit 1; }

# Init git if needed
if [ ! -d .git ]; then
    git init
    git remote add origin "$REPO_URL"
fi

# Security: Ensure .gitignore exists and blocks credentials
# (-qx: whole-line match, so the specific "HQ/04_Work/env/" entry can no
# longer satisfy the check and mask the missing generic "env/" rule)
if ! grep -qx "env/" .gitignore 2>/dev/null; then
    echo "env/" >> .gitignore
    echo ".env" >> .gitignore
    echo "*.env" >> .gitignore
    echo "HQ/04_Work/env/" >> .gitignore
fi

git add .gitignore
git commit -m "Update .gitignore for credential protection" 2>/dev/null

# Sync
git add .
if git diff --cached --quiet; then
    echo "No local changes to commit."
else
    git commit -m "Sync Office Obsidian - $(date '+%Y-%m-%d %H:%M')" || exit 1
fi

# Bring in the remote before pushing (both machines push the same main).
# On conflict: abort, restore the pre-sync state, and fail loudly - never
# leave a half-finished rebase and never lose local commits.
PRE_SYNC=$(git rev-parse HEAD)
git fetch origin main || { echo "Error: fetch from origin/main failed; nothing pushed."; exit 1; }
if ! git rebase origin/main; then
    git rebase --abort 2>/dev/null
    [ "$(git rev-parse HEAD)" != "$PRE_SYNC" ] && git reset --hard "$PRE_SYNC" >/dev/null
    echo "Error: conflict with origin/main - local state restored, nothing pushed. Resolve manually, then run again."
    exit 1
fi
git push origin main || { echo "Error: git push failed; local commits kept."; exit 1; }
