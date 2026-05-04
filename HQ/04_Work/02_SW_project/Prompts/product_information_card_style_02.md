I need to generate 7 product information card images.

---

## Generation Setup

**Image spec:** 1024×1024 px, high resolution

**Product name:** `[PRODUCT_NAME]`
*(Replace with actual product name before running, e.g. ALFA AWUS036ACH)*

**Style:** 🟣 **Cyberpunk Hacker — Neon Glow / Penetration Hacker Aesthetic**
> Dark background, neon glowing lines (fluorescent green / magenta / cyan), terminal code elements, futuristic tech feel. Perfect for AWUS036ACH as a Kali Linux certified adapter for hackers and white-hat security researchers.

**Reference image:**
- Source folder: `02_ALFA/Raw_image/` (pick the PNG matching the product)
- Upload to GX10 before generation: `scp <ref.png> gx10:~/Downloads/image/<product>_ref.png`
- **Always include reference_image** — this ensures correct product shape, antenna design, and external appearance. Never generate without it.

**Output folder:** `02_Products/02_ALFA/Output/GX10/[PRODUCT_NAME]/style_02/`

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
    "02_Products/02_ALFA/Output/GX10/[PRODUCT_NAME]/style_02/01_cover.png"
])
```

**Notes:**
- Generation with reference image takes ~3–5 min per image — use `timeout: 280` in payload and `--max-time 360` in curl
- Add retry logic (3 attempts, 15s delay) for intermittent 504 errors
- Output is saved on GX10 at `/home/yopitek/Downloads/image/gemini_TIMESTAMP.jpeg` — always SCP after each successful call
- Server guide: `HQ/04_Work/HW_setup/image_server.md.md`

---

## Visual Identity — Cyberpunk Hacker Style

Apply consistently across all 7 images:
- **Background:** Pure black or very dark charcoal (`#0a0a0a`)
- **Primary accents:** Neon fluorescent green (`#00ff41`), electric cyan (`#00e5ff`), hot magenta/pink (`#ff00aa`)
- **Effects:** Glowing neon outlines, scanline texture, terminal code/hex fragments in background, subtle CRT flicker aesthetic
- **Typography:** Monospace terminal font (like OCR-A, Courier, or similar hacker aesthetic), high contrast white/neon on dark
- **Mood:** Aggressive, high-contrast, professional hacker / security research tool
- **Consistency:** Every image should look like it was captured from a professional hacker's terminal interface screen

---

## 7 Images — Prompts & Styles

### 圖01 — Store Cover / Product Title
**Style:** Cyberpunk Neon | **Layout:** structural-breakdown | **Rendering:** digital  
**Prompt:**
> Product cover image for [PRODUCT_NAME]. Cyberpunk hacker aesthetic. Pure black background with neon glow effects. Product photo prominently displayed at center (use reference image for exact product appearance — do not alter product shape or antennas). Large bold product name in neon green glowing monospace font as headline. Structural-breakdown layout with floating neon-outlined spec panels. Electric cyan / fluorescent green / hot magenta accent colors. Scanline texture overlay. Terminal code fragments in background. High contrast, aggressive tech mood. 1024x1024.

### 圖02 — Product Conceptual Map
**Style:** Cyberpunk Neon | **Layout:** conceptual map | **Rendering:** digital  
**Prompt:**
> Product conceptual map infographic for [PRODUCT_NAME]. Cyberpunk neon style. Title and subtitle at top in glowing monospace font. Product image at center (exact shape from reference). Surrounding concept nodes connected by neon glowing lines showing use cases and key features. Pure black background, neon green / cyan / magenta node outlines, hex code fragments as decorative background elements. Bold, aggressive hacker mood. 1024x1024.

### 圖03 — 6 Core Features Radial Diagram
**Style:** Cyberpunk Neon | **Layout:** hub-spoke  
**Prompt:**
> Product infographic for [PRODUCT_NAME] showing 6 core product features. Cyberpunk neon hacker style, hub-spoke radial layout. Product image in center hub surrounded by a glowing neon ring. 6 feature nodes radiating outward, each with a neon icon and short description in monospace font. Pure black background, neon green / cyan accent glow on lines and nodes. Terminal aesthetic with scanline overlay. English text. 1024x1024.

### 圖04 — Full Specifications Table
**Style:** Cyberpunk Neon | **Layout:** dense-modules  
**Prompt:**
> Full product specifications infographic for [PRODUCT_NAME]. Cyberpunk hacker style, dense-modules grid layout. All technical specs in labeled neon-outlined panels (chipset, wireless standards, frequency bands, max speed, antenna, USB interface, OS support). Pure black background, neon green table borders and labels, cyan / white text data values. Monospace terminal font throughout. Hex code fragments as background decoration. English. 1024x1024.

### 圖05 — Technical Schematic
**Style:** Cyberpunk Neon | **Layout:** bento-grid  
**Prompt:**
> Technical schematic infographic for [PRODUCT_NAME]. Cyberpunk neon style, bento-grid layout. Shows RF signal path, antenna specs, USB interface diagram, chipset architecture block diagram. Pure black background, neon green and cyan technical line drawings, glowing component labels in monospace font, circuit trace aesthetic. High-contrast hacker terminal style. English. 1024x1024.

### 圖06 — Supported OS Versions
**Style:** Cyberpunk Neon | **Layout:** hub-spoke  
**⚠️ Note:** Always use OS list from the product spec file. Do NOT add OS/firmware not listed in spec (e.g. DD-WRT, OpenWRT, pfSense, router firmware).  
**Prompt:**
> Supported operating systems infographic for [PRODUCT_NAME]. Cyberpunk neon hacker style, hub-spoke layout. Product image at center hub with glowing neon ring. Show ONLY these supported OS as surrounding nodes — use exact names and neon-styled logos:
> - Windows 10 / 11 (supported)
> - macOS 10.15 Catalina (limited — macOS 11+ NOT supported)
> - Ubuntu (requires RTL8812AU DKMS driver)
> - Kali Linux (gold standard — full monitor mode + packet injection)
> - Android NetHunter (OTG USB)
> Do NOT include DD-WRT, OpenWRT, or any router firmware. Exactly 5 OS nodes only.
> Pure black background, neon accent colors per OS node, scanline texture, monospace labels. English. 1024x1024.

### 圖07 — Target Audience × Use Cases
**Style:** Cyberpunk Neon | **Layout:** bento-grid  
**Prompt:**
> Target audience and use cases infographic for [PRODUCT_NAME]. Cyberpunk neon hacker style, bento-grid layout. Grid of neon-outlined scenario cards showing who uses this product (security researchers, Kali Linux users, CTF players, white-hat hackers, network engineers). Each card has a neon icon and short description in monospace font. Pure black background, neon green / cyan / magenta card borders, high contrast. English. 1024x1024.