use Superpowers:brainstorming skill 

我在規畫要幫我們公司的ig 進行每日產品的行銷方案, 請先幫我們進行一周的規畫. 
我們會先生成
script > image prompt > 使用 gemini 3 pro 進行圖片生成 
一篇IG 需要3~5張高畫質產品行銷圖片

Use baoyu skill 進行卡片的內容生成
/Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ/10_resources/02_coding_agents/baoyu-skills

# 使用 gemini-3-pro (高畫質，預設)
  BUN_X=/opt/homebrew/bin/bun
  $BUN_X /Users/benny/Downloads/n8n_project/.agents/skills/baoyu-danger-gemini-w
  eb/scripts/main.ts \
    --prompt "Professional technology slide: ALFA AWUS036AXML" \
    --ref /Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ/04_Work/02_Pro
  ducts/02_ALFA/Raw_image/AWUS036AXML.png \
    --image /Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ/04_Work/02_P
  roducts/02_ALFA/power_point/AWUS036AXML/slide-deck/images/new-slide.png \
    --model gemini-3-pro

product list 
/Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ/04_Work/02_Products

IG folder
/Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ/04_Work/10_Website/02_IG

use these baoyu styles for generating the ig photos.

baoyu-infographic： /baoyu-infographic --layout feature-list --style technical-schematic --aspect 1:1

baoyu-infographic --layout grid-cards --style technical-schematic --aspect 1:1

baoyu-infographic --layout grid-cards --style blueprint --aspect 1:1

baoyu-infographic --layout grid-cards --style corporate-memphis --aspect 1:1