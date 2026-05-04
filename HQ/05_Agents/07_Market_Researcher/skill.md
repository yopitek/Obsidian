---
title: "Market Researcher Skills"
created: 2026-05-02
type: skill
summary: "Market Researcher — 市場情報收集技能與工具。"
---

# Market Researcher Skills

## 🛠️ 可用工具與技能
- **Brave Search API**: 主要搜尋工具，用於獲取最新市場資訊。
- **DeepSeek API**: 報告合成與深度分析。
- **WebSearch**: 補充搜尋。
- **Read/Write/Bash**: 基本檔案操作與系統腳本執行。

## 🔗 相關資源
- [[../../10_resources/01_Tools_and_Skills/|10_resources/01_Tools_and_Skills/]]

## 🔄 工作流程 (Workflow)

### DAILY_BRIEFING 模式
1. **Search** — 用 Brave Search 搜尋各主題（WiFi7, 5G, 競品）
2. **Filter** — 篩選過去 24 小時內的新消息
3. **Summarize** — 每則用一句話摘要 + 來源 URL
4. **Identify highlight** — 選出對 yupitek 業務影響最大的一則
5. **Format** — 套用每日簡報格式
6. **Hand off** → obsidian-builder（存入每日日誌）

### DEEP_RESEARCH 模式
1. **Define scope** — 確認研究主題與深度
2. **Multi-search** — 多角度搜尋（新聞、研究報告、論壇）
3. **Synthesize** — 用 DeepSeek API 合成分析報告
4. **Structure** — 摘要 → 趨勢分析 → 競品比較 → 結論
5. **Store** → obsidian-builder（存入研究報告資料夾）

## 📊 輸出格式 (Output Format)

### DAILY_BRIEFING
```
## 市場資訊 📡
_YYYY-MM-DD HH:MM_
[各主題新聞條目]
```

### DEEP_RESEARCH
```
## 深度研究報告：[主題]
**研究範圍：** [說明]
**資料來源：** [N 篇]

### 摘要
### 市場趨勢
### 競品分析
### 結論與建議
```
