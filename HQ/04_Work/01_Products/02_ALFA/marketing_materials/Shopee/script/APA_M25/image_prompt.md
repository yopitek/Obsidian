# ALFA APA-M25 Shopee Image Prompts

## Global generation rules
- Product: **ALFA APA-M25**
- Output size: **800x800**
- Language in image: **繁體中文**
- Style direction: **technology / Dark Tech Glassmorphism / Engineering Blueprint Navy**
- Must use reference image:  
  `/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25.png`
- Keep the product exactly as the reference image: **flat rectangular matte black indoor panel antenna, white "ALFA NETWORK" logo, articulated base bracket, RP-SMA male connector, no redesign, no extra antenna parts, no color change, no shape change**
- Use the same product angle and industrial details consistently across all images
- Suggested session placeholder: `--sessionID alfa-apa-m25`

## Notes
- This product is an **indoor dual-band directional antenna**, not a Wi-Fi adapter.
- Therefore:
  - 圖05 uses **增益 / 波束 / 指向性儀表板**, not network throughput speed
  - 圖06 uses **相容設備 / 接頭說明**, not OS support

---

## 圖01 — 賣場封面 / 產品標題
**Suggested command style:** `baoyu-cover-image --style "Dark Tech Glassmorphism" --aspect 1:1 --lang zhtw`

**Prompt**
```text
Create a premium Shopee cover image for ALFA APA-M25, square 800x800, Traditional Chinese, dark tech glassmorphism style, clean ecommerce hero layout.
Use the reference product image and keep the product exactly unchanged: flat rectangular matte black panel antenna, white ALFA NETWORK logo, articulated base bracket, RP-SMA male connector, no redesign, no extra components, no color changes.
Show one large centered product render with subtle blue neon glow, layered glass panels, tech grid background, professional lighting, high contrast, sharp edges, realistic product texture.
Headline text in Traditional Chinese:
「ALFA APA-M25」
Subheadline:
「雙頻室內定向天線」
Support text:
「2.4GHz / 5GHz・8 dBi / 10 dBi・RP-SMA 公頭」
Add small feature chips:
「定向收訊」 「高增益」 「室內部署」
Visual tone: trustworthy, precise, engineering-grade, clean Taiwan ecommerce style.
Avoid clutter, avoid fake ports, avoid changing product structure.
Use --sessionID alfa-apa-m25 and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25.png"
```

---

## 圖02 — Product Conceptual Map
**Suggested command style:** `baoyu-cover-image --style "Engineering Blueprint Navy" --type conceptual --text title-subtitle --mood bold --font clean --aspect 1:1 --lang zhtw`

**Prompt**
```text
Create a conceptual blueprint-style marketing image for ALFA APA-M25, square 800x800, Traditional Chinese.
Use the reference product image exactly without changing its shape, logo, connector, bracket, color, or proportions.
Place the product in the center with engineering blueprint annotation lines pointing to key product areas.
Callout labels in Traditional Chinese:
「定向面板設計」
「RP-SMA 公頭」
「可調式底座」
「雙頻支援 2.4GHz / 5GHz」
「5GHz 高增益 10 dBi」
「垂直波束角 16°」
Background: dark navy blueprint grid, subtle UI lines, technical measurement overlays, product dimension feel, precise and high-end.
Main title:
「APA-M25 產品概念圖」
Subtitle:
「高增益雙頻室內定向天線」
Do not invent internal exploded parts. Keep it conceptual but realistic.
Use --sessionID alfa-apa-m25 and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25.png"
```

---

## 圖03 — 6大核心特色放射圖
**Suggested command style:** `baoyu-infographic --style "Dark Tech Glassmorphism" --layout hub-spoke --lang zhtw`

**Prompt**
```text
Create a square 800x800 hub-spoke infographic in Traditional Chinese for ALFA APA-M25.
Use the unchanged reference product image in the center.
Center title:
「APA-M25 六大核心特色」
Build six radial feature nodes around the product with short, clear labels and matching icons.
Feature nodes:
1. 「雙頻支援」 - 2.4GHz / 5GHz
2. 「高增益」 - 2.4GHz 8 dBi / 5GHz 10 dBi
3. 「定向收訊」 - 訊號更集中
4. 「窄垂直波束」 - 16°
5. 「RP-SMA 公頭」 - 相容多款設備
6. 「室內省空間」 - 167.3 × 66 × 18 mm
Style: dark tech glass panels, neon blue highlights, modern infographic UI, premium ecommerce visual hierarchy.
Keep the product visually dominant and realistic.
Use --sessionID alfa-apa-m25 and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25.png"
```

