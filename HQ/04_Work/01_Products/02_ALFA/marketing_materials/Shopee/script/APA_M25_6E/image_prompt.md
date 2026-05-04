# ALFA APA-M25-6E Shopee Image Prompts

## Global generation rules
- Product: **ALFA APA-M25-6E**
- Output size: **800x800**
- Language in image: **繁體中文**
- Visual direction: **dark cyberpunk neon / hacker-interface style / high contrast / professional ecommerce**
- Must use reference image:  
  `/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png`
- Keep the product exactly as the reference image: **flat rectangular matte black indoor panel antenna, white "ALFA NETWORK" logo, bottom short stem connector structure, RP-SMA male connector, no redesign, no extra antenna parts, no color change, no shape change**
- Use the same product angle, proportions, logo position, connector shape, and matte black surface consistently across all images
- Stable session placeholder: `--sessionID alfa-apa-m25-6e`

## Notes
- This product is an **indoor tri-band directional antenna**, not a Wi-Fi adapter.
- Do not generate USB plugs, router bodies, extra antennas, screens, or fake ports on the product itself.
- Main value points should stay aligned with the spec:
  - **Tri-band**: 2.4GHz / 5GHz / 6GHz
  - **Gain**: 8 dBi / 10 dBi / 9 dBi
  - **Beamwidth**: Horizontal 60° / Vertical 40°
  - **Connector**: RP-SMA Plug (male)
  - **Use case**: indoor directional deployment, WiFi 6E adapter upgrade, professional testing and coverage optimization

---

## 圖01 — 賣場封面 / 主視覺
**Suggested command style:** `baoyu-cover-image --palette dark --rendering digital --mood bold --aspect 1:1`

**Prompt**
```text
Create a premium Shopee cover image for ALFA APA-M25-6E, square 800x800, Traditional Chinese, dark digital cyberpunk-neon style, clean ecommerce hero composition.
Use the reference product image and keep the product exactly unchanged: flat rectangular matte black panel antenna, white ALFA NETWORK logo, bottom short stem connector structure, RP-SMA male connector, no redesign, no added parts, no color changes, no shape changes.
Show one large centered product with subtle electric blue and purple neon glow, dark hacker-interface background, layered UI panels, high contrast lighting, sharp product edges, realistic material texture.
Headline text in Traditional Chinese:
「ALFA APA-M25-6E」
Subheadline:
「WiFi 6E 三頻室內定向天線」
Support text:
「2.4 / 5 / 6 GHz・8 / 10 / 9 dBi・RP-SMA 公頭」
Add small feature chips:
「三頻支援」 「定向增益」 「6GHz 對應」
Visual tone: aggressive, precise, engineering-grade, premium Taiwan ecommerce style.
Avoid clutter, avoid fake interface ports, avoid product redesign.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```

---

## 圖02 — 產品概念圖 / 核心定位
**Suggested command style:** `baoyu-cover-image --palette dark --rendering digital --mood bold --aspect 1:1`

**Prompt**
```text
Create a conceptual dark-tech cover image for ALFA APA-M25-6E, square 800x800, Traditional Chinese.
Use the reference product image exactly without changing its shape, logo, connector, color, or proportions.
Place the product in the center with neon technical annotation lines and concise callout labels pointing to the product.
Callout labels in Traditional Chinese:
「室內定向面板設計」
「RP-SMA 公頭」
「支援 2.4GHz / 5GHz / 6GHz」
「5GHz 10 dBi 高增益」
「6GHz 9 dBi 對應 WiFi 6E」
Background: dark black and navy cyber interface, grid overlays, scanning lines, subtle blueprint measurements, strong contrast and premium visual hierarchy.
Main title:
「APA-M25-6E 產品概念圖」
Subtitle:
「三頻高增益室內定向天線」
Do not invent exploded structures or internal parts. Keep it realistic, premium, and product-centric.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```

---

## 圖03 — 六大核心特色放射圖
**Suggested command style:** `baoyu-infographic --style cyberpunk-neon --aspect 1:1`

**Prompt**
```text
Create a square 800x800 hub-spoke infographic in Traditional Chinese for ALFA APA-M25-6E.
Use the unchanged reference product image in the center.
Center title:
「APA-M25-6E 六大核心特色」
Build six radial feature nodes around the product with short, clear labels and clean tech icons.
Feature nodes:
1. 「三頻支援」 - 2.4GHz / 5GHz / 6GHz
2. 「WiFi 6E 對應」 - 支援新世代 6GHz 頻段
3. 「高增益」 - 8 / 10 / 9 dBi
4. 「定向收發」 - 訊號更集中
5. 「RP-SMA 公頭」 - 相容多款設備
6. 「室內省空間」 - 167.3 × 66 × 18 mm
Style: dark cyberpunk neon UI, glowing cyan and purple panels, premium infographic hierarchy, sharp readable Traditional Chinese typography.
Keep the product visually dominant, realistic, and unchanged.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```

