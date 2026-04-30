# Agent 系統架構總覽

> 完整的多 Agent 協作系統，專為 WiFi/網通產品行銷與自動化設計。
> 最後更新：2026-04-28

---

## 🎯 系統架構圖

```
┌─────────────────────────────────────────────────────────────────┐
│                        使用者輸入                                 │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                     01. Orchestrator                              │
│                  (任務接收、拆解、分派)                            │
└─────────────────────────────────────────────────────────────────┘
                              ↓
        ┌─────────────────┬─────────────────┬─────────────────┐
        ↓                 ↓                 ↓                 ↓
┌───────────────┐  ┌───────────────┐  ┌───────────────┐  ┌───────────────┐
│ 07. Market    │  │ 06. Financial │  │ 05. Content   │  │ 03. Art       │
│ Researcher    │  │ Analyst       │  │ Writer        │  │ Expert        │
│ 市場情報      │  │ 財務分析      │  │ 文案寫作      │  │ 視覺設計      │
└───────────────┘  └───────────────┘  └───────────────┘  └───────────────┘
        ↓                 ↓                 ↓                 ↓
        └─────────────────┴────────┬──────┴─────────────────┘
                                    ↓
                        ┌─────────────────────┐
                        │  12. Quality        │
                        │  Assurance          │
                        │  品質檢驗           │
                        └─────────────────────┘
                                    ↓
                    ┌───────────────┴───────────────┐
                    ↓                                 ↓
        ┌─────────────────────┐          ┌─────────────────────┐
        │  11. Report         │          │  10. Social         │
        │  Designer           │          │  Publisher          │
        │  報告設計           │          │  社群發布           │
        └─────────────────────┘          └─────────────────────┘
                    ↓                                 ↓
        ┌─────────────────────────────────────────────────────┐
        │              02. Obsidian Builder                    │
        │              (所有輸出統一存入 vault)                 │
        └─────────────────────────────────────────────────────┘
        
        ┌─────────────────────────────────────────────────────┐
        │  支援 Agent (按需派遣)                                │
        │  04. Video Director (影片腳本)                       │
        │  08. Software Engineer (技術開發)                    │
        │  09. Data Engineer (資料工程)                        │
        └─────────────────────────────────────────────────────┘
```

---

## 📋 Agent 完整列表（已重新編號）

| # | Agent | 職責 | subagent_type | 優先級 |
|---|------|------|--------------|--------|
| 01 | Orchestrator | 任務協調、分派、彙整 | orchestrator | 🔴 核心 |
| 02 | Obsidian Builder | 知識管理、筆記儲存 | obsidian-builder | 🔴 核心 |
| 03 | Art Expert | 視覺設計、圖片生成 | art-expert | 🟡 重要 |
| 04 | Video Director | 影片腳本、分鏡規劃 | video-director | 🟡 重要 |
| 05 | Content Writer | 文案寫作、SEO 優化 | content-writer | 🟡 重要 |
| 06 | Financial Analyst | 股市追蹤、財務分析 | financial-analyst | 🟡 重要 |
| 07 | Market Researcher | 市場研究、競品分析 | market-researcher | 🟡 重要 |
| 08 | Software Engineer | API 整合、技術開發 | software-engineer | 🟢 支援 |
| 09 | Data Engineer | 資料管線、格式轉換 | data-engineer | 🟢 支援 |
| 10 | Social Publisher | 跨平台發布、排程 | social-publisher | 🟡 重要 |
| 11 | Report Designer | 簡報設計、圖表製作 | report-designer | 🟡 重要 |
| 12 | Quality Assurance | 品質檢驗、合規檢查 | quality-assurance | 🔴 核心 |

---

## 🔗 Agent 協作流程

### 典型任務流程

#### 案例：新品上市行銷

