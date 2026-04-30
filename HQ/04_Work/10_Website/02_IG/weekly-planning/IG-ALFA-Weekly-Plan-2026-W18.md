# 📱 ALFA WiFi 產品 Instagram 每週行銷規劃

> 創建日期：2026-04-28
> 產品線：ALFA Network WiFi 產品
> 使用工具：baoyu-image-cards, gemini-3-pro

---

## 🎯 活動目標

透過知識卡片系列，推廣 ALFA WiFi 產品，建立專業品牌形象，吸引網路安全專業人士與技術愛好者

---

## 🔄 工作流程

```
1. 產品特色分析 → baoyu-image-cards
   ↓
2. 知識卡片腳本
   ↓
3. 圖片提示設計
   ↓
4. Gemini-3-Pro 圖片生成
   ↓
5. 存儲到 IG folder
```

---

## 📅 每週貼文規劃 (7 天)

### 週一：ALFA AWUS036AXML 產品介紹 🎯
**主題**: WiFi 6E 三頻網卡，為駭客而生

**知識卡片內容** (4 張):
1. 產品封面 - AWUS036AXML Hero Shot
2. 核心規格 - WiFi 6E Tri-Band 3000Mbps
3. 監聽模式 - Monitor Mode & Packet Injection
4. 相容性 - Kali Linux/Ubuntu/Debian/Raspberry Pi

**參考圖片**: `/Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ/04_Work/02_Products/02_ALFA/Raw_image/AWUS036AXML.png`

---

### 週二：ALFA AWUS036AXM 行動版 🎒
**主題**: 輕巧隨身，隨時隨地高速連接

**知識卡片內容** (3 張):
1. 產品封面 - AWUS036AXM Lightweight Design
2. USB-C 3.0 高速傳輸
3. 便攜設計與多平台支援

**參考圖片**: `/Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ/04_Work/02_Products/02_ALFA/Raw_image/AWUS036AXM.png`

---

### 週三：WiFi 6E 技術解析 🔬
**主題**: 6GHz 頻段的優勢與應用

**知識卡片內容** (4 張):
1. WiFi 6E vs WiFi 6 對比
2. 6GHz 頻道優勢 (無干擾)
3. Tri-Band 三頻同時使用
4. 實測速度與延遲

---

### 週四：監聽模式與滲透測試 🛡️
**主題**: 網路安全測試的必備工具

**知識卡片內容** (4 張):
1. 監聽模式介紹
2. Packet Injection 原理
3. 適用工具 (Aircrack-ng, Kismet)
4. 實際應用場景

**目標受眾**: 網路安全專業人士、滲透測試人員

---

### 週五：Raspberry Pi 完美搭配 💪
**主題**: ALFA + Raspberry Pi 的黃金組合

**知識卡片內容** (4 張):
1. Raspberry Pi 4/5 相容性
2. 專案應用 (Pi-hole, 無線監控)
3. 安裝步驟快速指南
4. 實際案例分享

**參考圖片**: `/Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ/04_Work/02_Products/02_ALFA/Raw_image/AWUS036AXM.png`

---

### 週六：競品對比與優勢分析 ⚡
**主題**: 為何選擇 ALFA？

**知識卡片內容** (3 張):
1. ALFA vs TP-Link vs NETGEAR
2. 晶片方案優勢 (MediaTek/Realtek)
3. 價格與效能比

---

### 週日：客戶成功案例分享 ⭐
**主題**: 專業人士的一致選擇

**知識卡片內容** (3 張):
1. 網路安全專家推薦
2. 技術部落格引用
3. 社群真實評論
4. 購買建議與下一步

---

## 📂 檔案結構

```
04_Work/10_Website/02_IG/
├── alfa-products/
│   ├── weekly-planning/
│   │   ├── IG-ALFA-Weekly-Plan-2026-W18.md
│   │   └── script/
│   │       ├── day01-awus036axml-intro.md
│   │       ├── day02-awus036axm-mobile.md
│   │       ├── day03-wifi6e-tech.md
│   │       ├── day04-monitor-mode.md
│   │       ├── day05-raspberry-pi.md
│   │       ├── day06-competitive-analysis.md
│   │       └── day07-customer-success.md
│   ├── image_prompts/
│   │   ├── day01-awus036axml-intro/
│   │   ├── day02-awus036axm-mobile/
│   │   ├── day03-wifi6e-tech/
│   │   ├── day04-monitor-mode/
│   │   ├── day05-raspberry-pi/
│   │   ├── day06-competitive-analysis/
│   │   └── day07-customer-success/
│   └── image_assets/
│       ├── day01-awus036axml-intro/
│       ├── day02-awus036axm-mobile/
│       ├── day03-wifi6e-tech/
│       ├── day04-monitor-mode/
│       ├── day05-raspberry-pi/
│       ├── day06-competitive-analysis/
│       └── day07-customer-success/
└── published/
    └── 2026-04-W18/
```