---

## 圖04 — 完整規格圖卡
**Suggested command style:** `baoyu-infographic --style "Engineering Blueprint Navy" --layout clean-spec-sheet --lang zhtw`

**Prompt**
```text
Create a square 800x800 clean specification sheet infographic in Traditional Chinese for ALFA APA-M25-6E.
Use Engineering Blueprint Navy style with a strict clean-spec-sheet layout.
Use a small unchanged reference product image only as a secondary visual in the lower-right corner, occupying about 20 percent of the canvas.
Title:
「APA-M25-6E 完整規格」
Use a strict 2-column grid with exactly 8 spec rows.
Each row must contain only one label on the left and one value on the right.
Do not merge two specs into one row. Do not split one spec across multiple cards.
Required rows in Traditional Chinese:
1. 「產品類型」 | 「室內定向面板天線」
2. 「支援頻段」 | 「2.4 ~ 2.5 GHz / 5.150 ~ 5.875 GHz / 5.975 ~ 7.125 GHz」
3. 「天線增益」 | 「2.4GHz 8 dBi / 5GHz 10 dBi / 6GHz 9 dBi」
4. 「極化方式」 | 「Linear, Vertical」
5. 「VSWR」 | 「≤ 2.5」
6. 「垂直波束角」 | 「40°」
7. 「水平波束角」 | 「60°」
8. 「接頭 / 尺寸」 | 「RP-SMA Plug（公頭） / 167.3 × 66 × 18 mm」
Visual rules: dark navy blueprint background, thin cyan blueprint lines, minimal decoration, no icons, no floating cards, no particle effects, no glowing glass panels, no extra callout boxes.
Typography must be highly legible, with strong spacing, aligned rows, and table-first hierarchy.
Keep large empty margins around the table so the layout feels clean and not crowded.
Do not add unsupported specs like USB interface, OS support, router speed, or any duplicated values.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```

---

## 圖05 — 增益 × 指向性儀表板
**Suggested command style:** `baoyu-infographic --style cyberpunk-neon --aspect 1:1`

**Prompt**
```text
Create a square 800x800 dashboard-style infographic in Traditional Chinese for ALFA APA-M25-6E, focused on antenna performance instead of internet speed.
Use the unchanged reference product image as the hero object.
Title:
「APA-M25-6E 指向效能儀表板」
Create dashboard modules with strong visual hierarchy for:
- 「2.4GHz 增益」：8 dBi
- 「5GHz 增益」：10 dBi
- 「6GHz 增益」：9 dBi
- 「垂直波束角」：40°
- 「水平波束角」：60°
- 「使用定位」：室內定向收發
Add visual cues such as radar sweep, directional beam arcs, signal concentration graphics, and technical gauges, but keep the product itself unchanged and realistic.
Style: futuristic but credible, dark hacker dashboard, cyan and magenta highlights, premium ecommerce visual system.
Do not show Mbps numbers, router speed claims, or wireless adapter UI screens.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```

---

## 圖06 — 相容設備 × 接頭說明
**Suggested command style:** `baoyu-infographic --style cyberpunk-neon --aspect 1:1`

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
- 「WiFi 6E 網卡升級」
- 「室內定向部署」
- 「即接即用天線替換」
Add one highlighted note:
「本體接頭：RP-SMA 公頭」
Design language: dark cyberpunk neon, glowing connector lines, clean cards, strong readability, shopping-platform friendly.
Do not mention Windows, macOS, Linux, USB-A, or USB-C as main selling points in this image, because the product itself is an antenna.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```

---

## 圖07 — 適用客群 × 應用場景
**Suggested command style:** `baoyu-infographic --style cyberpunk-neon --aspect 1:1`

**Prompt**
```text
Create a square 800x800 bento-grid style infographic in Traditional Chinese for ALFA APA-M25-6E.
Use the unchanged reference product image as the key visual in one featured panel.
Title:
「適用客群 × 應用場景」
Create clear bento panels for these audience and use-case combinations:
- 「網路工程師」：定向測試與訊號優化
- 「企業辦公」：固定區域訊號集中覆蓋
- 「WiFi 6E 升級」：搭配 ALFA 網卡補齊 6GHz 收發
- 「測試環境」：精準調整天線方向與角度
- 「桌面 / 窗邊部署」：省空間、好擺放
- 「重視穩定連線者」：減少訊號分散、提升指定區域表現
Visual tone: premium, precise, dark high-tech, cyberpunk-neon ecommerce infographic.
Use subtle icons for network tools, office, target beam direction, and indoor deployment.
Do not turn this into a lifestyle photo collage; keep it product-marketing focused.
Use --sessionID alfa-apa-m25-6e and --reference-image "/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image/ALFA APA M25 6E.png"
```
