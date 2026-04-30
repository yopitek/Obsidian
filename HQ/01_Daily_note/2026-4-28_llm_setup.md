# GX10 Claude Code & Local LLM 完整設定指南 (2026-04-28 最終版)

本指南匯總了 GX10 伺服器上 Qwen3.5-35B 模型與 Claude Code CLI 的直接連線設定、分散式架構及「繞過登入提示」的詳細檢查表。

---

## 🟢 1. 系統架構 (System Architecture)

目前的架構已簡化為**直接連線**，大幅降低延遲並提升穩定性（已移除 LiteLLM 代理層）。

**Claude Code CLI** → (Anthropic API) → **GX10 llama-server (Port 8081)** → **Qwen3.5-35B**

### 網路與端點資訊
| 項目 | 內容 |
|------|------|
| GX10 Tailscale IP | `100.73.84.27` |
| API Base URL | `http://100.73.84.27:8081` (本機使用 `http://127.0.0.1:8081`) |
| API Key | `sk-ant-local-llama-key` (必須符合 `sk-ant-` 格式) |
| Model Alias | `claude-3-5-sonnet-20241022` |
| Context 限制 | **163,840 (160K)** |

---

## 🛠 2. 伺服器端設定 (GX10 Setup)

### 2.1 啟動指令 (`~/run-llama-server.sh`)
確保使用以下參數啟動，以支援大 Context 與 Claude Code 格式：
```bash
nohup ./build/bin/llama-server \
    -m ~/models/Qwen3.5-35B-A3B/Qwen3.5-35B-A3B-UD-Q4_K_XL.gguf \
    -c 163840 \
    --port 8081 \
    --host 0.0.0.0 \
    --api-key "sk-ant-local-llama-key" \
    -ngl 127 \
    --reasoning off \
    --alias claude-3-5-sonnet-20241022 \
    > /tmp/llama-server.log 2>&1 &
```

---

## 💻 3. 用戶端「繞過登入」詳細檢查表 (Client Login Bypass Checklist)

如果你的 Mac Mini 依然提示要輸入 API Key 或選擇登入方式，請**務必**檢查以下兩個檔案是否正確配置：

### ✅ Check 1: 建立或覆寫 `~/.claude.json`
這個檔案負責「欺騙」CLI 讓它以為你已經通過 OAuth 認證。

```bash
cat > ~/.claude.json << 'EOF'
{
  "hasCompletedOnboarding": true,
  "primaryApiKey": "sk-ant-local-llama-key",
  "customApiKeyResponses": {
    "approved": ["sk-ant-local-llama-key"]
  }
}
EOF
```
*   **重點**：`primaryApiKey` 與 `approved` 列表必須包含與 GX10 相同的金鑰。

### ✅ Check 2: 建立或覆寫 `~/.claude/settings.json`
這個檔案負責告訴 CLI 去哪裡連線。

```bash
mkdir -p ~/.claude
cat > ~/.claude/settings.json << 'EOF'
{
  "env": {
    "ANTHROPIC_BASE_URL": "http://100.73.84.27:8081",
    "ANTHROPIC_API_KEY": "sk-ant-local-llama-key",
    "ANTHROPIC_MODEL": "claude-3-5-sonnet-20241022",
    "CLAUDE_CODE_ATTRIBUTION_HEADER": "0"
  }
}
EOF
```
*   **重點**：`ANTHROPIC_BASE_URL` **不可以**包含 `/v1`。

### ✅ Check 3: 啟動方式
啟動時使用 `--bare` 參數可以跳過許多不必要的初始化檢查：
```bash
claude --bare
```

### ✅ Check 4: 清除舊工作階段 (如果依然失敗)
如果之前有失敗的登入紀錄，請清除快取後重試：
```bash
rm -rf ~/.claude/sessions/*
```

---

## 🔍 4. 測試與診斷 (Testing & Debug)

### 4.1 直接連線測試 (在 Mac Mini 上執行)
使用 `curl` 驗證 Mac Mini 是否能穿透 Tailscale 連線到 GX10：
```bash
curl -X POST http://100.73.84.27:8081/v1/messages \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk-ant-local-llama-key" \
  -d '{
    "model": "claude-3-5-sonnet-20241022",
    "messages": [{"role": "user", "content": "hi"}],
    "max_tokens": 10
  }'
```

---

## 🌐 5. Tailscale 網路共享 (Network Sharing)

若要讓外部使用者（如 `ytalai@gmail.com`）存取 GX10 伺服器，請按照以下步驟操作：

### 5.1 節點共享 (Node Sharing - 推薦)
此方法僅分享 GX10 這台機器，不會開放整個網路：
1.  登入 [Tailscale 管理控制台](https://login.tailscale.com/admin/machines)。
2.  在機器清單中找到 **GX10**。
3.  點擊右側的 **"..." (More)** 選單，選擇 **Share...**。
4.  輸入 `ytalai@gmail.com` 並產生邀請連結。
5.  將連結發送給對方，對方接受後即可看到 GX10 (IP `100.73.84.27`)。

### 5.2 邀請加入 Tailnet (User Invitation)
將其加入為你的網路成員：
1.  前往 [Users 頁籤](https://login.tailscale.com/admin/users)。
2.  點擊 **Invite Users** 並輸入 `ytalai@gmail.com`。
3.  加入後，該使用者即可在自己的 Tailscale 中看到 GX10。

---

## 💡 6. 關鍵發現 (Key Discovery)

1.  **API Key 格式**：Claude Code 內部會驗證金鑰是否為 Anthropic 格式（`sk-ant-...`），非此格式會觸發登入提示。
2.  **登入繞過邏輯**：CLI 會優先讀取 `~/.claude.json` 中的 `primaryApiKey`，如果存在且在 `approved` 名單中，就會跳過 OAuth。
3.  **分散式裝置 (Mac Mini)**：請確保 Mac Mini 的 Tailscale 已連線到 GX10 所在的網路。

---
*文件編撰：Gemini CLI Agent*
*最後更新：2026-04-28*