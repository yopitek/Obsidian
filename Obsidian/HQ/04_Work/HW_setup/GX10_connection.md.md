# Mac Mini → gx10 Image Generation Connection Guide

## Overview

Your **gx10** machine (`192.168.1.228`) runs two image generation services:

| Service          | Port   | Type                       |
| ---------------- | ------ | -------------------------- |
| ComfyUI          | `8188` | Web UI + REST API          |
| Image API Bridge | `8002` | OpenAI-compatible REST API |

**Available models on gx10:**
- `flux1-dev.safetensors` — FLUX.1 Dev (text-to-image, high quality)
- `flux1-redux-dev.safetensors` — FLUX.1 Redux (image-to-image / style transfer)
- `Wan2_2-I2V-A14B-HIGH_bf16.safetensors` — Wan2.2 (image-to-video)

---

## Step 1 — Verify Connectivity from Mac Mini

Open Terminal on the Mac Mini and run:

```bash
# Test Image API Bridge
curl http://192.168.1.228:8002/health

# Expected response:
# {"status":"ok","comfyui":true}

# Test ComfyUI
curl http://192.168.1.228:8188/system_stats
```

If both return JSON, you're connected. If not, check that gx10 is on and Docker is running:
```bash
# From Mac Mini, SSH into gx10 first if needed:
ssh yopitek@192.168.1.228
# Then check:
docker ps
```

---

## Step 2 — Generate Product Images via Image API Bridge (Recommended)

The Image API Bridge at port `8002` uses the **OpenAI images API format**, making it easy to use with Claude Code and any OpenAI SDK.

### Quick test (no code needed):
```bash
curl -s http://192.168.1.228:8002/v1/images/generations \
  -H "Content-Type: application/json" \
  -d '{
    "model": "flux1-dev",
    "prompt": "professional product photo of a white ceramic coffee mug on a clean white background, studio lighting, high detail",
    "size": "1024x1024",
    "n": 1
  }' | python3 -c "
import sys, json, base64
r = json.load(sys.stdin)
img = base64.b64decode(r['data'][0]['b64_json'])
open('product_test.png', 'wb').write(img)
print('Saved: product_test.png')
"
```

### Python script for batch product images:

Create a file `generate_product_images.py` on the Mac Mini:

```python
#!/usr/bin/env python3
"""Product image generator using gx10's FLUX.1-dev via Image API Bridge."""
import base64
import json
import os
import time
import httpx  # pip install httpx

GX10_API = "http://192.168.1.228:8002"

PRODUCT_PROMPTS = [
    {
        "name": "mug_white",
        "prompt": "professional product photo of a minimalist white ceramic coffee mug, "
                  "studio lighting, pure white background, sharp focus, commercial photography",
    },
    {
        "name": "bottle_glass",
        "prompt": "product shot of an elegant glass water bottle, transparent, "
                  "soft diffused lighting, white background, high-end commercial style",
    },
    {
        "name": "skincare_serum",
        "prompt": "luxury skincare serum bottle, amber glass dropper bottle, "
                  "dark moody background, elegant product photography, cinematic lighting",
    },
]


def generate_image(prompt: str, size: str = "1024x1024") -> bytes:
    """Call gx10 Image API Bridge and return raw PNG bytes."""
    with httpx.Client(timeout=300) as client:  # FLUX can take 30-120s
        resp = client.post(
            f"{GX10_API}/v1/images/generations",
            json={
                "model": "flux1-dev",
                "prompt": prompt,
                "size": size,
                "n": 1,
                "response_format": "b64_json",
            },
        )
        resp.raise_for_status()
        b64 = resp.json()["data"][0]["b64_json"]
        return base64.b64decode(b64)


def main():
    os.makedirs("product_images", exist_ok=True)

    for item in PRODUCT_PROMPTS:
        print(f"Generating: {item['name']}...")
        start = time.time()
        img_bytes = generate_image(item["prompt"])
        elapsed = time.time() - start

        out_path = f"product_images/{item['name']}.png"
        with open(out_path, "wb") as f:
            f.write(img_bytes)
        print(f"  ✓ Saved {out_path} ({len(img_bytes)//1024}KB, {elapsed:.1f}s)")


if __name__ == "__main__":
    main()
```

