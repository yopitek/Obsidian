# ALFA APA-M25-6E Shopee Image Prompts v2

## Global generation rules
- Product: **ALFA APA-M25-6E**
- Output size: **800x800**
- Language in image: **繁體中文**
- Style direction: **technology / dark tech glassmorphism / engineering blueprint navy / cyberpunk neon**
- Must use reference image:  
  `/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png`
- Keep the product exactly as the reference image: **flat rectangular matte black indoor panel antenna, white "ALFA NETWORK" logo, bottom short stem connector structure, RP-SMA male connector, no redesign, no extra antenna parts, no color change, no shape change**
- Use the same product angle, proportions, surface texture, logo position, and connector details across all images
- Stable session placeholder: `--sessionID alfa-apa-m25-6e`

## Notes
- The request template contains legacy text like **ALFA APA M06**, **速率儀表板**, and **Support OS version**.  
  This file has been corrected to match the real product: **APA-M25-6E tri-band directional antenna**.
- This product is an **antenna**, not a Wi-Fi adapter.
- Therefore:
  - 圖05 uses **天線效能 / 增益 / 波束角** instead of network speed
  - 圖06 uses **相容設備 / 接頭說明** instead of OS support

---

## 圖01 — 賣場封面 - 產品標題
**Suggested command style:** `baoyu-cover-image --style "Dark Tech Glassmorphism" --layout structural-breakdown --aspect 1:1 --lang zhtw`

**Prompt**
```text
Create a premium Shopee cover image for ALFA APA-M25-6E, square 800x800, Traditional Chinese, technology style, Dark Tech Glassmorphism, structural-breakdown layout.
Use the reference product image and keep the product exactly unchanged: flat rectangular matte black indoor panel antenna, white ALFA NETWORK logo, bottom short stem connector structure, RP-SMA male connector, no redesign, no extra parts, no color change, no shape change.
Show one large hero product in the center with structural breakdown style UI framing, subtle glass panels, dark navy and black background, cyan neon accents, sharp engineering lighting, realistic product texture.
Headline text:
「ALFA APA-M25-6E」
Subheadline:
「WiFi 6E 三頻室內定向天線」
Support text:
「2.4 / 5 / 6 GHz・8 / 10 / 9 dBi・RP-SMA 公頭」
Feature chips:
「三頻支援」 「定向收發」 「6GHz 對應」
Visual tone: professional, aggressive, high-tech, premium Taiwan ecommerce.
Do not invent ports, cables, antennas, or product redesign.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```

---

## 圖02 — Product Conceptual Map
**Suggested command style:** `baoyu-cover-image --style "Engineering Blueprint Navy" --type conceptual --text title-subtitle --mood bold --font clean --aspect 1:1 --lang zhtw`

**Prompt**
```text
Create a conceptual blueprint-style marketing image for ALFA APA-M25-6E, square 800x800, Traditional Chinese.
Use the reference product image exactly without changing its shape, connector, logo, color, or proportions.
Place the product in the center with engineering blueprint annotation lines pointing to key product areas.
Callout labels in Traditional Chinese:
「定向面板設計」
「RP-SMA 公頭」
「支援 2.4GHz / 5GHz / 6GHz」
「5GHz 高增益 10 dBi」
「6GHz 高增益 9 dBi」
Background: dark navy blueprint grid, subtle UI lines, technical measurement overlays, precise and high-end.
Main title:
「APA-M25-6E 產品概念圖」
Subtitle:
「三頻高增益室內定向天線」
Do not invent exploded parts or internal structures. Keep it conceptual but realistic.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```

---

## 圖03 — 六大核心特色放射圖
**Suggested command style:** `baoyu-infographic --style "Dark Tech Glassmorphism" --layout hub-spoke --lang zhtw`

**Prompt**
```text
Create a square 800x800 hub-spoke infographic in Traditional Chinese for ALFA APA-M25-6E.
Use the unchanged reference product image in the center.
Center title:
「APA-M25-6E 六大核心特色」
Build six radial feature nodes around the product with short, clear labels and matching icons.
Feature nodes:
1. 「三頻支援」 - 2.4GHz / 5GHz / 6GHz
2. 「WiFi 6E 對應」 - 新世代 6GHz 頻段
3. 「高增益」 - 8 / 10 / 9 dBi
4. 「定向收發」 - 訊號更集中
5. 「RP-SMA 公頭」 - 相容多款設備
6. 「室內省空間」 - 167.3 × 66 × 18 mm
Style: Dark Tech Glassmorphism, dark UI panels, cyan neon highlights, premium infographic hierarchy, strong readability.
Keep the product visually dominant and realistic.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```

---

## 圖04 — 完整規格對照表
**Suggested command style:** `baoyu-infographic --style "Engineering Blueprint Navy" --layout clean-spec-sheet --lang zhtw`

