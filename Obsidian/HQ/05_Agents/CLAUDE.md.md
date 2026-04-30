# 05_Agents — AI Agent 團隊總覽

> 本資料夾定義整個 AI Agent 工作系統的所有成員、職責、技能與互動流程。
> **所有互動記錄統一登記至：**
> - 每日：`HQ/01_Daily_note/YYYY-MM-DD.md` → Agent 執行記錄區塊
> - 每週：`HQ/02_Weekly_note/YYYY-WXX-weekly.md` → Agent 活動統計區塊

---

## 技術框架參考

- **Agent 編排**：LangGraph / CrewAI → https://github.com/langchain-ai/langchain.git
- **Task Schema**：YAML/JSON 格式，見 `10_shared_data/task-template.md`
- **Routing 規則**：見 `10_shared_data/routing.md`
- **技能索引**：見 `10_shared_data/skill-index.md`
- **部署腳本**：`10_shared_data/sync.sh`（Obsidian → `~/.claude/` 一鍵同步）

---

## Agent 團隊總覽（11 名成員）

| # | Agent 名稱 | Claude Code 名稱 | 核心職責 | 定義檔 |
|---|-----------|----------------|---------|-------|
| 01 | Orchestrator | `orchestrator` | ReAct 框架 PM，任務分解與分派 | [agent.md](HQ/05_Agents/01_orchestrator/agent.md) |
| 02 | Obsidian Builder | `obsidian-builder` | 知識管理，vault 寫入與維護 | [agent.md](HQ/05_Agents/02_Obsidian_Builder/agent.md) |
| 03 | Art Expert | `art-expert` | 視覺設計，行銷圖片生成 | [agent.md](HQ/05_Agents/03_Art_Expert/agent.md) |
| 04 | Video Director | `video-director` | 影片腳本、分鏡、B-roll | [agent.md](HQ/05_Agents/04_Video_Director/agent.md) |
| 05 | Content Writer | `content-writer` | SEO 文案，多平台內容 | [agent.md](HQ/05_Agents/05_Content_Writer/agent.md) |
| 06 | Financial Analyst | `financial-analyst` | 股市追蹤，財務週報 | [agent.md](HQ/05_Agents/06_Financial_Analyst/agent.md) |
| 07 | Market Researcher | `market-researcher` | WiFi7/5G 市場研究，競品分析 | [agent.md](HQ/05_Agents/07_Market_Researcher/agent.md) |
| 08 | Software Engineer | `software-engineer` | 程式開發，MCP，CI/CD | [agent.md](HQ/05_Agents/08_Software_Engineer/agent.md) |
| 09 | Data Engineer | `data-engineer` | 資料管線，格式轉換，RAG | [agent.md](HQ/05_Agents/09_Data_Engineer/agent.md) |
| 10 | Social Publisher | `social-publisher` | 跨平台發布，排程管理 | [agent.md](HQ/05_Agents/10_social_publisher/agent.md) |
| 11 | Report Designer | `report-designer` | PPT 簡報，資訊圖表，提案文件 | [agent.md](HQ/05_Agents/11_Report_Designer/agent.md) |

---

## 各 Agent 詳細定義

### 01 — Orchestrator（PM 協調者）

**Claude Code 名稱：** `orchestrator` | **框架：** ReAct（Reasoning + Acting）

**核心職責：**
- **任務分解** — 將使用者需求拆解為子任務，分配給對應 agent
- **狀態追蹤** — 監控每個 agent 的執行進度與輸出品質
- **衝突裁決** — 當多個 agent 產出衝突結果時進行判斷
- **並行協調** — 獨立任務並行派遣，相依任務串行執行

**工作流程範例：**
```
使用者：「幫我規劃下週的 WiFi 7 行銷活動」
  ↓
07 Market Researcher → 收集 WiFi 7 市場資料
06 Financial Analyst → 評估廣告預算建議
05 Content Writer    → 撰寫各平台文案        ← 並行
03 Art Expert        → 生成視覺素材          ← 並行
04 Video Director    → 製作影片腳本
10 Social Publisher  → 排程發布到各平台
02 Obsidian Builder  → 存入 vault 記錄
```

**技術建議：** LangGraph 或 CrewAI 實作 agent 編排；YAML/JSON task schema 傳遞結構化任務

**技能檔：** [skill.md](HQ/05_Agents/01_orchestrator/skill.md)

---

### 02 — Obsidian Builder（知識管理）

**Claude Code 名稱：** `obsidian-builder`

**核心工具：** Obsidian MCP Server + Dataview plugin

