I need to generate 7 product information card images.

---

## Generation Setup

**Image spec:** 1024×1024 px, high resolution

**Product name:** `[PRODUCT_NAME]`
*(Replace with actual product name before running, e.g. ALFA AWUS036ACH)*

**Reference image:**
- Source folder: `02_ALFA/Raw_image/` (pick the PNG matching the product)
- Upload to GX10 before generation: `scp <ref.png> gx10:~/Downloads/image/<product>_ref.png`
- **Always include reference_image** — this ensures correct product shape, antenna design, and external appearance. Never generate without it.

**Output folder:** `02_Products/02_ALFA/Output/GX10/[PRODUCT_NAME]/`

**Language:** English (or specify per image below)

---

## Image Generation Server — GX10 Port 8080 Gemini API

**Server:** `http://192.168.1.228:8080`  
**Endpoint:** `POST /generate`  
**SSH alias:** `gx10` (User: `yopitek`, Key: `~/.ssh/id_ed25519`)

**API call template:**
```python
import json, subprocess

payload = {
    "prompt": "<image prompt here>",
    "reference_image": "/home/yopitek/Downloads/image/<product>_ref.png",
    "new_chat": True,
    "timeout": 280
}

with open("/tmp/payload.json", "w") as f:
    json.dump(payload, f)

r = subprocess.run(
    ["curl", "-sf", "-X", "POST", "http://192.168.1.228:8080/generate",
     "-H", "Content-Type: application/json",
     "-d", "@/tmp/payload.json", "--max-time", "360"],
    capture_output=True, text=True, timeout=400
)
result = json.loads(r.stdout)
remote_path = result["image_path"]   # e.g. /home/yopitek/Downloads/image/gemini_TIMESTAMP.jpeg

# SCP download to local output folder
subprocess.run([
    "scp", "-i", "~/.ssh/id_ed25519",
    f"gx10:{remote_path}",
    "02_Products/02_ALFA/Output/GX10/[PRODUCT_NAME]/01_cover.png"
])
```

**Notes:**
- Generation with reference image takes ~3–5 min per image — use `timeout: 280` in payload and `--max-time 360` in curl
- Add retry logic (3 attempts, 15s delay) for intermittent 504 errors
- Output is saved on GX10 at `/home/yopitek/Downloads/image/gemini_TIMESTAMP.jpeg` — always SCP after each successful call
- Server guide: `HQ/04_Work/HW_setup/image_server.md.md`

---

## 7 Images — Prompts & Styles

### 圖01 — Store Cover / Product Title
**Style:** Dark Tech Glassmorphism | **Layout:** structural-breakdown | **Aspect:** 1:1  
**Prompt:**
> Product information card cover image for [PRODUCT_NAME]. Dark Tech Glassmorphism style. Large bold product name as headline, product photo prominently displayed (use reference image for exact product appearance), structural-breakdown layout showing key specs. Dark background with glass-panel overlays, cyan/blue accent colors, clean tech typography. 1024x1024.

### 圖02 — Product Conceptual Map
**Style:** Engineering Blueprint Navy | **Layout:** conceptual map | **Aspect:** 1:1  
**Prompt:**
> Product conceptual map infographic for [PRODUCT_NAME]. Engineering Blueprint Navy style. Title + subtitle at top, product image at center, surrounding concept nodes showing use cases and key features. Bold mood, clean sans-serif font, navy/white/gold color palette on dark blueprint grid background. 1024x1024.

### 圖03 — 6 Core Features Radial Diagram
**Style:** Dark Tech Glassmorphism | **Layout:** hub-spoke  
**Prompt:**
> Product infographic for [PRODUCT_NAME] showing 6 core product features. Dark Tech Glassmorphism style, hub-spoke layout. Product image in center hub, 6 feature nodes radiating outward, each with icon and short description. Dark background, frosted glass panels, cyan highlights, clean tech font. English text. 1024x1024.

### 圖04 — Full Specifications Table
**Style:** Dark Tech Glassmorphism | **Layout:** dense-modules  
**Prompt:**
> Full product specifications infographic for [PRODUCT_NAME]. Dark Tech Glassmorphism style, dense-modules grid layout. All technical specs organized in labeled modules (chipset, wireless standards, frequency bands, max speed, antenna, USB interface, OS support, dimensions). Dark background, glass card panels, structured data tables, cyan/white text. English. 1024x1024.

### 圖05 — Technical Schematic
**Style:** Blueprint Engineering | **Layout:** bento-grid  
**Prompt:**
> Technical schematic infographic for [PRODUCT_NAME]. Blueprint engineering style, bento-grid layout. Shows RF signal path, antenna specs, USB interface diagram, chipset architecture block diagram. Blueprint grid background, white/cyan technical line drawings, labeled components, engineering annotation style. English. 1024x1024.

### 圖06 — Supported OS Versions
**Style:** Dark Tech Glassmorphism | **Layout:** hub-spoke  
**⚠️ Note:** Always use OS list from the product spec file. Do NOT add OS/firmware not listed in spec (e.g. DD-WRT, OpenWRT, pfSense, router firmware).  
**Prompt:**
> Supported operating systems infographic for [PRODUCT_NAME]. Dark Tech Glassmorphism style, hub-spoke layout. Product image at center hub. Show ONLY these supported OS as surrounding nodes — use exact names and logos:
> - Windows 10 / 11 ✅
> - macOS 10.15 Catalina ⚠️ (limited, manual install, macOS 11+ NOT supported)
> - Ubuntu ✅ (requires RTL8812AU driver / DKMS)
> - Kali Linux ✅ (gold standard, full monitor mode + packet injection)
> - Android NetHunter ✅ (OTG USB)
> Do NOT include DD-WRT, OpenWRT, or any router firmware. Do NOT add any OS not listed above.
> Dark background, frosted glass panels, OS brand colors accented per node. English. 1024x1024.

### 圖07 — Target Audience × Use Cases
**Style:** Dark Tech Glassmorphism | **Layout:** bento-grid  
**Prompt:**
> Target audience and use cases infographic for [PRODUCT_NAME]. Dark Tech Glassmorphism style, bento-grid layout. Grid of scenario cards showing who uses this product and in what situations (home, office, travel, security research, etc.) with icons and short descriptions. Dark background, glass panels, accent colors per category. English. 1024x1024.