```
1. Orchestrator 接收任務
   ↓
2. 拆解為子任務：
   - 市場研究 → Market Researcher
   - 財務評估 → Financial Analyst
   - 撰寫文案 → Content Writer
   - 設計視覺 → Art Expert
   - 影片腳本 → Video Director
   ↓
3. 並行執行（無相依任務）
   ↓
4. 彙整結果 → Orchestrator
   ↓
5. 品質檢驗 → Quality Assurance
   ↓
6. 發布安排 → Social Publisher
   ↓
7. 簡報製作 → Report Designer
   ↓
8. 全部存入 Obsidian → Obsidian Builder
```

### 並行執行矩陣

| 可並行組合 | 相依關係 | 說明 |
|-----------|---------|------|
| Market Researcher + Financial Analyst | 無 | 獨立分析 |
| Content Writer + Art Expert | 無 | 文案與視覺獨立 |
| Art Expert + Video Director | 無 | 視覺與腳本可並行 |
| Report Designer + Social Publisher | 無 | 簡報與發布可並行 |
| Market Researcher → Financial Analyst | 有 | 市場資料 → 財務評估 |
| 任何 Agent → Obsidian Builder | 有 | 產出 → 儲存 |
| 任何 Agent → Quality Assurance | 有 | 內容 → 檢驗 |

---

## 🏗️ 系統基礎設施

### Shared Data 結構

```
13_shared_data/
├── routing.md              # 任務分派規則
├── skill-index.md          # 全技能索引
├── high_priority_skills.md # 優先安裝技能
├── error-handling-template.md # 錯誤處理規範
├── performance-tracking.md # 效能追蹤框架
├── task-template.md        # 任務模板
└── qa_log/                 # QA 檢查日誌
    └── YYYY-MM-DD.md

performance_logs/           # 效能日誌
└── YYYY-MM-DD.md

performance_summary/
├── daily/                  # 每日摘要
└── weekly/                 # 每週彙總
```

### 執行日誌

```
05_Agents/
├── 14_Daily_work_log/      # 每日工作記錄
│   └── YYYY-MM-DD.md
├── 15_Weekly_work_log/     # 每週工作記錄
│   └── YYYY-WXX.md
└── 12_Quality_Assurance/   # QA Agent
    ├── agent.md
    ├── skill.md
    └── qa_log/
```

---

## 🛠️ 工具與技能

### 核心技能（必須安裝）

| 技能 | 用途 | 安裝方式 |
|------|------|---------|
| Superpowers | 開發工作流、TDD、subagent | `/plugin install superpowers` |
| n8n Skills | 自動化工作流、API 串接 | 參考 GitHub |
| Obsidian Skills | 知識管理、筆記建立 | 參考 GitHub |

### 專項技能

| Agent | 專項技能 | 用途 |
|------|---------|------|
| Art Expert | XiaohongshuSkills | 小紅書內容生成 |
| Art Expert | UI/UX Pro Max | 專業設計 |
| Content Writer | X Article Publisher | X 推文發布 |
| Market Researcher | Claude Scientific Skills | 科學研究分析 |
| Video Director | Video Prompting | 影片提示詞 |
| Social Publisher | social-auto-upload | 多平台發布 |
| Report Designer | PPTAgent | PPT 自動生成 |
| Report Designer | AntV Infographic | 資訊圖表 |

---

## 🔐 安全與規範

### API 管理

- 所有 API Key 存放於 `env/.env`
- 永不硬編碼 API Key
- 定期更換敏感憑證

### 錯誤處理

- 統一的錯誤等級（E1-E4）
- 標準化的重試機制（指數退避）
- Telegram 通知規範

### 品質保證

- QA Agent 作為發布前最後檢查
- 品牌一致性檢查
- 敏感詞合規審查
- 格式規範驗證

---

## 📊 監控與優化

### 每日監控

- 效能日誌自動記錄
- 錯誤統計彙總
- Telegram 每日摘要

### 每週優化

- 效能儀表板分析
- 瓶頸識別與改善
- 成本分析與優化

### 持續改進

- 基於數據的優化建議
- A/B Testing 框架
- 用戶反饋迴圈
