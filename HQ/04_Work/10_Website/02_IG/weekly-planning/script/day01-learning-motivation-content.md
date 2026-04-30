# 🎯 Day 1: 學習動機與目標設定

## 知識卡片內容 (4 張)

### 卡片 1: 封面
**標題**: 學習動機與目標設定  
**副標題**: 找到你的學習意義  
**設計風格**: bold, professional, deep navy background  
**圖片提示**:
```
封面圖：學習動機與目標設定 - 專業科技風格，深色背景 #050B18，青色強調色 #00D4FF，大標題「學習動機與目標設定」，副標題「找到你的學習意義」，激勵性圖標，漸層效果，16:9 比例
```

---

### 卡片 2: 內在動機 vs 外在動機
**標題**: 兩種動機類型  
**內容**:
```
內在動機 (Intrinsic Motivation)
• 源自內心渴望
• 自我實現、成長
• 持久、穩定
• 例子：好奇心、興趣、成就感

外在動機 (Extrinsic Motivation)
• 來自外部獎勵
• 金錢、讚美、認可
• 暫時、不穩定
• 例子：獎金、考試成績、他人期待
```
**設計風格**: minimal, infographic, two-column comparison  
**圖片提示**:
```
知識卡片：內在動機 vs 外在動機 - 左右兩欄對比圖，左側內在動機（箭頭指向內部，綠色），右側外在動機（箭頭指向外部，藍色），專業教育風格，深藍背景 #050B18，青色標記 #00D4FF，16:9 比例
```

---

### 卡片 3: SMART 目標設定法
**標題**: SMART 目標設定法  
**內容**:
```
S - Specific (具體)
• 明確、清晰的目标
• 避免模糊描述

M - Measurable (可衡量)
• 有明確的數據指標
• 可以追蹤進度

A - Achievable (可達成)
• 現實可行
• 有挑戰性但可達

R - Relevant (相關性)
• 與大目標相關
• 有意義的行動

T - Time-bound (有時限)
• 設定明確截止日期
• 建立時間壓力
```
**設計風格**: clean, structured, five-element layout  
**圖片提示**:
```
知識卡片：SMART 目標設定法 - 五個元素垂直排列，S/M/A/R/T 字母突出顯示，每個元素下方有詳細說明，深藍背景 #050B18，青色標記 #00D4FF，白色文字，專業教育風格，16:9 比例
```

---

### 卡片 4: 30 天挑戰計劃
**標題**: 30 天學習挑戰  
**內容**:
```
📅 第 1-7 天：建立習慣
• 每天學習 30 分鐘
• 記錄學習日誌
• 設定明確目標

📅 第 8-14 天：加深理解
• 增加學習難度
• 應用所學知識
• 尋找實踐機會

📅 第 15-21 天：鞏固成果
• 複習重點內容
• 分享學習心得
• 建立知識體系

📅 第 22-30 天：持續優化
• 評估學習成效
• 調整學習方法
• 規劃下一階段
```
**設計風格**: action-oriented, timeline, four-quadrant  
**圖片提示**:
```
知識卡片：30 天學習挑戰 - 四階段時間軸，每個階段有明確目標和行動項目，深藍背景 #050B18，青色進度條 #00D4FF，綠色完成標記 #39FF14，白色文字，清晰排版，16:9 比例
```

---

## 🎨 整體設計規範

### 色彩方案
| 元素 | 顏色 |
|------|------|
| 背景 | #050B18 (Deep Navy) |
| 次要背景 | #0A1F3A (Dark Blue) |
| 主強調 | #00D4FF (Electric Cyan) |
| 次強調 | #39FF14 (Alien Green) |
| 文字 | #FFFFFF (White) |
| 次要文字 | #CCCCCC (Light Gray) |

### 輸出規格
- **解析度**: 1376 x 768 (16:9)
- **格式**: PNG
- **大小**: ~1-2MB per card

---

## 🚀 使用指令

### 使用 baoyu-image-cards (建議透過 Claude)

```
使用 baoyu-image-cards 技能生成學習動機知識卡片
主題：學習動機與目標設定
卡片數量：4
風格：minimal, balanced
```

### 使用 gemini-3-pro 生成圖片

```bash
# 生成封面圖
/opt/homebrew/bin/bun /Users/benny/Downloads/n8n_project/.agents/skills/baoyu-danger-gemini-web/scripts/main.ts \
  --prompt "封面圖：學習動機與目標設定 - 專業科技風格..." \
  --image 04_Work/10_Website/02_IG/image_assets/day01-learning-motivation/01-cover.png \
  --model gemini-3-pro \
  --sessionId ig-week18-day01-cover

# 生成內容卡片
/opt/homebrew/bin/bun /Users/benny/Downloads/n8n_project/.agents/skills/baoyu-danger-gemini-web/scripts/main.ts \
  --prompt "知識卡片：內在動機 vs 外在動機..." \
  --image 04_Work/10_Website/02_IG/image_assets/day01-learning-motivation/02-inner-motivation.png \
  --model gemini-3-pro \
  --sessionId ig-week18-day01-card1

/opt/homebrew/bin/bun /Users/benny/Downloads/n8n_project/.agents/skills/baoyu-danger-gemini-web/scripts/main.ts \
  --prompt "知識卡片：SMART 目標設定法..." \
  --image 04_Work/10_Website/02_IG/image_assets/day01-learning-motivation/03-smart-goals.png \
  --model gemini-3-pro \
  --sessionId ig-week18-day01-card2

/opt/homebrew/bin/bun /Users/benny/Downloads/n8n_project/.agents/skills/baoyu-danger-gemini-web/scripts/main.ts \
  --prompt "知識卡片：30 天學習挑戰..." \
  --image 04_Work/10_Website/02_IG/image_assets/day01-learning-motivation/04-30day-challenge.png \
  --model gemini-3-pro \
  --sessionId ig-week18-day01-card3
```

---

## 📋 執行檢查清單

- [ ] 內容腳本已確認
- [ ] 4 張圖片提示已寫好
- [ ] 生成目錄已創建
- [ ] 使用 gemini-3-pro 生成圖片
- [ ] 檢查圖片品質
- [ ] 記錄生成日誌
- [ ] 準備 IG 發布內容

---

*內容建立：2026-04-28*
*適用日期：週一 (Day 1)*
*卡片數量：4 張*
*風格：minimal + balanced*