**Prompt**
```text
Create a square 800x800 clean specification sheet infographic in Traditional Chinese for ALFA APA-M25-6E.
Use Engineering Blueprint Navy style with a clean-spec-sheet layout.
Use a small unchanged reference product image only as a secondary visual in the lower-right corner, occupying about 20 percent of the canvas.
Title:
「APA-M25-6E 完整規格」
Use a strict 2-column grid with exactly 8 spec rows.
Each row must contain only one label on the left and one value on the right.
Do not merge multiple specs into one row unless explicitly written below.
Required rows in Traditional Chinese:
1. 「產品類型」 | 「室內定向面板天線」
2. 「支援頻段」 | 「2.4 ~ 2.5 GHz / 5.150 ~ 5.875 GHz / 5.975 ~ 7.125 GHz」
3. 「增益」 | 「2.4GHz 8 dBi / 5GHz 10 dBi / 6GHz 9 dBi」
4. 「極化方式」 | 「Linear, Vertical」
5. 「VSWR」 | 「≤ 2.5」
6. 「垂直波束角」 | 「40°」
7. 「水平波束角」 | 「60°」
8. 「接頭 / 尺寸」 | 「RP-SMA Plug（公頭） / 167.3 × 66 × 18 mm」
Visual rules: dark navy blueprint background, thin cyan linework, minimal decoration, no icons, no floating glass cards, no particle effects, no extra feature badges.
Typography must prioritize readability, row alignment, and generous spacing.
Keep the specification table as the dominant element, with the product render only as a supporting corner visual.
Do not add unsupported specs like USB, OS support, throughput speed, or duplicated values.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```

---

## 圖05 — 天線效能儀表板
**Suggested command style:** `baoyu-infographic --style "Dark Tech Glassmorphism" --layout dashboard --lang zhtw`

**Prompt**
```text
Create a square 800x800 dashboard infographic in Traditional Chinese for ALFA APA-M25-6E, focused on antenna performance instead of network speed.
Use the unchanged reference product image as the hero object.
Title:
「APA-M25-6E 天線效能儀表板」
Create dashboard modules for:
- 「2.4GHz 增益」：8 dBi
- 「5GHz 增益」：10 dBi
- 「6GHz 增益」：9 dBi
- 「垂直波束角」：40°
- 「水平波束角」：60°
- 「使用定位」：室內定向收發
Add visual cues like radar sweep, directional beam arcs, signal concentration graphics, and technical gauges.
Style: Dark Tech Glassmorphism, deep navy background, cyan and magenta data highlights, futuristic but credible.
Do not show Mbps, internet speed claims, routers, or adapter UI screens.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```

---

## 圖06 — 相容設備 × 接頭說明
**Suggested command style:** `baoyu-infographic --style "Dark Tech Glassmorphism" --layout hub-spoke --lang zhtw`

**Prompt**
```text
Create a square 800x800 compatibility infographic in Traditional Chinese for ALFA APA-M25-6E.
Use the unchanged reference product image in the center.
Title:
「相容設備與接頭說明」
Build a hub-spoke layout showing the center product and surrounding compatibility nodes.
Compatibility nodes:
- 「AWUS036AXML」
- 「AWUS036AXM」
- 「RP-SMA 母座設備」
- 「WiFi 6E 網卡搭配」
- 「天線即接升級」
- 「室內定向部署」
Add one highlighted note:
「本體接頭：RP-SMA 公頭」
Style: Dark Tech Glassmorphism, clean cards, bright cyan connector lines, premium visual clarity.
Do not mention Windows, macOS, Linux, or OS support in this image, because this product is an antenna.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```

---

## 圖07 — 適用客群 × 應用場景
**Suggested command style:** `baoyu-infographic --style "Dark Tech Glassmorphism" --layout bento-grid --lang zhtw`

**Prompt**
```text
Create a square 800x800 bento-grid style infographic in Traditional Chinese for ALFA APA-M25-6E.
Use the unchanged reference product image as the key visual in one featured panel.
Title:
「適用客群 × 應用場景」
Create clean bento panels for these audience and use-case combinations:
- 「網路工程師」：定向測試與訊號優化
- 「企業辦公」：固定方向訊號強化
- 「WiFi 6E 升級」：搭配 ALFA 網卡補齊 6GHz
- 「測試環境」：精準調整收發方向
- 「桌面 / 窗邊部署」：省空間、好擺放
- 「重視穩定連線者」：訊號集中、不易分散
Visual tone: premium, precise, high-tech Taiwan ecommerce infographic.
Use subtle icons for office, network tools, target beam direction, and indoor deployment.
Do not turn this into a lifestyle photo collage; keep it product-marketing focused.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```
