# Task Template

> 每次任務開始前，使用此模板填寫任務資訊。

---

## 📋 任務模板

```yaml
task: "[任務名稱]"
goal: "[目標描述：要達成什麼結果]"
input: "[輸入資料：提供什麼資訊/文件/素材]"
constraints:
  - "[限制條件 1]"
  - "[限制條件 2]"
expected_output: "[預期輸出：格式、長度、品質標準]"
assigned_agent: "[orchestrator / obsidian-builder / art-expert / video-director / content-writer / financial-analyst / market-researcher / software-engineer / data-engineer / social-publisher / report-designer]"
priority: "[high / medium / low]"
parallel_agents: "[若需並行，列出其他 agent]"
```

---

## 📝 範例

```yaml
task: "撰寫 WiFi 7 行銷活動全套素材"
goal: "生成本週 WiFi 7 行銷所需的文案、視覺、影片腳本"
input: "產品：ACS-AX5400，主打 WiFi 7 多連結操作（MLO）"
constraints:
  - "使用繁體中文"
  - "符合 ACS 品牌風格指南"
  - "圖片尺寸：Instagram 1:1 + 小紅書封面"
expected_output: "文案（content-writer）+ 視覺素材清單（art-expert）+ 影片腳本（video-director）"
assigned_agent: "orchestrator"
priority: "high"
parallel_agents: "art-expert, content-writer, video-director"
```
