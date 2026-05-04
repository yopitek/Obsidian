# GX10 Qwen3.5-35B 分散式設定教學

本文說明如何從 MacBook Air 和 Windows PC 連線到 GX10 伺服器的 Qwen LLM。

---

## 網路資訊

| 項目 | 內容 |
|------|------|
| GX10 IP（Tailscale） | 100.73.84.27 |
| API 端點 | http://100.73.84.27:8081/v1 |
| API Key | local-llama-key |
| 模型名稱 | Qwen3.5-35B-A3B-UD-Q4_K_XL.gguf |

---

## 第一部分：MacBook Air 設定（macOS）

### 1.1 確認 Tailscale

確認 Tailscale 已在 macOS 上執行：
```bash
# 檢查狀態
tailscale status

# 確認有 100.73.84.27 IP
tailscale ip -4
```

### 1.2 安裝 Claude Code CLI（macOS）

#### 方法 A：手動安裝
```bash
# 建立應用程式目錄
sudo mkdir -p /Applications
cd /tmp

# 下載 Claude Code CLI（請替換為正確的下載 URL）
curl -L -o claude-code.zip "https://CLAUDE_DOWNLOAD_URL"
unzip claude-code.zip
sudo mv claude-code /Applications/

# 設定路徑
echo 'export PATH="/Applications/claude-code/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

#### 方法 B：使用 Homebrew
```bash
brew install claude-code
```

### 1.3 設定 Claude Code CLI 連線到遠端 API

#### 方法：建立設定檔（推薦）
```bash
mkdir -p ~/.claude

cat > ~/.claude/settings.json << 'EOF'
{
  "apiUrl": "http://100.73.84.27:8081/v1",
  "apiKey": "local-llama-key",
  "model": "Qwen3.5-35B-A3B-UD-Q4_K_XL.gguf"
}
EOF
```

#### 驗證
```bash
claude --version
```

### 1.4 設定 Telegram Bot（macOS）

#### 步驟 1：安裝 Python 依賴
```bash
# 確認 Python
python3 --version

# 建立專案目錄
mkdir -p ~/telegram-bot
cd ~/telegram-bot

# 建立虛擬環境
python3 -m venv venv
source venv/bin/activate

# 安裝套件
pip install python-telegram-bot openai requests
```

#### 步驟 2：建立 Bot 腳本
```bash
cd ~/telegram-bot

cat > bot.py << 'EOF'
import os
import logging
from telegram import Update
from telegram.ext import ApplicationBuilder, ContextTypes, MessageHandler, filters
from openai import OpenAI

TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")
OPENAI_API_URL = "http://100.73.84.27:8081/v1"
OPENAI_API_KEY = "local-llama-key"
MODEL_NAME = "Qwen3.5-35B-A3B-UD-Q4_K_XL.gguf"

client = OpenAI(
    base_url=OPENAI_API_URL,
    api_key=OPENAI_API_KEY
)

logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO)

logger = logging.getLogger(__name__)

async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user_message = update.message.text
    
    try:
        response = client.chat.completions.create(
            model=MODEL_NAME,
            messages=[
                {"role": "system", "content": "You are a helpful AI assistant."},
                {"role": "user", "content": user_message}
            ],
            max_tokens=1024
        )
        
        reply = response.choices[0].message.content
        await update.message.reply_text(reply)
        
    except Exception as e:
        logger.error(f"Error: {e}")
        await update.message.reply_text(f"Error: {str(e)}")

def main():
    application = ApplicationBuilder().token(TELEGRAM_BOT_TOKEN).build()
    
    handler = MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message)
    application.add_handler(handler)
    
    application.run_polling()

if __name__ == "__main__":
    main()
