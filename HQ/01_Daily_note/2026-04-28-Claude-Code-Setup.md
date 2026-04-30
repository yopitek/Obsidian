# Work Log: Claude Code & GX10 Local LLM Integration (2026-04-28)

## 📝 Executive Summary
Successfully configured Claude Code CLI on Mac Mini to connect directly to the Qwen3.5-35B model hosted on the GX10 server via Tailscale, bypassing all Anthropic OAuth prompts and resolving authentication conflicts.

---

## 🏗 Current Software Structure
The architecture was simplified by removing the LiteLLM proxy to reduce latency and improve stability.

**Claude Code CLI** (Mac Mini) → (Tailscale Network) → **llama-server** (GX10 Port 8081) → **Qwen3.5-35B-A3B**

---

## 🛠 Configuration Details

### 1. Backend (GX10)
- **Engine**: `llama.cpp` (llama-server)
- **Port**: `8081`
- **Model**: `Qwen3.5-35B-A3B-UD-Q4_K_XL.gguf`
- **API Key**: `sk-ant-local-llama-key`
- **Context Window**: `163,840` (160K)
- **Alias**: `claude-3-5-sonnet-20241022` (for CLI compatibility)

### 2. Frontend (Mac Mini)
- **Claude CLI Version**: `2.1.120`
- **Primary Config (`~/.claude.json`)**: 
  - `hasCompletedOnboarding`: `true`
  - `primaryApiKey`: `sk-ant-local-llama-key`
  - `approved`: `["sk-ant-local-llama-key"]`
- **Settings (`~/.claude/settings.json`)**:
  - `ANTHROPIC_BASE_URL`: `http://100.73.84.27:8081`
  - `ANTHROPIC_MODEL`: `claude-3-5-sonnet-20241022`

---

## 🔍 Testing & Troubleshooting Process

### Phase 1: Conflict Resolution
- **Issue**: Detected "Auth conflict" error between `claude.ai` tokens and local API keys.
- **Action**: Surgically removed `oauthAccount` from `~/.claude.json` and cleared old session data in `~/.claude/sessions/`.
- **Discovery**: Found local overrides in `/Users/benny/Downloads/n8n_project/` (`.env` and `.claude/settings.local.json`) that were forcing wrong API keys.
- **Fix**: Renamed local `.env` keys and removed local project settings to allow global config to take over.

### Phase 2: Environment Locking
- **Issue**: Session variable `ANTHROPIC_API_KEY` was still holding an old sk-ant-api03 key.
- **Action**: Implemented a forced export in the launch command.
- **Command Used**: `export ANTHROPIC_API_KEY=sk-ant-local-llama-key && claude --bare`

### Phase 3: Final Verification
- **Test Command**: `claude -p "hi, are you connected to the local server?"`
- **Result**: Success. CLI connected to Tailscale IP `100.73.84.27:8081` without prompting for login.

---

## 🚀 Final Implementation
Added a permanent alias to `~/.zshrc` to automate the connection logic:
```bash
alias claude='export ANTHROPIC_API_KEY=sk-ant-local-llama-key && /opt/homebrew/bin/claude --bare'
```

## 📂 Files Modified
1. `~/.claude.json` (Auth bypass)
2. `~/.claude/settings.json` (Endpoint config)
3. `~/.zshrc` (Permanent alias)
4. `/Users/benny/Downloads/n8n_project/.env` (Cleanup)
5. `/Users/benny/Downloads/n8n_project/.claude/` (Removed local override)

---
**Status**: 🟢 Operational
**Operator**: Gemini CLI Agent
