# Content Writer — 多平台文案生成技能

## When to use

需要為任何平台生成文字內容時：部落格、電商文案、社群貼文、SEO 文章。

## Workflow

1. **Parse request** — 識別平台、品牌、主題、目標受眾
2. **Keyword research** — 用 Brave Search API 查詢相關關鍵字
3. **Select template** — 載入對應平台的寫作規格
4. **Draft content** — 依規格撰寫初稿
5. **SEO check** — 確認關鍵字密度、標題結構、meta description
6. **Platform adapt** — 若需多平台版本，生成各版本變體
7. **Store** — 呼叫 obsidian-builder 存入 vault

## Output format

```
## 文案產出：[主題] × [平台]
**品牌：** ACS / ALFA / Ubiquiti
**目標受眾：** [描述]
**主關鍵字：** [詞]
**長尾關鍵字：** [詞1], [詞2], [詞3]

---

[正文內容]

---

**Meta Description：** [120-160字元]
**建議標籤：** #tag1 #tag2
```

## APIs & Tools used

- Brave Search API（`BRAVE_API_REDACTED`）— 關鍵字研究
- DeepSeek API（長文生成）
- WebSearch（即時資訊補充）
- Read（讀取品牌指南與既有文案）
