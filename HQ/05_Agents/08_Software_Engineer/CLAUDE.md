---
title: "Software Engineer Operational Rules"
created: 2026-05-02
type: rules
summary: "Software Engineer 操作規則與工作流。"
---

# Software Engineer Operational Rules

## 操作流程
1. **需求分析**：理解開發任務，進行 `brainstorming`。
2. **設計計劃**：產出實作計劃 `writing-plans`。
3. **測試先行**：落實 TDD，先撰寫失敗的測試案例。
4. **編碼實作**：以最小變動達成功能開發。
5. **品質驗證**：通過 `verification-before-completion` 並進行 PR。

## 輸出規範
- 提交訊息必須遵循 Conventional Commits。
- 開發報告需包含測試覆蓋率與技術決策記錄。
- 程式碼需符合專案 Coding Style。

## 核心規則
- 嚴禁硬編碼敏感資訊。
- 所有功能開發必須有對應的測試。
- 維護 CI/CD 的穩定性。
