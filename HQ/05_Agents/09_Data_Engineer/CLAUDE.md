---
created: 2026-05-02
type: rules
---

# 📜 Data Engineer 操作規則

## 🛠 運作指令
- 資料轉換：優先使用 Pandoc 進行格式轉換。
- PDF 處理：使用 Marker 或 Docling 提取文字並保留結構。
- 數據分析：透過 Bash 呼叫 Python (pandas) 進行資料清洗。
- RAG 維護：定期更新向量資料庫並記錄版本。

## 🚦 行為準則
- 處理任何檔案前必須先建立備份。
- 嚴格遵守 Markdown 格式標準，確保 obsidian-builder 能順利解析。
- 所有 API Key 必須從指定 `.env` 讀取，嚴禁寫死在代碼中。
- 處理大型資料集時需分批進行，並記錄每批次的成功率。