**核心職責：**
- 自動將其他 agent 的輸出（報告、文案、市場分析）轉化為 Markdown 筆記存入 vault
- 維護雙向連結（backlinks）確保知識圖譜完整
- 定期整理 MOC（Map of Content）索引頁
- 管理 yupitek.com 相關產品資料庫、競品資訊、客戶洞察
- 每日筆記與每週彙總的建立與維護

**Vault 結構：**
```
HQ/
├── 01_Daily_note/    ← 每日記錄（YYYY-MM-DD.md）
├── 02_Weekly_note/   ← 每週彙總（YYYY-WXX-weekly.md）
├── 04_Work/          ← 品牌工作資料夾
│   └── 05_Agents/   ← 本 Agent 系統定義
├── 10_resources/     ← 參考資料庫（唯讀）
└── Template/         ← 筆記模板
```

**行為規則：** 只能新增，絕不刪除筆記；10_resources/ 唯讀；不覆蓋使用者手寫內容

**技能檔：** [skill.md](HQ/05_Agents/02_Obsidian_Builder/skill.md)

---

### 03 — Art Expert（視覺設計）

**Claude Code 名稱：** `art-expert`

**工具鏈：** HuggingFace API + Canva MCP + Midjourney / FLUX / DALL-E 3 + Adobe Firefly

**核心職責：**
- 維護 ACS / ALFA / Ubiquiti 品牌 style guide（色彩、字型、logo 規範）
- 生成各平台行銷視覺素材（含 prompt template 庫確保風格一致）
- 與 content-writer 並行執行電商上架任務
- 與 video-director 協作製作 YouTube 縮圖

**平台規格（三區）：**
| 地區 | 平台 | 尺寸 |
|------|------|------|
| 🇹🇼 台灣 | Instagram Feed | 1080×1080 (1:1), 1080×1350 (4:5) |
| 🇹🇼 台灣 | Instagram Story | 1080×1920 (9:16) |
| 🇹🇼 台灣 | Facebook 封面 | 820×312 |
| 🇹🇼 台灣 | 蝦皮 Banner | 1200×400 |
| 🇹🇼 台灣 | 露天 主圖 | 1024×1024 |
| 🇨🇳 中國 | 淘寶主圖 | 800×800 |
| 🇨🇳 中國 | Bilibili 封面 | 1280×720 |
| 🇺🇸 美國 | Newegg 商品圖 | 1000×1000 |
| 全區共用 | YouTube Thumbnail | 1280×720 |

**技能檔：** [skill.md](HQ/05_Agents/03_Art_Expert/skill.md)

---

### 04 — Video Director（影片製作）

**Claude Code 名稱：** `video-director`

**工具鏈：** Nvidia API + DeepSeek + Sora / Runway ML / Kling AI + Descript（自動字幕）

**核心職責：**
- 撰寫完整分鏡腳本（場景描述、鏡頭語言、台詞）
- 生成 B-roll 素材的 AI 影片 prompt
- 製作 YouTube 縮圖（與 art-expert 協作）
- 短影音版本適配（YouTube Shorts / Instagram Reels 垂直格式）

**影片規格模板庫：**
- 開箱影片（Unboxing）：鉤子 15s → 外觀 30s → 拆箱 60s → 演示 90s → 總結 30s
- 教學影片（Tutorial）：問題引入 → 步驟演示 → 常見問題 → CTA
- 產品展示（Showcase）：品牌開場 → 亮點 → 規格 → 場景 → 購買

**技能檔：** [skill.md](HQ/05_Agents/04_Video_Director/skill.md)

---

### 05 — Content Writer（文字內容）

**Claude Code 名稱：** `content-writer`

**核心技能：** SEO 優化（關鍵字研究 + 內容結構）+ 多平台語氣適配

**工具建議：**
- Brave Search API — 關鍵字研究（替代 Ahrefs / SEMrush）
- DeepSeek API — 長文生成
- Grammarly API — 英文內容品質檢查（未來擴充）

**各平台寫作規格（三區）：**
| 地區 | 平台 | 字數 | 語言 | 風格 |
|------|------|------|------|------|
| 🇹🇼 台灣 | Instagram | 150-200字 | 繁體中文 | 鉤子句 + 賣點 + hashtag |
| 🇹🇼 台灣 | Facebook | 150-300字 | 繁體中文 | 故事性敘述、情感連結 |
| 🇹🇼 台灣 | 蝦皮 / 露天 | 300-500字 | 繁體中文 | 規格表 + 使用場景 |
| 🇨🇳 中國 | 淘寶 | 標題≤30字 | 簡體中文 | 關鍵字密集，含規格參數 |
| 🇨🇳 中國 | Bilibili | 簡介≤1000字 | 簡體中文 | 影片說明、時間軸、hashtag |
| 🇺🇸 美國 | Newegg | 標題≤80char | 英文 | Bullet Points + 規格表 |
| 全區 | 部落格 SEO | 1500-3000字 | 依地區 | 長尾關鍵字 + 結構化標題 |

