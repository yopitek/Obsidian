# 🚀 ALFA WiFi 產品 Instagram 每週行銷活動

> 創建日期：2026-04-28
> 週次：2026-W18 (4/28-5/4)
> 產品線：ALFA Network WiFi 6E/6/5G USB 網卡

---

## 📋 活動總覽

### 核心目標
透過知識卡片系列，推廣 ALFA WiFi 產品，建立專業品牌形象，吸引網路安全專業人士與技術愛好者

### 工作流程
```
產品分析 → 內容腳本 → 圖片提示 → Gemini-3-Pro 生成 → IG Folder 存檔
```

---

## 📅 一週內容規劃

### 週一：ALFA AWUS036AXML 產品介紹 🎯
**主題**: WiFi 6E 三頻網卡，為駭客而生  
**卡片數**: 4 張  
**狀態**: 🔄 生成中

| 卡片 | 主題 | 任務 ID | 狀態 |
|------|------|--------|------|
| 01-cover | 產品封面 | bdyok1zag | 🔄 生成中 |
| 02-specs | 核心規格 | b3qaby8de | 🔄 生成中 |
| 03-monitor | 監聽模式 | bgyl9myjh | 🔄 生成中 |
| 04-compat | 平台相容性 | bbvf3j4hh | 🔄 生成中 |

**參考圖片**: `04_Work/02_Products/02_ALFA/Raw_image/AWUS036AXML.png`

---

### 週二：ALFA AWUS036AXM 行動版 🎒
**主題**: 輕巧隨身，隨時隨地高速連接  
**卡片數**: 3 張  
**狀態**: 📋 已規劃

- 01-cover: 產品封面 - Lightweight Design
- 02-usb: USB-C 3.0 高速傳輸
- 03-portable: 便攜設計與多平台支援

**參考圖片**: `04_Work/02_Products/02_ALFA/Raw_image/AWUS036AXM.png`

---

### 週三：WiFi 6E 技術解析 🔬
**主題**: 6GHz 頻段的優勢與應用  
**卡片數**: 4 張

- WiFi 6E vs WiFi 6 對比
- 6GHz 頻道優勢 (無干擾)
- Tri-Band 三頻同時使用
- 實測速度與延遲

---

### 週四：監聽模式與滲透測試 🛡️
**主題**: 網路安全測試的必備工具  
**卡片數**: 4 張

- 監聽模式介紹
- Packet Injection 原理
- 適用工具 (Aircrack-ng, Kismet)
- 實際應用場景

---

### 週五：Raspberry Pi 完美搭配 💪
**主題**: ALFA + Raspberry Pi 的黃金組合  
**卡片數**: 4 張

- Raspberry Pi 4/5 相容性
- 專案應用 (Pi-hole, 無線監控)
- 安裝步驟快速指南
- 實際案例分享

---

### 週六：競品對比與優勢分析 ⚡
**主題**: 為何選擇 ALFA？  
**卡片數**: 3 張

- ALFA vs TP-Link vs NETGEAR
- 晶片方案優勢 (MediaTek/Realtek)
- 價格與效能比

---

### 週日：客戶成功案例分享 ⭐
**主題**: 專業人士的一致選擇  
**卡片數**: 3 張

- 網路安全專家推薦
- 技術部落格引用
- 社群真實評論
- 購買建議與下一步

---

## 📊 執行進度總表

| 天數 | 主題 | 卡片數 | 進度 | 參考圖片 |
|------|------|--------|------|---------|
| 週一 | AWUS036AXML | 4 張 | 🔄 生成中 | AWUS036AXML.png |
| 週二 | AWUS036AXM | 3 張 | 📋 待執行 | AWUS036AXM.png |
| 週三 | WiFi 6E 技術 | 4 張 | 📋 待執行 | - |
| 週四 | 監聽模式 | 4 張 | 📋 待執行 | - |
| 週五 | Raspberry Pi | 4 張 | 📋 待執行 | AWUS036AXM.png |
| 週六 | 競品對比 | 3 張 | 📋 待執行 | - |
| 週日 | 成功案例 | 3 張 | 📋 待執行 | - |

**總計**: 25 張圖片

---

## 🎨 ALFA 品牌設計規範

### 色彩方案
| 用途 | 顏色代碼 | 名稱 |
|------|----------|------|
| 主背景 | #000000 | Deep Black |
| 次要背景 | #1A1A1A | Dark Gray |
| 主強調 | #FF0000 | ALFA Red |
| 文字 | #FFFFFF | White |

### 設計風格
- **品牌特色**: 紅色 + 黑色強烈對比
- **產品定位**: 極端環境、專業技術
- **目標受眾**: 網路安全專業人士、技術愛好者

---

## 🛠️ 執行腳本

### 使用範例
```bash
/opt/homebrew/bin/bun /Users/benny/Downloads/n8n_project/.agents/skills/baoyu-danger-gemini-web/scripts/main.ts \
  --prompt "你的提示詞" \
  --ref /Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ/04_Work/02_Products/02_ALFA/Raw_image/AWUS036AXML.png \
  --image /Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ/04_Work/10_Website/02_IG/alfa-products/image_assets/day01-awus036axml-intro/01-cover.png \
  --model gemini-3-pro \
  --sessionId alfa-week18-day01-cover
```

### 參數說明
- `--prompt`: 圖片生成提示詞
- `--ref`: 參考產品圖片 (確保外觀準確)
- `--image`: 輸出檔案路徑
- `--model`: gemini-3-pro (高畫質)
- `--sessionId`: 保持風格一致性

---

## 📂 檔案結構

```
04_Work/10_Website/02_IG/
├── alfa-products/
│   ├── weekly-planning/
│   │   ├── IG-ALFA-Weekly-Plan-2026-W18.md ✅
│   │   └── ALFA-Day1-Generation-Log.md ✅
│   ├── script/
│   ├── image_prompts/
│   │   └── day01-awus036axml-intro/
│   ├── image_assets/
│   │   └── day01-awus036axml-intro/ 🔄 生成中
│   └── published/
└── published/
    └── 2026-04-W18/
```

---

## ✅ 當前狀態

### Day 1: AWUS036AXML 生成進度

**4 張卡片正在並行生成中**:
1. 01-cover.png (bdyok1zag) - 產品封面
2. 02-specs.png (b3qaby8de) - 核心規格
3. 03-monitor-mode.png (bgyl9myjh) - 監聽模式
4. 04-compatibility.png (bbvf3j4hh) - 平台相容性

**預計完成時間**: 約 8-12 分鐘

---

## 📊 每日時程建議

| 時段 | 任務 | 時間 |
|------|------|------|
| 週日 18:00 | 內容規劃與腳本撰寫 | 1-2 小時 |
| 週日 20:00 | 圖片提示設計 | 1 小時 |
| 週一 09:00 | 生成 Day 1 圖片 | 10-12 分鐘 |
| 週一 10:00 | 品質檢查與調整 | 15 分鐘 |
| 週一 12:00 | 發布 Day 1 貼文 | 5 分鐘 |
| 每週日 | 生成下週內容 | 1-2 小時 |

---

## 🎯 成功指標

### 內容品質
- ✅ 產品外觀準確 (使用 --ref)
- ✅ 品牌色正確 (紅 + 黑)
- ✅ 文字清晰可讀
- ✅ 專業科技感

### 執行效率
- ✅ 每張圖片 ~2-3 分鐘
- ✅ 並行生成提高效率
- ✅ 統一 sessionId 保持風格

---

*規劃完成：2026-04-28*
*當前狀態：Day 1 圖片生成中*
*產品：ALFA AWUS036AXML WiFi 6E Tri-Band*
