I need to generate 7 pictures image prompt , i will use gemini to generate the image manually. 

Pleaes generate image prompt to 
/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/marketing_materials/Shopee/script/APA_M04/image_prompt.md

Model : ALFA APA M04
/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/marketing_materials/Shopee/script/APA_M04/shopee_script.md

Generation guideline:
1.image spec : 800x800 pixel, Language : 繁體中文
2.use original product image to generate the marketing image. 
Need to confirm the product design shape, antenna , interface and color etc. 
Don't make any change and revision for the product design, shape. 
3.Use --sessionID and --reference image parameters to make the product quality stable. 

you can generate the image by revising this prompt 
/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/marketing_materials/Shopee/script/APA_M25/image_prompt.md

product image : 
/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Raw_image
Product spec : 
/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/04_Work/01_Products/02_ALFA/Spec

use skill : /baoyu-skills
https://github.com/JimLiu/baoyu-skills.git

style: technology 

圖01 — 賣場封面 - 產品標題
baoyu-cover-image --style Dark Tech Glassmorphism Layout: structural-breakdown --aspect 1:1 --lang zhtw

圖02 — prdouct conceptual map
baoyu-cover-image --style Engineering Blueprint Navy --type conceptual --text title-subtitle  --mood bold  --font clean --aspect 1:1 --lang zhtw

圖03  6大核心特色放射圖
**Layout:** `hub-spoke` | **Style:** `Dark Tech Glassmorphism`
/baoyu-infographic --style Dark Tech Glassmorphism Layout: hub-spoke --lang zhtw

圖04— 完整規格對照表
**Layout:** `dense-modules` | **Style:** `Dark Tech Glassmorphism`
/baoyu-infographic  --style Dark Tech Glassmorphism Layout: dense-modules --lang zhtw

圖05 — 速率儀表板
**Layout:** `dashboard` | **Style:** `Dark Tech Glassmorphism`
/baoyu-infographic  --style Dark Tech Glassmorphism Layout: dashboard --lang zhtw

圖06  Support OS version
**Layout:** `hub-spoke` | **Style:** `Dark Tech Glassmorphism`
/baoyu-infographic  --style Dark Tech Glassmorphism Layout: hub-spoke --lang zhtw

圖07 — 適用客群 × 應用場景
**Layout:** `bento-grid` | **Style:** `Dark Tech Glassmorphism`
/baoyu-infographic  --style Dark Tech Glassmorphism Layout: bento-grid --lang zhtw