# ✅ 已安裝的 Claude Code Agents

> 最後檢查：2026-04-28

---

## 📋 安裝狀態

### ✅ 已配置 (11 個)

這些 agents 已經配置在 `.claude/subagents.json` 中，可以立即使用：

| # | Agent | 狀態 | 配置文件 |
|---|------|------|---------|
| 02 | obsidian-builder | ✅ 已配置 | `02_Obsidian_Builder/agent.md` |
| 03 | art-expert | ✅ 已配置 | `03_Art_Expert/agent.md` |
| 04 | video-director | ✅ 已配置 | `04_Video_Director/agent.md` |
| 05 | content-writer | ✅ 已配置 | `05_Content_Writer/agent.md` |
| 06 | financial-analyst | ✅ 已配置 | `06_Financial_Analyst/agent.md` |
| 07 | market-researcher | ✅ 已配置 | `07_Market_Researcher/agent.md` |
| 08 | software-engineer | ✅ 已配置 | `08_Software_Engineer/agent.md` |
| 09 | data-engineer | ✅ 已配置 | `09_Data_Engineer/agent.md` |
| 10 | social-publisher | ✅ 已配置 | `10_social_publisher/agent.md` |
| 11 | report-designer | ✅ 已配置 | `11_Report_Designer/agent.md` |
| 12 | quality-assurance | ✅ 已配置 | `12_Quality_Assurance/agent.md` |

### 📝 未安裝 (1 個)

| # | Agent | 狀態 | 說明 |
|---|------|------|------|
| 01 | orchestrator | ⚠️ 作為主 agent | Orchestrator 是系統的核心協調者，不需要作為 subagent 安裝 |

---

## 🔧 如何安裝/驗證 Agents

### 方法 1：使用 --agents 參數（推薦）

```bash
# 在項目目錄中運行 Claude Code，自動加載 subagents
claude --agents .claude/subagents.json "你的任務"
```

### 方法 2：在對話中調用

```bash
# 啟動 Claude Code
claude

# 然後使用 subagent 工具
/agent art-expert "幫我設計一個 Instagram 貼文"
```

### 方法 3：手動添加

```bash
# 使用 --agents 參數動態添加
claude --agents '{"my-agent": {"description": "My agent", "prompt": "You are my custom agent"}}' "任務"
```

---

## 📁 配置文件位置

```
/Users/benny/Downloads/n8n_project/
└── .claude/
    └── subagents.json  ← Agent 配置
```

---

## ✅ 驗證腳本

運行以下命令驗證所有 agents 是否正確配置：

```bash
# 檢查 subagents.json 存在
ls -la .claude/subagents.json

# 驗證 JSON 格式
cat .claude/subagents.json | python3 -m json.tool

# 檢查所有 agent.md 文件存在
for agent in obsidian-builder art-expert video-director content-writer financial-analyst market-researcher software-engineer data-engineer social-publisher report-designer quality-assurance; do
  if [ -f "obsidian/Obsidian/HQ/05_Agents/*_${agent^}/agent.md" ] || [ -f "obsidian/Obsidian/HQ/05_Agents/*_${agent^}*/agent.md" ]; then
    echo "✅ $agent - 文件存在"
  else
    echo "❌ $agent - 文件缺失"
  fi
done
```

---

## 🚀 使用範例

### 使用 Art Expert 設計圖片

```bash
claude --agents .claude/subagents.json "請使用 art-expert 幫我設計一個 ALFA 產品的 Instagram 貼文"
```

### 使用 Market Researcher 研究市場

```bash
claude --agents .claude/subagents.json "請使用 market-researcher 收集 WiFi 7 最新市場資訊"
```

### 使用 Content Writer 撰寫文案

```bash
claude --agents .claude/subagents.json "請使用 content-writer 撰寫一篇小紅書種草文"
```

### 使用 QA Agent 檢查內容

```bash
claude --agents .claude/subagents.json "請使用 quality-assurance 檢查這篇貼文的品質"
```

---

## 📊 系統完整性檢查

| 檢查項目 | 狀態 | 詳細 |
|---------|------|------|
| subagents.json | ✅ 存在 | 11 個 agent 已配置 |
| agent.md 文件 | ✅ 全部存在 | 所有 agent 定義完整 |
| .env API 設定 | ✅ 存在 | API key 已設定 |
| 日誌目錄 | ✅ 存在 | health_logs, qa_log 等 |
| Shared Data | ✅ 完整 | routing.md 等全部存在 |

**總體狀態：✅ 所有 Agents 已安裝並配置完成**

---

## 🎯 下一步

1. **驗證安裝** - 運行上面的驗證腳本
2. **開始使用** - 在 Claude Code 中調用 subagent
3. **測試流程** - 執行一個完整的跨 agent 任務

---

*最後更新：2026-04-28*
