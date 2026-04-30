# 🤖 AI Agents 系統索引

> 所有 AI Agent 的知識連結總覽。
> 最後更新：2026-04-28

---

## 📋 Agent 總覽

| # | Agent | 職責 | 狀態 | 連結 |
|---|------|------|------|------|
| 01 | Orchestrator | 任務協調 | ✅ 運行中 | [[01_orchestrator/agent]] |
| 02 | Obsidian Builder | 知識管理 | ✅ 運行中 | [[02_Obsidian_Builder/agent]] |
| 03 | Art Expert | 視覺設計 | ✅ 運行中 | [[03_Art_Expert/agent]] |
| 04 | Video Director | 影片腳本 | ✅ 運行中 | [[04_Video_Director/agent]] |
| 05 | Content Writer | 文案寫作 | ✅ 運行中 | [[05_Content_Writer/agent]] |
| 06 | Financial Analyst | 財務分析 | ✅ 運行中 | [[06_Financial_Analyst/agent]] |
| 07 | Market Researcher | 市場研究 | ✅ 運行中 | [[07_Market_Researcher/agent]] |
| 08 | Software Engineer | 技術開發 | ✅ 運行中 | [[08_Software_Engineer/agent]] |
| 09 | Data Engineer | 資料工程 | ✅ 運行中 | [[09_Data_Engineer/agent]] |
| 10 | Social Publisher | 社群發布 | ✅ 運行中 | [[10_social_publisher/agent]] |
| 11 | Report Designer | 報告設計 | ✅ 運行中 | [[11_Report_Designer/agent]] |
| 12 | Quality Assurance | 品質檢驗 | ✅ 運行中 | [[12_Quality_Assurance/agent]] |

---

## 🗂️ 知識分類

### 核心 Agent（必需）

這些是系統運作的基本 Agent：

- [[01_orchestrator/agent]] - 總指揮，負責任務分派
- [[02_Obsidian_Builder/agent]] - 知識管理，儲存所有輸出
- [[12_Quality_Assurance/agent]] - 品質檢驗，確保輸出品質

### 內容生產 Agent

負責生成行銷內容：

- [[03_Art_Expert/agent]] - 視覺設計
- [[04_Video_Director/agent]] - 影片腳本
- [[05_Content_Writer/agent]] - 文案寫作
- [[11_Report_Designer/agent]] - 報告設計

### 分析研究 Agent

負責數據分析與研究：

- [[06_Financial_Analyst/agent]] - 財務分析
- [[07_Market_Researcher/agent]] - 市場研究
- [[09_Data_Engineer/agent]] - 資料工程

### 技術支援 Agent

負責系統維護與開發：

- [[08_Software_Engineer/agent]] - 軟體開發
- [[10_Social_Publisher/agent]] - 社群發布

---

## 🔗 協作關係圖

```
┌─────────────┐
│  使用者輸入  │
└──────┬──────┘
       ↓
┌─────────────┐
│ Orchestrator│
│  (01)       │
└──────┬──────┘
       ↓
    ┌──┴──────────┬──────────┬──────────┐
    ↓             ↓          ↓          ↓
┌───────┐  ┌───────┐  ┌───────┐  ┌───────┐
│ Market│  │Content│  │  Art  │  │ Video │
│Researcher│ │Writer │  │Expert │  │Director│
└───────┘  └───────┘  └───────┘  └───────┘
    └──────────┬──────────┬──────────┘
               ↓
        ┌─────────────┐
        │   QA Agent  │
        │   (12)      │
        └──────┬──────┘
               ↓
        ┌──────┴──────┐
        ↓             ↓
   ┌───────┐    ┌───────┐
   │Report │    │Social │
   │Designer│   │Publisher│
   └───────┘    └───────┘
        ↓             ↓
   ┌───────────────────┐
   │Obsidian Builder   │
   │     (02)          │
   └───────────────────┘
```

---

## 📊 Shared Data 資源

所有 Agent 共享的資源文件：

### 規則文件
- [[13_shared_data/routing]] - 任務分派規則
- [[13_shared_data/high_priority_skills]] - 優先安裝技能
- [[13_shared_data/error-handling-template]] - 錯誤處理規範
- [[13_shared_data/performance-tracking]] - 效能追蹤框架

### 索引文件
- [[13_shared_data/skill-index]] - 全技能索引
- [[ARCHITECTURE]] - 系統架構總覽

---

## 📝 工作日誌

### 每日記錄
- 查看 [[14_Daily_work_log/YYYY-MM-DD]]（每日更新）

### 每週彙總
- 查看 [[15_Weekly_work_log/YYYY-WXX]]（每週更新）

### QA 檢查日誌
- 查看 [[12_Quality_Assurance/qa_log/YYYY-MM-DD]]

### 效能日誌
- 查看 [[13_shared_data/performance_logs/YYYY-MM-DD]]

### 健康檢查日誌
- 查看 [[13_shared_data/health_logs/health_check_YYYY-MM-DD]]

---

## 🛠️ 設定與環境

- [[env/.env]] - API 金鑰設定
- [[05_Agents/ARCHITECTURE]] - 完整架構說明
- [[05_Agents/IMPROVEMENTS_SUMMARY]] - 改進總結

---

## 🎯 快速連結

### 新任務發起
→ 與 [[01_orchestrator/agent]] 互動

### 內容發布
→ [[05_Content_Writer/agent]] + [[03_Art_Expert/agent]] → [[10_social_publisher/agent]]

### 市場研究
→ [[07_Market_Researcher/agent]] + [[06_Financial_Analyst/agent]]

### 品質檢查
→ [[12_Quality_Assurance/agent]]

### 知識儲存
→ [[02_Obsidian_Builder/agent]]

---

## 📈 系統狀態

| 檢查項目 | 狀態 | 最後檢查 |
|---------|------|---------|
| Agent 定義 | ✅ 完整 | 2026-04-28 |
| Routing 規則 | ✅ 已更新 | 2026-04-28 |
| 錯誤處理 | ✅ 已實施 | 2026-04-28 |
| 效能追蹤 | ✅ 已實施 | 2026-04-28 |
| QA 機制 | ✅ 已實施 | 2026-04-28 |
| 健康檢查 | ✅ 已實施 | 2026-04-28 |

---

## 🔍 搜尋指引

### 按職能搜尋
- 需要文案？→ [[05_Content_Writer/agent]]
- 需要設計？→ [[03_Art_Expert/agent]]
- 需要分析？→ [[07_Market_Researcher/agent]]
- 需要發布？→ [[10_social_publisher/agent]]

### 按平台搜尋
- Instagram → [[03_Art_Expert/agent]] + [[05_Content_Writer/agent]]
- 小紅書 → [[05_Content_Writer/agent]] + [[03_Art_Expert/agent]]
- 電商 → [[05_Content_Writer/agent]] + [[03_Art_Expert/agent]] + [[10_social_publisher/agent]]

### 按類型搜尋
- 每日簡報 → [[07_Market_Researcher/agent]]
- 財務報告 → [[06_Financial_Analyst/agent]]
- 產品發布 → [[01_orchestrator/agent]]（多 agent 協作）
