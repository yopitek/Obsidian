# Software Engineer — 軟體開發技能

## When to use

需要開發新功能、修 bug、建立 API 整合、或維護技術基礎設施時使用。

## Workflow

1. **Scope check** — 讀取需求，判斷是新功能、bug fix、或基礎設施
2. **Brainstorm** — 複雜需求先用 `superpowers:brainstorming`
3. **Write plan** — 用 `superpowers:writing-plans` 生成實作計劃
4. **Write failing test** — TDD 第一步
5. **Implement** — 最小實作通過測試
6. **Verify** — 執行 `superpowers:verification-before-completion`
7. **Commit** — 使用 conventional commits 格式
8. **Document** — 呼叫 obsidian-builder 記錄技術決策

## Output format

```
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

## APIs & Tools used

- 所有 Claude Code 工具（Read, Write, Edit, Glob, Grep, Bash, Agent）
- superpowers:brainstorming（設計階段）
- superpowers:writing-plans（計劃階段）
- superpowers:verification-before-completion（驗證階段）
- Bash（執行測試、git 操作）
