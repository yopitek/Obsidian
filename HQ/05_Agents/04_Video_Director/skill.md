---
title: "Video Director Skills"
created: 2026-05-02
type: skill
summary: "影片腳本生成與短影音適配技能。"
---

# Video Director — 影片腳本生成技能

## 可用工具
- DeepSeek API（腳本撰寫）
- Nvidia API（複雜推理版本）
- WebSearch（產品規格查詢）
- Read（讀取品牌風格指南）

## 相關工具與資源
- [[../../10_resources/01_Tools_and_Skills/02_Video_Director|相關工具與資源]]

## When to use

需要為產品製作影片內容規劃時：開箱、教學、展示、短影音。

## Workflow

1. **Identify type** — 判斷影片類型（unboxing / tutorial / showcase）
2. **Select template** — 載入對應腳本結構模板
3. **Research** — WebSearch 取得產品最新規格與賣點
4. **Write storyboard** — 填寫完整分鏡表（場景、鏡頭、台詞）
5. **Generate B-roll prompts** — 為每個場景生成 AI 影片 prompt
6. **Adapt short form** — 生成 60 秒垂直版本（Shorts/Reels）
7. **Thumbnail brief** — 輸出縮圖設計需求給 art-expert
8. **Store** — 呼叫 obsidian-builder 存入 vault

## Output format

```
## 影片腳本：[產品名] [類型]
**時長：** [X 分鐘]
**平台：** YouTube / Instagram Reels / TikTok

### 分鏡表
| # | 時間 | 場景 | 鏡頭 | 台詞 | B-roll Prompt |
...

### 短影音版（60s）
[精華分鏡]

### 縮圖設計需求
→ 轉交 art-expert
```
