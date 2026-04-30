# HQ Vault — 結構與命名規則

這份文件記錄整個 vault 的資料夾配置、命名慣例，以及新增筆記時應遵循的規則。
（人物設定與 AI 行為原則放在 `CLAUDE.md`，這份只負責「東西要放哪、要叫什麼」。）

最近一次整理：2026-04-28

---

## 1. 頂層資料夾

| 資料夾 | 用途 | 備註 |
| --- | --- | --- |
| `01_Daily_note/` | 每日筆記 | 檔名必為 `YYYY-MM-DD.md` |
| `02_Weekly_note/` | 週報 / 週回顧 | 檔名 `YYYY-Www.md`（例：`2026-W17.md`） |
| `03_Home/` | 個人領域：學習、教育、生活 | 子資料夾用 `01_Education/`、`02_Learning/` 等編號 |
| `04_Work/` | 工作相關所有專案 | 見下方細項 |
| `05_Agents/` | AI agent 設定、prompt、log | 每個 agent 一個編號資料夾 |
| `10_resources/` | 通用資源庫 | 寫作 prompt、coding skill、reference data |
| `Template/` | Obsidian 樣板 | 新筆記從這裡複製 |
| `CLAUDE.md` | 工作原則 / AI 行為規範 | 不要動內容，只在規則改變時更新 |
| `VAULT_README.md` | 本檔案 | 結構或命名規則調整時更新 |

> **未來規劃**：`04_Work/10_Website/04_official_website/` 的 Hugo 網站專案（目前佔 vault 約 80% 體積）會搬離 vault，僅保留 `Doc/`、`marking_plan/`、`improve_plan/` 等筆記內容。搬遷後請更新本檔。

---

## 2. 04_Work 子結構

```
04_Work/
├── 01_yupitek/        # 公司營運：projects、research、finance、reports、assets、campain
├── 02_Products/       # 各產品線（每個產品一個編號資料夾）
│   ├── 01_ACS/
│   ├── 02_ALFA/
│   ├── 03_Ubiquiti/
│   ├── 04_Flip_zero/
│   ├── 05_iBeacon/
│   ├── 06_Hak5/
│   └── 07_mobilephone/
├── 10_Website/        # 官網、IG、影片、部落格
│   ├── 01_Blog_Article/
│   ├── 02_IG/
│   ├── 03_Video/
│   └── 04_official_website/   # ← 之後會搬出 vault
├── HW_setup/          # 硬體設定筆記
├── SW_project/        # 軟體專案（_01_Plan / _02_On_going / _03_archive）
└── env/
```

「產品相關」的東西一律放 `02_Products/<編號>_<產品>/`，**不要**在 `04_Work/` 根目錄另開產品資料夾（例如以前的 `04_Work/07_mobilephone/` 已合併進 `02_Products/`）。

---

## 3. 命名規則

### 資料夾
- 編號用 **兩位數加底線**：`01_`、`02_`、`10_`。需要排在最前面用 `00_` 或加底線（例：`_Templates/`）。
- 同層資料夾用同一語言（英文為主，特殊情況才用中文，例：`封存/`）。新增資料夾統一用英文。
- 已封存內容統一放 `_03_archive/`，**不要再用** `封存/`。

### 檔案
- 一般筆記：`<主題>-<標題>.md`，全小寫或駝峰皆可，但同一資料夾內保持一致。
- Daily note：**`YYYY-MM-DD.md`**（4-2-2 格式，不加前綴）。
- Weekly note：**`YYYY-Www.md`**（例：`2026-W17.md`）。
- 專案內子文件用 `index.md` 當入口，`CLAUDE.md` 放該專案內的 AI 規則。
- **嚴禁** `.md.md` 雙副檔名（macOS 拖拉常踩到）。如遇到請改回 `.md`。
- 不要用 `未命名.md`、`Untitled.md`、`新筆記.md`——立刻改名或刪掉。

### Frontmatter（永久筆記）
```yaml
---
title: 筆記標題
tags: []
created: YYYY-MM-DD
type: permanent          # 或 daily / project / reference
summary: 一句話摘要
---
```

### 標籤分類
- 領域：`#tech` `#business` `#reading` `#life`
- 狀態：`#todo` `#in-progress` `#done`
- 類型：`#idea` `#reference` `#project`

---

## 4. 新增內容該放哪

| 內容類型 | 位置 |
| --- | --- |
| 今天的隨手記 | `01_Daily_note/YYYY-MM-DD.md` |
| 永久筆記（學到的東西） | `03_Home/02_Learning/` 或 `10_resources/` |
| 工作中的專案 | `04_Work/01_yupitek/01_Projects/<專案名>/` |
| 產品相關（規格、研究、素材） | `04_Work/02_Products/<產品>/` |
| 寫作或 coding 用 prompt | `10_resources/03_writing_prompts/` 或 `10_resources/02_coding_agents/` |
| AI agent 設定與 log | `05_Agents/<編號>_<角色>/` |
| 暫時不知道放哪 | 先丟 `01_Daily_note/`，回頭再分類；不要堆到根目錄 |

---

## 5. 衛生規則（每月檢查一次）

執行下列指令確認 vault 乾淨：

```bash
cd ~/Downloads/n8n_project/obsidian/Obsidian/HQ

# 1) 不該有 .DS_Store
find . -name ".DS_Store" -not -path "*/.git/*" | head

# 2) 不該有 .md.md
find . -name "*.md.md" -not -path "*/.git/*"

# 3) 不該有空白筆記
find . -name "*.md" -size 0 -not -path "*/.git/*"

# 4) 不該有「未命名 / Untitled」
find . \( -name "Untitled*.md" -o -name "未命名*.md" \) -not -path "*/.git/*"
```

如果有結果就清掉。.DS_Store 可以順便加到 Obsidian 的「檔案與連結 → 排除的檔案」設定裡。

---

## 6. 變更記錄

| 日期 | 變更 |
| --- | --- |
| 2026-04-28 | 建立本檔；清除 17 個 `.DS_Store` 與 6 個空白 md；修正 32 個 `.md.md` 副檔名；合併 `04_Work/07_mobilephone/` 進 `04_Work/02_Products/07_mobilephone/`。 |
