# Orchestrator — 任務協調技能

## When to use

當使用者提出需要多個 agent 協作的複合型任務時使用。單一 agent 可完成的任務直接分派，無需走此流程。

## Workflow

1. **Receive** — 讀取使用者任務，識別關鍵詞與目標
2. **Decompose** — 拆解為子任務清單，標記相依關係
3. **Route** — 對照 `10_shared_data/routing.md` 選擇對應 agent
4. **Dispatch** — 並行或串行呼叫 subagent（使用 Agent tool）
5. **Collect** — 收集所有 agent 輸出
6. **Evaluate** — 檢查輸出品質，必要時補充派遣
7. **Store** — 呼叫 obsidian-builder 將結果存入 vault
8. **Notify** — 若有 Telegram token，傳送完成通知
9. **Report** — 向使用者彙整最終結果

## Output format

```
## 任務執行報告
**任務：** [名稱]
**執行時間：** [HH:MM]

### 子任務結果
| Agent | 任務 | 狀態 | 摘要 |
|-------|------|------|------|
| market-researcher | WiFi7 市場資料 | ✅ | 3 篇報告，key insight: ... |

### 最終輸出
[整合後的完整結果]

### Obsidian 記錄
存入：[路徑]
```

## APIs & Tools used

- Agent tool（派遣所有 subagent）
- Read（讀取 routing.md 與 skill-index.md）
- Bash（讀取 env/.env 取得 Telegram token）
- WebSearch（補充即時資訊）
