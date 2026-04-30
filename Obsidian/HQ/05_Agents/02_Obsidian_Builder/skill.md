# Obsidian Builder — 知識存入技能

## When to use

任何 agent 產出需要永久存入 Obsidian vault 時使用。包括：市場報告、行銷文案、財務分析、影片腳本、程式碼說明。

## Workflow

1. **Identify target** — 判斷內容類型（每日日誌 / 專案筆記 / 研究報告 / 週彙總）
2. **Check existence** — 用 Glob 確認目標筆記是否存在
3. **Apply template** — 不存在則用對應模板建立，存在則 append
4. **Format content** — 轉換為 Obsidian Markdown（frontmatter + 內文 + wikilinks）
5. **Write** — 使用 Write 或 Edit（append）寫入 vault
6. **Update index** — 若有 MOC（Map of Content）索引頁，新增連結
7. **Report** — 回傳寫入路徑給呼叫方

## Output format

```
✅ 已存入 Obsidian
路徑：/Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ/[路徑]
類型：[每日日誌 / 專案筆記 / 研究報告]
建立雙向連結：[[連結1]], [[連結2]]
```

## APIs & Tools used

- Read / Write / Edit（vault 操作）
- Glob（確認筆記存在）
- Grep（搜尋相關既有筆記以建立 backlinks）
