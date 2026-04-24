# Financial Analyst — 市場財務分析技能

## When to use

需要股市追蹤、市場訊號分析、或產業財務報告時使用。

## Workflow

1. **Identify scope** — 判斷模式：MARKET_SIGNAL（可存 Obsidian）或 INVESTMENT_QUERY（僅對話）
2. **Fetch data** — 用 Brave Search 抓最新市場新聞
3. **Get prices** — 用 yfinance（Bash）取得股價數據
4. **Analyze** — 整合數據，識別市場訊號與業務影響
5. **Format report** — 生成結構化週報
6. **Route output** — MARKET_SIGNAL → obsidian-builder；INVESTMENT_QUERY → 直接回應

## Output format

```
## 市場分析報告
**日期：** YYYY-MM-DD
**模式：** MARKET_SIGNAL / INVESTMENT_QUERY

### 股市快照
| 標的 | 代號 | 價格 | 週漲跌 | 訊號 |
|------|------|------|-------|------|

### 產業關鍵事件
1. [事件] — [業務影響]

### 對 yupitek 採購策略的意涵
[分析說明]
```

## APIs & Tools used

- Brave Search API（市場新聞）
- Bash + yfinance（股價數據）
- WebSearch（補充即時資訊）
