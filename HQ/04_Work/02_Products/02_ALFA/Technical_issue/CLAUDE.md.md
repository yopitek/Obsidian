**科技產品說明文件規範（FT Style + Markdown → PDF）**

---

## 0. 文件定位（Document Positioning）

本規範適用於：

- 技術產品說明書（User Manual）
- 驅動 / 安裝指南（Setup Guide）
- 偵錯文件（Troubleshooting Guide，如 Wireshark 範例）

文件風格參考：  
**Financial Times editorial style（冷靜、結構化、資訊優先）**

---

## 1. 語言與寫作風格

### 1.1 語言規範

- 預設語言：繁體中文（zh-TW）
- 技術詞彙：保留英文（例如：`monitor mode`, `firmware`, `driver`）
- 禁止：
    - 行銷語氣（例如：強大、極致、革命性）
    - 模糊描述（例如：可能、大概）

---

### 1.2 FT 風格語氣（強制）

|項目|規範|
|---|---|
|語氣|客觀、分析式|
|句型|短句、資訊密集|
|結構|分段清晰（Step-based）|
|用詞|精確（避免口語）|

#### 範例（來自你文件的優化方向）

❌ 不建議：

```
這個步驟很重要，一定要做
```

✅ 建議：

```
此步驟為必要條件，未啟用 monitor mode 將導致封包數量不足。
```

---

## 2. 文件結構（強制模板）

依據你提供的 Wireshark 文件，統一為：

```
# 文件標題**環境：OS | Kernel | Device**---## 概述（Overview）說明問題背景與適用情境---## Step 1：XXX說明 + 指令---## Step N：XXX...---## 問題對照表（Troubleshooting Matrix）| 症狀 | 原因 | 解法 |---## 偵錯資訊收集（Debug Info）提供標準輸出指令
```

---

## 3. 程式碼區塊規範（重要）

### 3.1 必須使用 fenced code block

```
iw dev
```

---

### 3.2 指令區塊規則

|項目|規範|
|---|---|
|語言標記|必須（bash / json / yaml）|
|可執行性|必須可直接 copy|
|變數|使用大寫（IFACE, CHANNEL）|

---

### 3.3 範例（來自你的文件標準化）

```
IFACE=wlan0CHANNEL=6sudo ip link set $IFACE downsudo iw dev $IFACE set type monitorsudo ip link set $IFACE upsudo iw dev $IFACE set channel $CHANNEL
```

---

## 4. 圖片與視覺規範（FT Style）