---

## 圖04 — 完整規格對照表
**Suggested command style:** `baoyu-infographic --style "Dark Tech Glassmorphism" --layout dense-modules --lang zhtw`

**Prompt**
```text
Create a square 800x800 dense-module specification infographic in Traditional Chinese for ALFA APA-M25.
Use a smaller unchanged reference product image as the main product visual, placed on one side, with spec modules arranged cleanly around it.
Title:
「APA-M25 完整規格」
Spec blocks in Traditional Chinese:
- 「產品類型」：室內定向面板天線
- 「支援頻段」：2.4 ~ 2.5 GHz / 5.150 ~ 5.875 GHz
- 「增益」：2.4GHz 8 dBi / 5GHz 10 dBi
- 「極化方式」：Linear, Vertical
- 「VSWR」：2.0:1 Max
- 「垂直波束角」：16°
- 「水平波束角」：66°
- 「接頭」：RP-SMA Plug（公頭）
- 「尺寸」：167.3 × 66 × 18 mm
Style: premium dark tech infographic, glass cards, thin cyan lines, legible typography, shopping-platform friendly.
Do not add unsupported specs like Wi-Fi 6E, USB, or operating system support.
Use --sessionID alfa-apa-m25 and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25.png"
```

---

## 圖05 — 增益 × 指向性儀表板
**Suggested command style:** `baoyu-infographic --style "Dark Tech Glassmorphism" --layout dashboard --lang zhtw`

**Prompt**
```text
Create a square 800x800 dashboard-style infographic in Traditional Chinese for ALFA APA-M25, focused on antenna performance rather than internet speed.
Use the unchanged reference product image as the hero object.
Title:
「APA-M25 指向效能儀表板」
Create dashboard modules with strong visual hierarchy for:
- 「2.4GHz 增益」：8 dBi
- 「5GHz 增益」：10 dBi
- 「垂直波束角」：16°
- 「水平波束角」：66°
- 「雙頻支援」：2.4GHz / 5GHz
- 「使用定位」：室內定向收訊
Add visual cues like radar sweep, directional beam arcs, signal concentration graphics, but keep the product itself unchanged and realistic.
Style: futuristic but credible, glass dashboard panels, deep navy background, cyan and white data highlights.
Do not show Mbps numbers or router speed claims.
Use --sessionID alfa-apa-m25 and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25.png"
```

---

## 圖06 — 相容設備 × 接頭說明
**Suggested command style:** `baoyu-infographic --style "Dark Tech Glassmorphism" --layout hub-spoke --lang zhtw`

**Prompt**
```text
Create a square 800x800 compatibility infographic in Traditional Chinese for ALFA APA-M25.
Use the unchanged reference product image in the center.
Title:
「相容設備與接頭說明」
Build hub-spoke layout showing the center product and surrounding compatibility nodes.
Compatibility nodes:
- 「AWUS036ACS」
- 「AWUS036ACM」
- 「AWUS036ACH」
- 「AWUS036AXM」
- 「RP-SMA 母座設備」
- 「即接即用天線升級」
Add one highlighted note:
「本體接頭：RP-SMA 公頭」
Design language: dark tech, clean glassmorphism cards, bright cyan connector lines, ecommerce-friendly visual clarity.
Do not mention Windows, macOS, Linux, or USB interface support for this image, because the product is an antenna.
Use --sessionID alfa-apa-m25 and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25.png"
```

---

## 圖07 — 適用客群 × 應用場景
**Suggested command style:** `baoyu-infographic --style "Dark Tech Glassmorphism" --layout bento-grid --lang zhtw`

**Prompt**
```text
Create a square 800x800 bento-grid style infographic in Traditional Chinese for ALFA APA-M25.
Use the unchanged reference product image as the key visual in one featured panel.
Title:
「適用客群 × 應用場景」
Create clean bento panels for these audience and use-case combinations:
- 「網路工程師」：定向測試與訊號優化
- 「企業辦公」：固定方向收訊強化
- 「居家工作」：改善室內指定區域 WiFi 訊號
- 「設備升級」：搭配 ALFA 網卡提升收訊表現
- 「窗邊 / 桌面部署」：省空間、好擺放
- 「重視穩定連線者」：訊號集中、不易分散
Visual tone: premium, precise, clean, high-tech Taiwan ecommerce infographic.
Use subtle icons for office, home desk, network tools, and signal direction.
Do not turn this into a lifestyle photo collage; keep it product-marketing focused.
Use --sessionID alfa-apa-m25 and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25.png"
```