Run it:
```bash
pip install httpx
python3 generate_product_images.py
```

---

## Step 3 — Use with Claude Code (CLAUDE.md configuration)

In your project directory on the Mac Mini, create a `CLAUDE.md` to tell Claude Code about the image service:

```markdown
## Image Generation

- gx10 Image API runs at: http://192.168.1.228:8002
- Endpoint: POST /v1/images/generations
- Compatible with OpenAI images API format
- Model: "flux1-dev" (FLUX.1, best quality)
- Sizes: any WxH e.g. "1024x1024", "1024x1536", "1536x1024"
- Response: base64-encoded PNG in data[0].b64_json
- Timeout: 300 seconds (generation takes 30-120s on GPU)
- Health check: GET /v1/health or GET /health
```

Then tell Claude Code:
> "Use the image API at http://192.168.1.228:8002 to generate product images for our catalog. Use the FLUX.1-dev model."

### Claude Code environment variable (optional):

```bash
# Add to ~/.zshrc or ~/.bashrc on Mac Mini:
export IMAGE_API_BASE_URL="http://192.168.1.228:8002"
```

---

## Step 4 — Using OpenAI Python SDK directly

The Image API Bridge is 100% OpenAI-compatible:

```python
from openai import OpenAI
import base64

client = OpenAI(
    base_url="http://192.168.1.228:8002/v1",
    api_key="not-needed",  # no auth required on local network
    timeout=300,
)

response = client.images.generate(
    model="flux1-dev",
    prompt="professional product photo of a luxury watch on black velvet, macro lens, studio lighting",
    size="1024x1024",
    n=1,
    response_format="b64_json",
)

img_bytes = base64.b64decode(response.data[0].b64_json)
with open("watch_product.png", "wb") as f:
    f.write(img_bytes)
print("Done!")
```

Install:
```bash
pip install openai
```

---

## Step 5 — ComfyUI Web UI (for manual workflow editing)

Access the ComfyUI interface directly in browser:

```
http://192.168.1.228:8188
```

This lets you visually build and tweak workflows. Useful for:
- Testing prompts before scripting them
- Using FLUX.1 Redux (image-to-image)
- Advanced workflow customization

---

## API Reference

### Image API Bridge (`http://192.168.1.228:8002`)

**`POST /v1/images/generations`**
```json
{
  "model": "flux1-dev",
  "prompt": "your product description here",
  "n": 1,
  "size": "1024x1024",
  "response_format": "b64_json"
}
```

**Response:**
```json
{
  "created": 1234567890,
  "data": [{"b64_json": "<base64-encoded PNG>"}]
}
```

**`GET /health`** → `{"status": "ok", "comfyui": true}`

### Sizes you can use:
- `1024x1024` — square (default)
- `1024x1536` — portrait (product on shelf)
- `1536x1024` — landscape (hero banners)
- `512x512` — fast preview/test
- `768x1024` — portrait product card

---

## Prompt Tips for Product Photography

```
# Template for clean product shots:
"professional product photo of [ITEM], [STYLE], white/black background, studio lighting, 
commercial photography, sharp focus, high detail, 8k"

# Examples:
"professional product photo of a minimalist leather wallet, flat lay, white background, 
natural light, editorial style"

"product shot of [ITEM], packshot style, clean background, soft box lighting, 
Amazon listing quality"

"luxury brand product photo of [ITEM], dark moody background, dramatic lighting, 
cinematic, high-end commercial"
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `Connection refused` on port 8002 or 8188 | SSH to gx10 and run `docker ps` — restart with `cd ~/Project && docker compose up -d` |
| Request times out | Generation takes 30-120s, use `timeout=300` in your HTTP client |
| `curl` returns HTML instead of JSON | Missing `-H "Content-Type: application/json"` header |
| Image looks wrong | Try more descriptive prompt or change size |

### Restart services on gx10 (if needed):
```bash
ssh yopitek@192.168.1.228
cd ~/Project
docker compose restart image-bridge  # restart just the API bridge
docker compose restart               # restart everything
docker compose logs -f image-bridge  # view logs
```