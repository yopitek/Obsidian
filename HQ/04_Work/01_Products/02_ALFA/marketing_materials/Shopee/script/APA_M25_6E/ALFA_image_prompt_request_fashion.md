I need to generate 7 pictures image prompt, and I will use Gemini to generate the images manually.

Please generate image prompt to:
/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/marketing_materials/Shopee/script/APA_M25_6E/image_prompt_fashion.md

Model: ALFA APA-M25-6E
/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/marketing_materials/Shopee/script/APA_M25_6E/shopee_script.md

Generation guideline:
1. image spec: 800x800 pixel, Language: 繁體中文
2. use original product image to generate the marketing image.
Need to confirm the product design shape, antenna, interface and color etc.
Don't make any change and revision for the product design and shape.
3. Use --sessionID and --reference-image parameters to make the product quality stable.
Stable session placeholder defined as:
  `--sessionID alfa-apa-m25-6e-fashion`

You can generate the image by revising this prompt:
/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/marketing_materials/Shopee/script/APA_M25_6E/image_prompt.md

product image:
/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image
Product spec:
/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Spec

use skill: /baoyu-skills
https://github.com/JimLiu/baoyu-skills.git

Visual direction:
- quiet luxury
- high-fashion editorial
- premium product catalog
- minimalist studio photography
- warm neutral palette
- refined typography

視覺一致性：從封面到規格表，全部採用高級時尚型錄風格，像精品型錄與高端品牌 campaign product sheet 的質感；重點是留白、材質感、柔和棚燈、沉穩配色與精準排版，不要霓虹、不走電競、不走駭客介面感。

Style notes:
- use calm premium mood instead of aggressive tech mood
- avoid copying any specific luxury brand logo or brand identity
- pursue editorial luxury feeling, not cyberpunk or gadget UI feeling
- keep product real, minimal, and premium

Recommended style:
style: quiet luxury / editorial / minimalist premium

圖01 — 賣場封面 - 產品標題
baoyu-cover-image --style "Minimal Editorial Luxury" --aspect 1:1 --lang zhtw

圖02 — product conceptual map
baoyu-cover-image --style "Quiet Luxury Product Catalog" --type conceptual --text title-subtitle --mood calm --font elegant --aspect 1:1 --lang zhtw

圖03 — 6大核心特色放射圖
Layout: `hub-spoke` | Style: `Minimal Editorial Luxury`
/baoyu-infographic --style "Minimal Editorial Luxury" --layout hub-spoke --lang zhtw

圖04 — 完整規格對照表
Layout: `clean-spec-sheet` | Style: `Editorial Spec Sheet`
/baoyu-infographic --style "Editorial Spec Sheet" --layout clean-spec-sheet --lang zhtw

圖05 — 天線效能儀表板
Layout: `dashboard` | Style: `Soft Studio Minimal`
/baoyu-infographic --style "Soft Studio Minimal" --layout dashboard --lang zhtw

圖06 — 相容設備 × 接頭說明
Layout: `hub-spoke` | Style: `Minimal Editorial Luxury`
/baoyu-infographic --style "Minimal Editorial Luxury" --layout hub-spoke --lang zhtw

圖07 — 適用客群 × 應用場景
Layout: `bento-grid` | Style: `Quiet Luxury Catalog`
/baoyu-infographic --style "Quiet Luxury Catalog" --layout bento-grid --lang zhtw
