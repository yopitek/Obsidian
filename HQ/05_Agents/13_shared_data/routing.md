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
| 12 | Quality Assurance | quality-assurance | 品質檢驗、敏感詞審查、格式驗證 | QA、檢查、驗證、合規、品質、審查 |

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

### 優先級判斷規則

| 情境 | 優先級 | 說明 |
|------|--------|------|
| 使用者明確要求「立即/緊急」 | High | 優先處理 |
| 每日簡報（DAILY_BRIEFING） | High | 早上固定執行 |
| 內容發布（有排程時間） | High | 按時發布 |
| 常規查詢 | Medium | 正常排隊 |
| 市場研究（非緊急） | Medium | 可延後處理 |
| 每週彙總 | Low | 週末批次處理 |
| 資料處理/轉換 | Low | 閒置時執行 |

---

## 成本優化規則

### 便宜方案優先

1. **缓存資料** — 優先使用已有的市場數據（< 24 小時）
2. **本地處理** — 能本地執行的任務不使用 API
3. **批次處理** — 多個小任務合併處理
4. **並行執行** — 獨立任務同時派遣

### 成本監控

```
每日預算上限：$50
單次任務上限：$5

超出預算時：
1. 降低 API 使用頻率
2. 使用 cached data
3. 通知使用者
```

---

## 速度優化規則

### 快速回應模式（Fast Mode）

觸發條件：使用者要求「快速/簡短」

- Market Researcher：使用 cached data（< 24 小時）
- Content Writer：生成簡短版本（50% 字數）
- Art Expert：使用預設模板
- QA：簡化檢查項目

### 深度分析模式（Deep Mode）

觸發條件：使用者要求「詳細/完整」

- Market Researcher：完整網路搜尋
- Content Writer：完整 SEO 文章
- Art Expert：精細設計
- QA：完整檢查

---

## Fallback 規則

```
沒有匹配 skill → 使用 agent 預設 LLM 能力
不確定分派對象 → orchestrator 判斷
多個 agent 都適合 → orchestrator 裁決，選最專精者
```

### 失敗處理規則

| 情況 | 處理方式 |
|------|---------|
| API 暫時失敗 | 重試 3 次後使用 cached data |
| Agent 無法回應 | 重新派遣給備用 agent |
| 輸出品質不足 | 退回修正或重新派遣 |
| 所有嘗試失敗 | 通知使用者並提供替代方案 |

---

## 智慧分派增強規則

### 基於任務複雜度

| 複雜度 | 分派策略 |
|--------|---------|
| 單一任務 | 直接分派給最專精 agent |
| 複合任務 | Orchestrator 拆解並行/串行 |
| 模糊任務 | Orchestrator 詢問澄清問題 |

### 基於歷史表現

- 某 agent 近期失敗率高 → 減少分派或增加 QA 檢查
- 某 agent 執行時間長 → 考慮替換或優化
- 某 agent 品質分數高 → 優先分派

### 基於資源狀態

- 某 agent API 限流中 → 等待或切換備用方案
- 系統負載高 → 延長等待時間或分批處理
