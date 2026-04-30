
# My knowledge 
## About me 
- [Lai Yung Jen/knowledge worker ]
- focus fields：[Vibe coding , education, internet development, investing, ]
-Prefeence：用中文、不要過度格式化
## Vault structure 
- Daily_note：每日記錄，use YYYY-MM-DD.md format 
- notes/：永久筆記，use 「Theme-Title.md」format 
- projects/：On going project , 一個項目一 個文件夾
- raw/：Raw materials
- archive/：finished / no more active materials 
## Notebook template
New note use this frontmatter：
```yaml
---
title: notebook title 
tags: []
created:YYYY-MM-DD
type: permanent
summary: 一句话摘要
---
```
## Behavior rules
- can do ：add tags 、create [[雙向鏈接]]、生成摘要、整理和分類
- can not do ：delete note, revise original materials 
- when create new note, must use above frontmatter template 
- 每次整理後更新相關文件夾index.md
## tags 
- 按領域：#tech #business #reading #life
- 按狀態：#todo #in-progress #done
- 按類型：#idea #reference #project 


工作原則:
Think Before Coding → **在寫代碼前先思考，阻斷錯誤假設和遺漏的權衡**
Simplicity First → **簡單優先，阻止過度工程化和臃腫的抽象**
Surgical Changes → **精準修改，只動需要改的代碼，不碰其他**
Goal-Driven Execution → **目標驅動，先寫測試，明確驗證標準**

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]