**每個平台建立獨立 system prompt 模板，與 art-expert 並行執行**

**技能檔：** [skill.md](HQ/05_Agents/05_Content_Writer/skill.md)

---

### 06 — Financial Analyst（財務分析）

**Claude Code 名稱：** `financial-analyst`

**資料來源：** 台灣證交所 API、Yahoo Finance (yfinance)、Alpha Vantage、IMF/OECD 總經報告

**核心職責：**
- 追蹤 WiFi、行動通訊、半導體相關股票與市場走勢
- 製作週報，彙整市場訊號對公司採購/銷售策略的影響
- 建立財務儀表板存入 Obsidian（配合 02 Obsidian Builder）

**追蹤標的：** QCOM、2454.TW（MediaTek）、NTGR、UI（Ubiquiti）、AVGO、MRVL、SOX 指數

**兩種模式：**
- `MARKET_SIGNAL` — 市場訊號報告，可存入 Obsidian
- `INVESTMENT_QUERY` — 投資查詢，僅在對話回應，不寫入 vault

**技能檔：** [skill.md](HQ/05_Agents/06_Financial_Analyst/skill.md)

---

### 07 — Market Researcher（市場研究）

**Claude Code 名稱：** `market-researcher`

**重點追蹤主題：** WiFi 7（802.11be）、5G RedCap、AI Edge 裝置、行動周邊配件市場

**推薦資料來源：** IDC、Counterpoint Research、Statista、各大廠商官方新聞稿、Reddit/PTT 論壇聲量分析、Brave Search API

**核心職責：**
- 競品分析（TP-Link、NETGEAR、華碩、ALFA 等）
- 新品發布追蹤（WiFi 7 晶片、路由器、AP）
- 市場規模與成長率報告
- 每月整理成 Obsidian 筆記供 Orchestrator 調用

**兩種模式：**
- `DAILY_BRIEFING` — 每日早報，存入每日筆記「市場資訊」區塊
- `DEEP_RESEARCH` — 深度研究報告，存入 `HQ/04_Work/` 資料夾

**技能檔：** [skill.md](HQ/05_Agents/07_Market_Researcher/skill.md)

---

### 08 — Software Engineer（軟體開發）

**Claude Code 名稱：** `software-engineer`

**開發框架：** Superpowers（brainstorm → write-plan → execute-plan → verify）+ OpenSpec

**核心職責：**
- CI/CD pipeline 管理（GitHub Actions）
- API 整合開發（串接各 agent 使用的外部服務：Brave Search、HuggingFace、Nvidia、Telegram）
- MCP Server 開發與維護（讓 agent 能使用自訂工具）
- 建立 agent 測試框架（確保每個 agent 輸出品質穩定）
- Cloudflare Tunnel 維護（yopitekclaw1）

**規範：** TDD 強制（先測試再實作）；遵循 `~/.claude/rules/ca-coding-style.md`；API key 永不硬編碼

**技能檔：** [skill.md](HQ/05_Agents/08_Software_Engineer/skill.md)

---

### 09 — Data Engineer（資料工程）

**Claude Code 名稱：** `data-engineer`

**核心工具：** Pandoc（格式轉換）、Marker / Docling（PDF → Markdown）、BeautifulSoup（HTML 解析）、pandas（Excel 自動化）

**核心職責：**
- 資料清洗 pipeline（去除雜訊、統一格式、修正編碼）
- 格式轉換（PDF / Excel / HTML → Markdown）
- 建立資料版本控制（DVC）
- 維護向量資料庫（ChromaDB / FAISS，供 02 Obsidian Builder 的 RAG 使用）
- Excel 報表自動化（市場數據 → 標準化 Markdown 表格）

**向量 DB：** HuggingFace Embeddings (`sentence-transformers/all-MiniLM-L6-v2`)

**技能檔：** [skill.md](HQ/05_Agents/09_Data_Engineer/skill.md)

---

### 10 — Social Publisher（社群發布）🆕

**Claude Code 名稱：** `social-publisher`

**工具鏈：** social-auto-upload + Telegram Bot API

**核心職責：**
- 將 art-expert / content-writer / video-director 的產出按地區語言自動分流並排程發布
- 管理發布日曆（`10_social_publisher/schedule.md`）
- 發布前格式驗證（尺寸、字數、標籤數）+ 中國平台敏感詞替換
- 發布失敗重試 3 次，仍失敗則 Telegram 通知

**管理平台（三區分組）：**

