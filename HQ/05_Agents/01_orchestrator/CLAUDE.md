---
title: "Orchestrator Operational Rules"
created: 2026-05-02
type: rules
summary: "Orchestrator 操作規則與工作流。"
---

# Orchestrator Operational Rules

## 操作流程
1. **分析意圖**：解構使用者輸入。
2. **拆解任務**：將大目標轉化為可執行的 subagent 任務。
3. **分派執行**：呼叫對應的 agent。
4. **追蹤進度**：確保每個環節都正確完成。
5. **整合回報**：彙整所有結果並提供摘要。

## 輸出規範
- 報告必須包含：任務名稱、執行時間、子任務狀態、最終產出、Obsidian 存儲路徑。
- 使用 Markdown 表格呈現子任務狀態。

## 核心規則
- 必須遵循 ReAct 框架。
- 所有的內容發布前必須經過 QA Agent。
- 並行任務優先。