![https://images.openai.com/static-rsc-4/laEds_OfXeilDXVJlyUBFNvp97fqneutZSiIcqnSQjmYjI29FCcJxjz6Pd0z4lYflNP42PFk0nOjBDgCulGKj7PuBRbmO0gfZ9ybK3VndRa8-i8ctxSRiZjcJnIn-J6rz0TchtyiVYKZriykC160ayZHczGUpO81IOygwcN1nvMmd_n8tFAuFN7q9ydWdYBY?purpose=fullsize](https://images.openai.com/static-rsc-4/OLFCT5sBmtASuGo9drtvC-Z9QIhOJhADyp6DzuzG85ahNxyFB5v0ckVWCvunAdrHWFUGlRYC-IrNJjvGGD0SQ_x_u-1_hmiUZiWrYLeky_y2oz6f1qzcqN_vJY4bowWrS8HrUfgH1h_7nYMBayfxos40zPU4QbiO4XmQDgxLEWw?purpose=inline)

![https://images.openai.com/static-rsc-4/8eHQpnkBlzXaFoc8boeFHW0b6kvZTcHx-boGfoikqTcirSuoa2OTJ6DyTunh3XInOem7bETx1nirhx617KCjAIVMxX8tAfdzIMhlMkCKiTQyDD9XyT3aidwkmv6NSbU9b8Ps0zRvvoaRcFX7rgTAr2LuMK_aFv_7waA7EEZpV8_W1cH4dRkp3Cb4bhkpjHq9?purpose=fullsize](https://images.openai.com/static-rsc-4/UNv3psZBfm3Z5jDXd3KsRDzH-rxscfJTEja08HF7tvHyMS3QqRhs6MXV3CD-4DKG9LfnM2h2wmrgA46Q4xhPNwIXIAm7JY2vOPZngi-NqMRRZ2DQ6an-idQZBzCV8NXnQt0IGmaDhwk4dVLEw7glTl3sHffq3meGmQV55SuRbb0?purpose=inline)

![https://images.openai.com/static-rsc-4/6_23CrGS7I85Gx5HLEtpzHoe64KwxpthVrCnGrA3GX3R_Ilq3AHNXYrNIU0sc8Q0IPLtKIuyOX632dzmm7WdOEY6TYqJ7tBocrRGzj56gUlsTzRFgJmnDkPpPMOQKAeUtBMfAplaiTSX1-wNgr3Xrweqpz0L4R5pEfU9mjP84Y3jgvnj6N1WJ6kG6RBSsEIN?purpose=fullsize](https://images.openai.com/static-rsc-4/hgeuOX4WOYQQKSnPmHoyEajJXhm-TitMM7mypbW8p78Va16j6-SD1pjvpv3BWTnoG0MSKgMdeA4erkePYRCFpLaFCOckMfXwRzTycwuLgbc5exmM7UHX_vgQhLNKAHkapyYcWkNUzMjHbQJHrbl9Oe4BRsG_dh-wbMtOHnu6W1I?purpose=inline)

6

### 4.1 圖片使用原則

- 僅使用「有資訊價值」的圖片
- 避免裝飾性圖片
- 必須有 caption

```
![Wireshark Monitor Mode 設定畫面](fig-01-monitor-mode.png)
```

---

## 5. 字體規範（Google Open Source）

### 5.1 中文

- Noto Sans TC（內文）
- Noto Serif TC（標題）

---

### 5.2 英文

- Roboto（技術內容）
- Source Serif 4（標題）

---

## 6. Markdown → PDF 轉換規範（核心）

### 6.1 標準工具鏈

- Pandoc（強制）
- 搭配：huasheng_editor

---

### 6.2 標準轉換指令

```
pandoc input.md \  -o output.pdf \  --pdf-engine=xelatex \  -V mainfont="Noto Sans TC" \  -V CJKmainfont="Noto Sans TC" \  -V sansfont="Roboto" \  -V geometry:margin=2cm \  -V fontsize=11pt \  -V linestretch=1.5
```

---

### 6.3 PDF 排版規範

|項目|規格|
|---|---|
|紙張|A4|
|邊距|2 cm|
|行距|1.5|
|標題層級|清楚（H1/H2/H3）|

---

## 7. 技術內容撰寫規範（重點）

### 7.1 Step-based 結構（必須）

你的文件已經做對了，強制沿用：

```
## 🔍 Step 3：設定 Monitor Mode（最關鍵）
```

---

### 7.2 每個 Step 必須包含

- 目的說明
- 指令
- 驗證方式

---

### 7.3 範例（從你的文件抽象化）

```
## Step 3：設定 Monitor Mode目的：啟用封包攔截能力操作：```bashsudo iw dev wlan0 set type monitor
```

驗證：

```
iw dev | grep type
```

```
---## 8. Troubleshooting Table（標準化）你原本這段很好，直接升級為標準：```markdown| 症狀 | 原因 | 解法 ||------|------|------|| 只有 Beacon frame | 未啟用 monitor mode | Step 3 |
```

---

## 9. 檔案命名規範

```
productname_feature_manual_v1.0.mdproductname_feature_manual_v1.0.pdf
```

範例：

```
awus036axml_wireshark_debug_v1.0.md
```

---

## 10. Git Workflow

套用 repo：  
huasheng_editor

### 分支

```
maindevfeature/wireshark-guide
```

---

### Commit 規範

```
docs: add monitor mode sectionfix: correct mt7921 firmware pathstyle: align FT formatting
```

---

## 11. CI/CD（建議但強烈推薦）

- push → 自動轉 PDF
- release → 自動產出文件包