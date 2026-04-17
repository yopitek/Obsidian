# Agent Routing Rules

> Orchestrator 接收任務後，依以下規則分派給對應 agent。

---

## 任務分派流程

```
新任務
  ↓
1. Orchestrator 分析任務類型與目標
  ↓
2. 拆分成子任務（subtasks）
  ↓
3. 每個子任務對照下方職責表選出對應 agent
  ↓
4. 獨立任務並行派遣，相依任務串行執行
  ↓
5. 收集輸出 → obsidian-builder 存入 vault
```

---

## Agent 職責對照表

| # | Agent | subagent_type | 負責任務類型 | 關鍵詞 |
|---|-------|--------------|------------|--------|
| 01 | Orchestrator | orchestrator | 任務接收、拆分、協調、裁決 | 計畫、分派、協調、流程、規劃 |
| 02 | Obsidian Builder | obsidian-builder | 日誌、筆記、知識庫更新、vault 管理 | 日記、筆記、彙總、Obsidian、存入、記錄 |
| 03 | Art Expert | art-expert | IG/FB 圖片、行銷視覺、電商 banner | 圖片、海報、小紅書、Instagram、視覺、設計 |
| 04 | Video Director | video-director | 影片腳本、分鏡、B-roll、短影音 | 影片、腳本、分鏡、YouTube、Shorts、Reels |
| 05 | Content Writer | content-writer | 部落格、文案、商品描述、SEO | 文章、行銷、商品、SEO、文案、小紅書文字 |
| 06 | Financial Analyst | financial-analyst | 股市追蹤、財務分析、市場訊號 | 股票、投資、財務、ETF、市場走勢、採購 |
| 07 | Market Researcher | market-researcher | WiFi7/5G 市場研究、競品分析 | 新聞、趨勢、WiFi 7、5G、競品、市場 |
| 08 | Software Engineer | software-engineer | 程式開發、API 整合、MCP、CI/CD | 程式、API、資料庫、bug、架構、MCP |
| 09 | Data Engineer | data-engineer | 資料管線、格式轉換、RAG、向量 DB | PDF、Excel、資料清洗、向量、RAG、轉換 |
| 10 | Social Publisher | social-publisher | 跨平台內容發布、排程、自動上傳 | 發布、上傳、小紅書、Instagram、Facebook、YouTube、蝦皮、排程 |
| 11 | Report Designer | report-designer | PPT 簡報、資訊圖表、客戶提案文件 | 簡報、PPT、圖表、infographic、提案、投影片、週報設計 |

---

## 並行執行規則

```
可並行（獨立任務）：
  - art-expert + content-writer（電商上架）
  - market-researcher + financial-analyst（每日早報）
  - 03 + 04 + 05（行銷活動全套）
  - report-designer + social-publisher（報告生成後立即發布）
  - art-expert + report-designer（視覺圖表整合）

必須串行（有相依）：
  - market-researcher → financial-analyst（市場資料 → 財務評估）
  - 任何 agent → obsidian-builder（產出 → 存入 vault）
  - data-engineer → obsidian-builder（清洗完成 → 存入）
```

---

## 優先級規則

```
High:   立即執行（使用者明確指定或緊急）
Medium: 排隊執行（常規任務）
Low:    批次處理或閒置時執行（每日/每週自動任務）
```

---

## Fallback 規則

```
沒有匹配 skill → 使用 agent 預設 LLM 能力
不確定分派對象 → orchestrator 判斷
多個 agent 都適合 → orchestrator 裁決，選最專精者
```