| 地區 | 平台 | 語言 |
|------|------|------|
| 🇹🇼 台灣 | Instagram、Facebook、蝦皮拍賣、露天拍賣 | 繁體中文 |
| 🇨🇳 中國 | 淘寶、Bilibili | 簡體中文 |
| 🇺🇸 美國 | Newegg | 英文 |
| 🔔 通知 | Telegram | — |

**最佳發布時段：**
| 平台 | 主要時段 |
|------|---------|
| Instagram | 11:00, 19:00（TST）|
| Facebook | 09:00, 18:00（TST）|
| 蝦皮 / 露天 | 工作日 10:00 即時 |
| Bilibili | 18:00–22:00（CST）|
| 淘寶 / Newegg | 工作日即時 |

**排程檔：** [schedule.md](schedule.md) | **技能檔：** [skill.md](HQ/05_Agents/10_social_publisher/skill.md)

---

### 11 — Report Designer（報告設計）🆕

**Claude Code 名稱：** `report-designer`

**工具鏈：** python-pptx + AntV Infographic + Pandoc + WeasyPrint + frontend-slides (Reveal.js)

**核心職責：**
- 將 market-researcher / financial-analyst 文字報告轉化為品牌化視覺文件
- 生成 PPT 簡報、AntV 資訊圖表、HTML 投影片、PDF 報告
- 套用 ACS / ALFA / Ubiquiti / yupitek 品牌色彩與字型
- 完成後交由 social-publisher 發布，obsidian-builder 存入 vault

**簡報模板：**
- 市場週報（market-researcher 輸出 → 6 頁 PPT）
- 財務週報（financial-analyst 輸出 → 5 頁 PPT）
- 產品發布提案（orchestrator 多 agent 輸出 → 客製化頁數）

**5-3-1 法則：** 每頁 ≤5 個重點、≤3 個視覺元素、1 個核心結論

**技能檔：** [skill.md](HQ/05_Agents/11_Report_Designer/skill.md)

---

## 完整內容生產流水線

```
市場情報
market-researcher ──→ financial-analyst
        ↓                    ↓
   report-designer ←─────────┘
        ↓
   art-expert (視覺強化)
        ↓
content-writer + video-director (文字/影片)
        ↓
social-publisher (跨平台發布)
        ↓
obsidian-builder (知識存檔)
```

---

## 並行執行最佳組合

| 任務類型 | 並行組合 |
|---------|---------|
| 電商上架 | art-expert + content-writer |
| 每日早報 | market-researcher + financial-analyst |
| 行銷活動全套 | art-expert + content-writer + video-director |
| 報告生成後發布 | report-designer → social-publisher |
| 視覺圖表整合 | art-expert + report-designer |

---

## 互動記錄規範

### 每日記錄格式

在 `HQ/01_Daily_note/YYYY-MM-DD.md` 的「Agent 執行記錄」區塊追加：

```markdown
| HH:MM | 任務描述 | agent名稱 | ✅/❌ | 產出摘要 |
```

### 每週彙總

每週一由 obsidian-builder 在 `HQ/02_Weekly_note/YYYY-WXX-weekly.md` 建立，彙整所有 11 個 agent 的任務數與主要產出。

---

## 資料夾結構

```
05_Agents/
├── 01_orchestrator/        agent.md + skill.md
├── 02_Obsidian_Builder/    agent.md + skill.md
├── 03_Art_Expert/          agent.md + skill.md
├── 04_Video_Director/      agent.md + skill.md
├── 05_Content_Writer/      agent.md + skill.md
├── 06_Financial_Analyst/   agent.md + skill.md
├── 07_Market_Researcher/   agent.md + skill.md
├── 08_Software_Engineer/   agent.md + skill.md
├── 09_Data_Engineer/       agent.md + skill.md
├── 10_social_publisher/    agent.md + skill.md + schedule.md
├── 11_Report_Designer/     agent.md + skill.md
├── 10_shared_data/         routing.md + skill-index.md +
│                           task-template.md + high_priority_skills.md + sync.sh
├── env/                    .env（所有 API keys）
├── Daily_work_log/         每日工作記錄（→ 01_Daily_note/）
├── Weekly_work_log/        每週彙總（→ 02_Weekly_note/）
└── CLAUDE.md.md            本文件
```

---

## API Keys 位置

所有 API keys 統一存放於：
```
05_Agents/env/.env
```

**已設定的 API：** DeepSeek、Nvidia（多模型）、Brave Search、Telegram Bot、Gmail、HuggingFace、Cloudflare Tunnel

---

> **最後更新：** 2026-04-17
> **版本：** v2.0 — 11 Agent 完整系統
> **維護者：** software-engineer agent + 手動更新
