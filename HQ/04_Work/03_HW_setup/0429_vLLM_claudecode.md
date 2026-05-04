# Claude Code 辦公室協作與 vLLM 效能報告 (2026-04-29)

這份文件旨在指導辦公室其他設備透過 **Tailscale** 虛擬內網連線至 ASUS GX10 上的本地 vLLM 引擎，實現團隊協作。

---

## 🚀 第一部分：效能對比 (Performance Review)

目前的 **Qwen3.6-35B-A3B-FP8 + vLLM** 配置相較於舊版有顯著提升：

| 指標 | 舊版 (Qwen3.5 + LiteLLM) | 新版 (Qwen3.6 + vLLM) | 提升幅度 |
| :--- | :--- | :--- | :--- |
| **推理引擎** | llama.cpp + LiteLLM Proxy | **原生 vLLM (v0.20.0)** | 減少轉換層延遲 |
| **Context 長度** | 8k ~ 16k | **40k (40960)** | **+150%**，支援超長專案分析 |
| **推理速度** | ~25-30 tok/s | **~50-55 tok/s** | **+70~80%** (歸功於 MTP 推測解碼) |
| **Tool Call 穩定性** | 透過 OpenAI 格式轉換 | **原生 Anthropic Messages 格式** | 顯著提升，不再出現解析錯誤 |

---

## 🌐 第二部分：Tailscale 網路設備清單

目前辦公室設備已透過 Tailscale 互聯，請使用以下 IP 進行連線：

1.  **GX10 (AI Server)**: `100.73.84.27`
2.  **iPhone 15 Pro**: `100.77.230.20`
3.  **Mac Mini**: `100.114.234.26`
4.  **MacBook Air**: `100.103.132.110`
5.  **Android Tablet (S9)**: `100.115.242.28` (Eason Lai)

---

## 📱 第三部分：辦公室設備連線教學 (Step-by-Step)

### 0. 事前準備 (Server 端)
在 **GX10** 上啟動 vLLM：
```bash
~/start-stack-v2.sh
```
*(確保服務正在運行並監聽 Port 8000)*

### 🍎 方案 A：MacBook Air / Mac Mini / iPhone (透過指令或設定)
1. **安裝 Claude Code**:
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```
2. **設定連線變數** (請根據 GX10 的 Tailscale IP 設定)：
   ```bash
   export ANTHROPIC_BASE_URL="http://100.73.84.27:8000"
   export ANTHROPIC_API_KEY="sk-dummy-local-key"
   export ANTHROPIC_DEFAULT_OPUS_MODEL="claude-3-5-sonnet-20241022"
   export ANTHROPIC_DEFAULT_SONNET_MODEL="claude-3-5-sonnet-20241022"
   export ANTHROPIC_DEFAULT_HAIKU_MODEL="claude-3-5-sonnet-20241022"
   ```
3. **啟動**: 直接輸入 `claude` 即可。

### 🤖 方案 B：Android 平板 (Termux)
1. **設定環境**:
   在 Termux 中安裝 Node.js 後，執行與 Mac 相同的 `npm install` 與 `export` 指令。
2. **IP 連結**: 確保 ANTHROPIC_BASE_URL 指向 `http://100.73.84.27:8000`。

---

## 🤝 第四部分：團隊協作 (Cowork) 規範

1.  **資源分配**: 目前 GX10 設為 `--max-num-seqs 1` 以保證單人極致速度。若有多人並發需求，需在 `start-vllm.sh` 中將該值調升。
2.  **Auth 一致性**: 所有設備統一使用 `sk-dummy-local-key`，不需連網登入。
3.  **Tailscale 優勢**: 即使您帶著 MacBook 或平板離開辦公室，只要開啟 Tailscale，依然可以遠端連線回辦公室的 GX10 使用 AI。

---

## 🔧 第五部分：疑難排解

*   **無法連線**: 請確認連線設備的 Tailscale 已開啟，並能 `ping 100.73.84.27` 通。
*   **Context 錯誤**: 確保 GX10 上的 vLLM 維持在 40k 上限 (`--max-model-len 40960`)。
