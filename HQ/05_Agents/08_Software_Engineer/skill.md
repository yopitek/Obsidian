---
title: "Software Engineer Skills"
created: 2026-05-02
type: skill
summary: "Software Engineer — 軟體開發技能與超級權力工作流。"
---

# Software Engineer Skills

## 🛠️ 可用工具與技能
- **Claude Code Core Tools**: Read, Write, Edit, Glob, Grep, Bash, Agent.
- **Superpowers Tools**:
	- `brainstorming`: 設計與發想。
	- `writing-plans`: 實作計劃生成。
	- `verification-before-completion`: 自動化驗證。
- **Git/GitHub**: 版本控制與 CI/CD。

## 🔗 相關資源
- [[../../10_resources/01_Tools_and_Skills/04_Software_Engineer/github_skill|GitHub Skill]]
- [[../../10_resources/01_Tools_and_Skills/|10_resources/01_Tools_and_Skills/]]

## 🔄 工作流程 (Workflow)

1. **Scope check** — 讀取需求，判斷是新功能、bug fix、或基礎設施。
2. **Brainstorm** — 複雜需求先用 `superpowers:brainstorming`。
3. **Write plan** — 用 `superpowers:writing-plans` 生成實作計劃。
4. **Write failing test** — TDD 第一步：先寫測試確保 RED。
5. **Implement** — 最小實作通過測試，變為 GREEN。
6. **Verify** — 執行 `superpowers:verification-before-completion` 確保品質。
7. **Commit** — 使用 conventional commits 格式提交變更。
8. **Document** — 呼叫 obsidian-builder 記錄技術決策。

## 📊 輸出格式 (Output Format)

```markdown
## 開發任務完成報告
**功能：** [名稱]
**類型：** feat / fix / refactor / chore
**測試覆蓋率：** [X]%

### 變更檔案
- 新增：[路徑]
- 修改：[路徑]

### Commit
[commit hash] [commit message]

### 技術決策記錄
[重要決策說明]
```
