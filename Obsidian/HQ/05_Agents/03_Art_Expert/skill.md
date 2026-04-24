# Art Expert — 視覺素材生成技能

## When to use

需要為 ACS / ALFA / Ubiquiti 品牌生成任何行銷視覺素材時。包括社群貼文、電商 Banner、封面圖、縮圖。

## Workflow

1. **Parse brief** — 讀取任務：品牌、平台、主題、產品名稱
2. **Select spec** — 從平台規格表選擇正確尺寸與風格
3. **Build prompt** — 組合品牌固定描述詞 + 任務特定描述
4. **Generate** — 呼叫 HuggingFace API 或 Canva MCP 生成圖像
5. **Output asset list** — 列出所有產出的圖像 URL / 路徑與對應平台
6. **Hand off** — 將素材清單傳給 obsidian-builder 存入 vault

## Output format

```
## 視覺素材產出清單
**品牌：** ACS / ALFA / Ubiquiti
**任務：** [主題]
**日期：** YYYY-MM-DD

| 平台 | 尺寸 | 檔案/URL | 狀態 |
|------|------|---------|------|
| Instagram Feed | 1080x1080 | [路徑] | ✅ |
| 小紅書封面 | 1242x1660 | [路徑] | ✅ |

**生成 Prompt：**
[完整 prompt 記錄]
```

## APIs & Tools used

- HuggingFace API（`hf_REDACTED`）
- Canva MCP（mcp__Canva__generate-design）
- Read（讀取 10_resources/design-md/ 品牌參考）
- Write（儲存 prompt 記錄）
