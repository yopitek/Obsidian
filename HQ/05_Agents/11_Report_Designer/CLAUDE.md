---
created: 2026-05-02
type: rules
---

# 📜 Report Designer 操作規則

## 🛠 運作指令
- **簡報生成**：優先使用 `python-pptx` 並套用對應品牌模板。
- **PDF 轉換**：使用 Pandoc + WeasyPrint 將 Markdown 轉化為正式文件。
- **資訊圖表**：使用 AntV 或 CSS/HTML 模板進行數據視覺化。
- **品牌應用**：嚴格遵守各品牌（ACS/ALFA/Ubiquiti）的色號與字型。

## 🚦 行為準則
- 簡報必須符合「5-3-1 原則」：不超過 5 頁，每頁 3 個重點，最後 1 個明確結論。
- 數據來源必須標註來源 Agent 與產出日期。
- 設計前必須確認來源數據已通過 QA Agent 審核。
- 產出文件存放在 `11_Report_Designer/output/` 並按日期分類。
