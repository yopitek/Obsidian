I need to generate 7 product information card images.

---

## Generation Setup

**Image spec:** 1024×1024 px, high resolution

**Product name:** `[PRODUCT_NAME]`
*(Replace with actual product name before running, e.g. ALFA AWUS036ACH)*

**Style:** 🔵 **Blueprint Technical Schematic — Engineering Drawing Aesthetic**
> Precise engineering blueprint style. Navy/white drafting grid background, white/cyan technical line drawings, annotation callouts, engineering notation. Clean, authoritative, precision-focused.

**Reference image:**
- Source folder: `02_ALFA/Raw_image/` (pick the PNG matching the product)
- Upload to GX10 before generation: `scp <ref.png> gx10:~/Downloads/image/<product>_ref.png`
- **Always include reference_image** — this ensures correct product shape, antenna design, and external appearance. Never generate without it.

**Output folder:** `02_Products/02_ALFA/Output/GX10/[PRODUCT_NAME]/style_03/`

**Language:** English

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
remote_path = result["image_path"]

subprocess.run([
    "scp", "-i", "~/.ssh/id_ed25519",
    f"gx10:{remote_path}",
    "02_Products/02_ALFA/Output/GX10/[PRODUCT_NAME]/style_03/01_cover.png"
])
```

**Notes:**
- Generation with reference image takes ~3–5 min per image — use `timeout: 280` in payload and `--max-time 360` in curl
- Add retry logic (3 attempts, 15s delay) for intermittent 504 errors
- Output is saved on GX10 at `/home/yopitek/Downloads/image/gemini_TIMESTAMP.jpeg` — always SCP after each successful call
- Server guide: `HQ/04_Work/HW_setup/image_server.md.md`

---

## Visual Identity — Blueprint Technical Schematic Style

Apply consistently across all 7 images:
- **Background:** Dark navy / blueprint blue (`#0d1b2a` or `#0a1628`) with fine drafting grid lines
- **Primary colors:** White and electric cyan (`#00cfff`) for all lines, text, and callouts; gold/amber (`#f0c040`) for dimension annotations
- **Effects:** Engineering drafting grid, dimension lines with arrowheads, callout bubbles, title block border in bottom-right corner, orthographic projection aesthetic
- **Typography:** Clean sans-serif for labels; monospace or engineering stencil for annotations and dimension values
- **Mood:** Precise, authoritative, technical, professional — like an official engineering datasheet
- **Consistency:** Every image should look like it belongs to the same technical documentation package

---

## 7 Images — Prompts & Styles

### 圖01 — Store Cover / Product Title
**Style:** Blueprint Technical Schematic | **Layout:** feature-list  
**Prompt:**
> Product cover infographic for [PRODUCT_NAME]. Blueprint engineering schematic style. Dark navy background with fine drafting grid. Product image displayed as a precise engineering drawing (use reference image for exact product shape — do not alter design). Product name as large headline in clean white stencil font. Feature-list layout: key specs listed with callout lines pointing to product parts. Dimension annotation lines in gold/amber. Title block border in corner. White and cyan color palette. 1024x1024.

### 圖02 — Product Conceptual Map
**Style:** Blueprint Technical Schematic | **Layout:** conceptual map  
**Prompt:**
> Product conceptual map infographic for [PRODUCT_NAME]. Blueprint engineering style. Dark navy blueprint grid background. Product image at center rendered as a technical line drawing (exact shape from reference image). Title and subtitle at top in clean engineering stencil font. Surrounding concept nodes connected by dimension-style lines showing use cases and key features. White / cyan node outlines, gold annotation labels. Bold, authoritative technical mood. 1024x1024.

### 圖03 — 6 Core Features Radial Diagram
**Style:** Blueprint Technical Schematic | **Layout:** mind-map radial  
**Prompt:**
> Product infographic for [PRODUCT_NAME] showing 6 core product features. Blueprint technical schematic style, mind-map radial layout. Product technical line drawing at center (exact shape from reference). 6 feature branches radiating outward with dimension-style connecting lines, each ending in a labeled callout box. Dark navy blueprint grid background, white / cyan lines, gold annotation text. Clean engineering stencil typography. English. 1024x1024.

### 圖04 — Full Specifications Table
**Style:** Blueprint Technical Schematic | **Layout:** comparison-table  
**Prompt:**
> Full product specifications infographic for [PRODUCT_NAME]. Blueprint technical schematic style, structured comparison-table layout. All technical specs in a clean data table with engineering grid borders (chipset, wireless standards, frequency bands, max speed, antenna, USB interface, OS support). Dark navy background, white table lines, cyan header row, gold dimension callout labels. Engineering title block in corner. Monospace values, clean sans-serif labels. English. 1024x1024.

### 圖05 — Speed / Performance Dashboard
**Style:** Blueprint Technical Schematic | **Layout:** grid-cards  
**Prompt:**
> Product performance and speed infographic for [PRODUCT_NAME]. Blueprint technical schematic style, grid-cards layout. Multiple performance metric cards arranged in grid: 2.4GHz speed, 5GHz speed, USB spec, antenna gain, range, chipset. Each card styled as an engineering instrument panel or gauge with dimension annotation lines. Dark navy blueprint grid background, white / cyan card borders, gold metric labels. Technical schematic aesthetic. English. 1024x1024.

### 圖06 — Supported OS Versions
**Style:** Blueprint Technical Schematic | **Layout:** tree-hierarchy  
**⚠️ Note:** Always use OS list from the product spec file. Do NOT add OS/firmware not listed in spec (e.g. DD-WRT, OpenWRT, pfSense, router firmware).  
**Prompt:**
> Supported operating systems infographic for [PRODUCT_NAME]. Blueprint technical schematic style, tree-hierarchy layout. Root node at top: product name. Branching down to show ONLY these supported OS — use exact names:
> - Windows 10 / 11 (supported)
> - macOS 10.15 Catalina (limited — macOS 11+ NOT supported)
> - Ubuntu (requires RTL8812AU DKMS driver)
> - Kali Linux (gold standard — full monitor mode + packet injection)
> - Android NetHunter (OTG USB)
> Do NOT include DD-WRT, OpenWRT, or any router firmware. Exactly 5 OS leaf nodes only.
> Dark navy blueprint grid background, white / cyan tree lines, gold annotation labels, engineering callout style. English. 1024x1024.

### 圖07 — Target Audience × Use Cases
**Style:** Blueprint Technical Schematic | **Layout:** grid-cards  
**Prompt:**
> Target audience and use cases infographic for [PRODUCT_NAME]. Blueprint technical schematic style, grid-cards layout. Grid of engineering-panel style cards showing who uses this product and in what scenarios (security researchers, Kali Linux users, CTF/penetration testers, network engineers, Raspberry Pi users). Each card has a technical icon and short annotation in engineering stencil font. Dark navy blueprint grid background, white / cyan card outlines, gold callout labels. Precise, authoritative documentation aesthetic. English. 1024x1024.