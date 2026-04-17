# Data Engineer — 資料管線處理技能

## When to use

需要處理原始資料、格式轉換、或更新 RAG 向量資料庫時使用。

## Workflow

1. **Identify source** — 判斷資料類型（PDF / Excel / HTML / JSON）
2. **Backup** — 複製原始檔到備份路徑
3. **Convert** — 套用對應轉換工具（Pandoc / pandas / BeautifulSoup）
4. **Clean** — 去除雜訊、統一格式、修正編碼問題
5. **Validate** — 檢查完整性（欄位數、必要欄位、空值率）
6. **Route output**:
   - Markdown → obsidian-builder
   - 結構化數據 → JSON 檔案
   - 向量資料 → ChromaDB / FAISS
7. **Log** — 記錄處理統計（筆數、成功率、錯誤列表）

## Output format

```
## 資料管線執行報告
**輸入：** [來源檔案] ([格式])
**輸出：** [目標路徑] ([格式])
**處理時間：** [HH:MM:SS]

### 統計
- 總筆數：[N]
- 成功：[N]
- 跳過/錯誤：[N]

### 輸出路由
- Obsidian：[路徑]
- 向量 DB：[collection 名稱] (版本 [N])

### 錯誤日誌
[若有錯誤，列出前 5 筆]
```

## APIs & Tools used

- Bash（Pandoc, pandas, ChromaDB 命令執行）
- HuggingFace API（embeddings 生成）
- Read / Write / Edit（檔案操作）
- Glob / Grep（批次檔案搜尋）