---

## 🎨 ALFA 品牌設計規範

### 色彩方案
| 用途 | 顏色代碼 | 名稱 |
|------|----------|------|
| 主背景 | #000000 | Deep Black |
| 次要背景 | #1A1A1A | Dark Gray |
| 主強調 | #FF0000 | ALFA Red |
| 次強調 | #FFFFFF | White |
| 文字 | #CCCCCC | Light Gray |

### 產品特色
- **ALFA 品牌**: 紅色 + 黑色，強烈對比，極端環境風格
- **專業形象**: 技術導向，強調效能
- **目標受眾**: 技術人員、網路安全專業人士

---

## 🛠️ 執行腳本範例

### Day 1: AWUS036AXML 產品介紹

```bash
# 生成封面圖
/opt/homebrew/bin/bun /Users/benny/Downloads/n8n_project/.agents/skills/baoyu-danger-gemini-web/scripts/main.ts \
  --prompt "ALFA AWUS036AXML WiFi 6E Tri-Band USB Adapter - Hero Shot, black and red color scheme, extreme environment style, professional tech product photography, white background, high quality, 1376x768" \
  --ref /Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ/04_Work/02_Products/02_ALFA/Raw_image/AWUS036AXML.png \
  --image 04_Work/10_Website/02_IG/alfa-products/image_assets/day01-awus036axml-intro/01-cover.png \
  --model gemini-3-pro \
  --sessionId alfa-week18-day01-cover

# 生成規格卡片
/opt/homebrew/bin/bun /Users/benny/Downloads/n8n_project/.agents/skills/baoyu-danger-gemini-web/scripts/main.ts \
  --prompt "知識卡片：ALFA AWUS036AXML 核心規格，黑色背景 #000000，紅色強調 #FF0000，列出：WiFi 6E Tri-Band, 3000Mbps, USB-C 3.2, BT 5.2, MediaTek MT7921AUN, 監聽模式，Packet Injection，專業科技感" \
  --ref /Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ/04_Work/02_Products/02_ALFA/Raw_image/AWUS036AXML.png \
  --image 04_Work/10_Website/02_IG/alfa-products/image_assets/day01-awus036axml-intro/02-specs.png \
  --model gemini-3-pro \
  --sessionId alfa-week18-day01-card1
```

---

## 📊 每週執行時程

| 天數 | 產品/主題 | 卡片數 | 預計時間 | 參考圖片 |
|------|----------|--------|---------|---------|
| 週一 | AWUS036AXML | 4 張 | 10-12 分鐘 | AWUS036AXML.png |
| 週二 | AWUS036AXM | 3 張 | 8-9 分鐘 | AWUS036AXM.png |
| 週三 | WiFi 6E 技術 | 4 張 | 10-12 分鐘 | 無 |
| 週四 | 監聽模式 | 4 張 | 10-12 分鐘 | 無 |
| 週五 | Raspberry Pi | 4 張 | 10-12 分鐘 | AWUS036AXM.png |
| 週六 | 競品對比 | 3 張 | 8-9 分鐘 | 無 |
| 週日 | 成功案例 | 3 張 | 8-9 分鐘 | 無 |

**總計**: 25 張圖片
**總時間**: 約 1.5 小時

---

## ✅ 執行檢查清單

### 每日流程
- [ ] 確認參考圖片存在
- [ ] 撰寫圖片提示詞
- [ ] 使用 gemini-3-pro 生成圖片
- [ ] 檢查圖片品質
- [ ] 存檔到指定目錄
- [ ] 記錄生成日誌

### 品質標準
- ✅ 解析度：1376 x 768 (16:9)
- ✅ 格式：PNG
- ✅ 大小：1-2MB per card
- ✅ 品牌色：紅色 + 黑色
- ✅ 產品外觀準確 (使用 --ref)
- ✅ 文字清晰可讀

---

## 🚀 立即開始執行

### 第一步：確認檔案結構
```bash
mkdir -p 04_Work/10_Website/02_IG/alfa-products/{image_prompts,day01-awus036axml-intro,image_assets}
```

### 第二步：生成 Day 1 封面圖
```bash
/opt/homebrew/bin/bun /Users/benny/Downloads/n8n_project/.agents/skills/baoyu-danger-gemini-web/scripts/main.ts \
  --prompt "ALFA AWUS036AXML WiFi 6E product hero shot" \
  --ref 04_Work/02_Products/02_ALFA/Raw_image/AWUS036AXML.png \
  --image 04_Work/10_Website/02_IG/alfa-products/image_assets/day01-awus036axml-intro/01-cover.png \
  --model gemini-3-pro
```

---

*規劃完成：2026-04-28*
*適用週次：2026-W18 (4/28-5/4)*
*產品線：ALFA Network WiFi 6E/6/5G 產品*
*預計總圖片數：25 張*
