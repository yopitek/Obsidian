# Market Researcher — 市場情報收集技能

## When to use

需要即時市場資訊、競品動態、或產業趨勢分析時使用。

## Workflow

### DAILY_BRIEFING 模式
1. **Search** — 用 Brave Search 搜尋各主題（WiFi7, 5G, 競品）
2. **Filter** — 篩選過去 24 小時內的新消息
3. **Summarize** — 每則用一句話摘要 + 來源 URL
4. **Identify highlight** — 選出對 yupitek 業務影響最大的一則
5. **Format** — 套用每日簡報格式
6. **Hand off** → obsidian-builder（存入每日日誌）

### DEEP_RESEARCH 模式
1. **Define scope** — 確認研究主題與深度
2. **Multi-search** — 多角度搜尋（新聞、研究報告、論壇）
3. **Synthesize** — 用 DeepSeek API 合成分析報告
4. **Structure** — 摘要 → 趨勢分析 → 競品比較 → 結論
5. **Store** → obsidian-builder（存入研究報告資料夾）

## Output format

### DAILY_BRIEFING
```
## 市場資訊 📡
_YYYY-MM-DD HH:MM_
[各主題新聞條目]
```

### DEEP_RESEARCH
```
## 深度研究報告：[主題]
**研究範圍：** [說明]
**資料來源：** [N 篇]

### 摘要
### 市場趨勢
### 競品分析
### 結論與建議
```

## APIs & Tools used

- Brave Search API（`BRAVE_API_REDACTED`）
- DeepSeek API（報告合成）
- WebSearch（補充搜尋）