EOF
```

#### 步驟 3：設定 Bot Token
```bash
# 請將 YOUR_BOT_TOKEN 替換為你的實際 Token
export TELEGRAM_BOT_TOKEN="YOUR_BOT_TOKEN"
```

#### 步驟 4：啟動 Bot
```bash
cd ~/telegram-bot
source venv/bin/activate
python bot.py
```

#### 步驟 5：測試
向你的 Bot 發送訊息，應該會收到 Qwen 的回覆。

---

## 第二部分：Windows PC 設定（Windows 11）

### 2.1 確認 Tailscale

在 PowerShell 中：
```powershell
# 檢查狀態
tailscale status
```

### 2.2 安裝 Claude Code CLI（Windows）

#### 方法 A：直接下載
1. 下載 Windows 版本的 Claude Code CLI
2. 解壓縮到 `C:\Program Files\ClaudeCode`
3. 將路徑加入系統環境變數

#### 方法 B：使用 winget
```powershell
winget install ClaudeCode.CLI
```

#### 方法 C：使用 Chocolatey
```powershell
choco install claude-code -y
```

### 2.3 設定 Claude Code CLI 連線到遠端 API

打開 PowerShell：
```powershell
# 建立設定目錄
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude"

# 建立設定檔
@{
  "apiUrl" = "http://100.73.84.27:8081/v1"
  "apiKey" = "local-llama-key"
  "model" = "Qwen3.5-35B-A3B-UD-Q4_K_XL.gguf"
} | ConvertTo-Json | Out-File -FilePath "$env:USERPROFILE\.claude\settings.json" -Encoding utf8
```

#### 驗證
```powershell
claude --version
```

### 2.4 設定 Telegram Bot（Windows）

#### 步驟 1：安裝 Python
```powershell
# 使用 winget
winget install Python.Python.3.11

# 或者從 https://www.python.org/downloads/ 下載
```

#### 步驟 2：建立 Bot 環境
```powershell
# 建立目錄
mkdir telegram-bot
cd telegram-bot

# 建立虛擬環境
python -m venv venv
.\venv\Scripts\Activate.ps1

# 安裝依賴
pip install python-telegram-bot openai requests
```

#### 步驟 3：建立 Bot 腳本
在 `telegram-bot` 目錄建立 `bot.py`，內容與 macOS 版本相同：

```powershell
# 创建 bot.py（可复制 macOS 的内容）
```

#### 步驟 4：設定 Bot Token
```powershell
$env:TELEGRAM_BOT_TOKEN = "YOUR_BOT_TOKEN"
```

#### 步驟 5：啟動 Bot
```powershell
.\venv\Scripts\Activate.ps1
python bot.py
```

#### 步驟 6：測試
向你的 Bot 發送訊息，應該會收到 Qwen 的回覆。

---

## 第三部分：測試與排查

### 測試 API 連線

```bash
# 在 Mac/Linux
curl -X POST http://100.73.84.27:8081/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer local-llama-key" \
  -d '{
    "model": "Qwen3.5-35B-A3B-UD-Q4_K_XL.gguf",
    "messages": [{"role": "user", "content": "Hello"}],
    "max_tokens": 50
  }'
```

```powershell
# 在 Windows PowerShell
Invoke-RestMethod -Uri "http://100.73.84.27:8081/v1/chat/completions" `
  -Method Post `
  -Headers @{Authorization="Bearer local-llama-key"} `
  -ContentType "application/json" `
  -Body '{"model":"Qwen3.5-35B-A3B-UD-Q4_K_XL.gguf","messages":[{"role":"user","content":"Hello"}],"max_tokens":50}'
```

### 常見問題

| 問題 | 解決方式 |
|------|----------|
| 連線被拒 | 確認 Tailscale 都在執行 |
| API 認證失敗 | 檢查 API Key 是否正確（`local-llama-key`） |
| 連線逾時 | 檢查網路，確認 100.73.84.27 可達 |
| Bot 沒有回應 | 確認 Token 正確，檢查 Python 錯誤輸出 |

---

## 第四部分：安全性建議

1. **不要公開 API Key** - 不要將 `local-llama-key` 提交到公開仓库
2. **使用 Tailscale VPN** - 確保只有 Tailscale 網路內的裝置可以連線
3. **監控使用量** - 定期檢查 API 使用紀錄
4. **更換 API Key** - 定期更換 API Key（可使用 `--api-key` 參數設定）