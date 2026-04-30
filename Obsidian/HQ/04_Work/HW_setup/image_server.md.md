---
title: GX10 Image Generation Server — Remote Access Guide
tags:
  - image-generation
  - remote-access
  - claude-code
  - mcp
  - cli-anything
  - tailscale
  - comfyui
  - api
updated: 2026-04-16
type: setup-guide
machine: ASUS-Ascent-GX10
---

# 🖼️ GX10 Image Generation — Remote Access Guide

> How to use GX10's AI image generation from **another computer** using Claude Code.  
> Covers: MCP server, CLI-Anything, direct API, and SSH approaches.

---

## 1. GX10 Image Services Overview

The GX10 runs **two image generation backends**:

| Service | Port | Protocol | Description |
|---------|------|----------|-------------|
| **Gemini Image API** | `8080` | HTTP REST | `gen-image` CLI backend — Gemini Web UI, no API key |
| **ComfyUI** | `8188` | HTTP REST | Full workflow engine — supports image + video generation |

### Network Access
| Method | Address | Notes |
|--------|---------|-------|
| **LAN (same network)** | `192.168.1.228` | Direct WiFi/Ethernet |
| **Tailscale (remote)** | `100.73.84.27` | ✅ Already configured — works anywhere |
| **Cloudflare Tunnel** | (see cloudflared config) | HTTPS, works through firewall |

> ✅ **Tailscale is already running** on the GX10. If your other computer joins the same tailnet (`goolai@`), you get instant secure access to all services.

---

## 2. Option A — CLI-Anything (Recommended for Claude Code)

CLI-Anything wraps any CLI tool into an **agent-ready harness** with structured JSON output. Perfect for Claude Code.

### 2a. Install CLI-Anything on Claude Code (Remote Computer)

In Claude Code on the **remote computer**:
```
/plugin marketplace add HKUDS/CLI-Anything
/plugin install cli-anything
```

Or via terminal:
```bash
pip install cli-anything-hub
cli-hub install gen-image-gx10   # (after publishing the harness below)
```

### 2b. Create the `gen-image-gx10` CLI Harness (on GX10)

The harness wraps the GX10's HTTP image API so Claude Code on any machine can call it:

```bash
# On GX10 — create the harness script
cat > ~/Project/cli-anything/gen-image-gx10.sh << 'EOF'
#!/usr/bin/env bash
# gen-image-gx10 — Remote image generation via GX10 Gemini API
# CLI-Anything harness — agent-callable, JSON output
#
# Usage: gen-image-gx10 generate "your prompt here"
# Output: JSON with image_path and status

GX10_API="http://localhost:8080/generate"

CMD="${1:-help}"
PROMPT="${2:-}"

case "$CMD" in
  generate)
    if [ -z "$PROMPT" ]; then
      echo '{"error": "prompt required", "usage": "gen-image-gx10 generate \"prompt\""}'
      exit 1
    fi
    RESULT=$(curl -s -X POST "$GX10_API" \
      -H "Content-Type: application/json" \
      -d "{\"prompt\": $(echo "$PROMPT" | python3 -c 'import sys,json; print(json.dumps(sys.stdin.read().strip()))')}")
    echo "$RESULT"
    ;;
  health)
    curl -s http://localhost:8080/health
    ;;
  help|*)
    cat << HELP
{
  "name": "gen-image-gx10",
  "description": "Generate images using GX10 Gemini AI image generation server",
  "commands": {
    "generate": "Generate an image from text prompt",
    "health": "Check server health"
  },
  "examples": [
    "gen-image-gx10 generate \"a futuristic city at sunset\"",
    "gen-image-gx10 health"
  ]
}
HELP
    ;;
esac
EOF
chmod +x ~/Project/cli-anything/gen-image-gx10.sh
```

### 2c. Alternative: CLI-Anything via SSH (call GX10 from remote)

On the **remote computer**, create a thin SSH wrapper:

```bash
# Remote computer — wrapper that SSHes to GX10 and runs gen-image
cat > ~/.local/bin/gen-image-gx10 << 'EOF'
#!/usr/bin/env bash
# Calls GX10 gen-image over SSH or Tailscale HTTP
# Usage: gen-image-gx10 "your prompt"

PROMPT="$1"
GX10_HOST="gx10-e6c5"           # Tailscale hostname
# OR use IP: GX10_HOST="100.73.84.27"

if [ -z "$PROMPT" ]; then
  echo "Usage: gen-image-gx10 'prompt'"
  exit 1
fi

# Call via Tailscale HTTP API
RESULT=$(curl -sf -X POST "http://${GX10_HOST}:8080/generate" \
  -H "Content-Type: application/json" \
  -d "{\"prompt\": \"${PROMPT}\"}" 2>/dev/null)

if [ $? -eq 0 ]; then
  echo "$RESULT"
else
  # Fallback: SSH into GX10 and run gen-image locally
  ssh "${GX10_HOST}" "gen-image '${PROMPT}'"
fi
EOF
chmod +x ~/.local/bin/gen-image-gx10
```

---

## 3. Option B — MCP Server (Native Claude Code Integration)

An MCP (Model Context Protocol) server on GX10 lets Claude Code call image generation as a **native tool** — no CLI wrapper needed.

### 3a. Install FastMCP on GX10

```bash
pip install fastmcp --break-system-packages
```

### 3b. Create the MCP Server

```python
# ~/Project/mcp-servers/image-gen-server.py
#!/usr/bin/env python3
"""MCP server wrapping GX10 image generation for Claude Code."""
import subprocess, requests, base64, os, time
from pathlib import Path
from fastmcp import FastMCP

mcp = FastMCP("gx10-image-gen")

@mcp.tool()
def generate_image(prompt: str) -> dict:
    """Generate an image using GX10's Gemini AI backend.
    
    Args:
        prompt: Text description of the image to generate
        
    Returns:
        dict with image_path, discord_msg_id, and status
    """
    result = subprocess.run(
        ["gen-image", prompt],
        capture_output=True, text=True, timeout=120
    )
    
    output = result.stdout
    image_path = None
    discord_id = None
    
    for line in output.split('\n'):
        if line.startswith('IMAGE_PATH:'):
            image_path = line.split(':', 1)[1].strip()
        elif line.startswith('DISCORD_MSG_ID:'):
            discord_id = line.split(':', 1)[1].strip()
    
    return {
        "status": "success" if result.returncode == 0 else "error",
        "image_path": image_path,
        "discord_msg_id": discord_id,
        "prompt": prompt,
        "error": result.stderr if result.returncode != 0 else None
    }

@mcp.tool()
def generate_video(
    prompt: str,
    start_image_path: str,
    width: int = 1024,
    height: int = 576,
    steps: int = 25,
    seed: int = 42
) -> dict:
    """Generate a video using GX10's Wan2.2 I2V model via ComfyUI.
    
    Args:
        prompt: Cinematic description of the video
        start_image_path: Path to starting frame image
        width: Output width (max 1024 for 128GB RAM)
        height: Output height (max 576 for 128GB RAM)
        steps: Denoising steps (25=quality, 6=fast draft)
        seed: Random seed for reproducibility
    """
    import json, time
    
    COMFY = "http://localhost:8188"
    
    # Upload start image
    with open(start_image_path, "rb") as f:
        fname = Path(start_image_path).name
        r = requests.post(f"{COMFY}/upload/image",
            files={"image": (fname, f, "image/jpeg")},
            data={"type": "input", "overwrite": "true"})
    
    # Load base workflow template
    template_path = "/tmp/transformer_hq_api.json"
    with open(template_path) as f:
        workflow = json.load(f)
    
    # Override parameters
    workflow["2"]["inputs"]["positive_prompt"] = prompt
    workflow["7"]["inputs"]["image"] = fname
    workflow["8"]["inputs"]["width"] = width
    workflow["8"]["inputs"]["height"] = height
    workflow["9"]["inputs"]["steps"] = steps
    workflow["9"]["inputs"]["seed"] = seed
    
    # Submit
    r = requests.post(f"{COMFY}/prompt", json={"prompt": workflow})
    prompt_id = r.json()["prompt_id"]
    
    # Poll for completion
    for _ in range(200):
        time.sleep(5)
        hist = requests.get(f"{COMFY}/history/{prompt_id}").json()
        if prompt_id in hist:
            status = hist[prompt_id].get("status", {})
            if status.get("completed"):
                outputs = hist[prompt_id].get("outputs", {})
                for _, out in outputs.items():
                    if "gifs" in out:
                        return {"status": "success", "filename": out["gifs"][0]["filename"],
                                "prompt_id": prompt_id}
                return {"status": "completed", "prompt_id": prompt_id}
            elif status.get("status_str") == "error":
                return {"status": "error", "details": str(status)}
    
    return {"status": "timeout", "prompt_id": prompt_id}

@mcp.tool()
def check_server_status() -> dict:
    """Check health of GX10 image and video generation services."""
    import subprocess
    
    status = {}
    
    # Gemini image API
    try:
        r = requests.get("http://localhost:8080/health", timeout=3)
        status["gemini_api"] = r.json()
    except:
        status["gemini_api"] = "unreachable"
    
    # ComfyUI
    try:
        r = requests.get("http://localhost:8188/system_stats", timeout=3)
        stats = r.json()
        status["comfyui"] = {
            "running": True,
            "python": stats.get("system", {}).get("python_version", "?")[:10]
        }
    except:
        status["comfyui"] = "unreachable"
    
    # Memory
    result = subprocess.run(["free", "-h"], capture_output=True, text=True)
    lines = result.stdout.strip().split('\n')
    if len(lines) > 1:
        parts = lines[1].split()
        status["memory"] = {"total": parts[1], "used": parts[2], "free": parts[3]}
    
    return status

if __name__ == "__main__":
    mcp.run(transport="streamable-http", host="0.0.0.0", port=8765)
```

### 3c. Start the MCP Server

```bash
# Start as background service on GX10
nohup python3 ~/Project/mcp-servers/image-gen-server.py \
  > ~/Project/mcp-servers/mcp-server.log 2>&1 &

# Or as a systemd service (persistent after reboot)
```

### 3d. Configure Claude Code on Remote Computer

Add to `~/.config/claude/claude.json` on the **remote computer**:

```json
{
  "mcpServers": {
    "gx10-image-gen": {
      "type": "http",
      "url": "http://100.73.84.27:8765/mcp"
    }
  }
}
```

> **Using Tailscale**: Replace `100.73.84.27` with the Tailscale IP or hostname `gx10-e6c5`.

After adding, restart Claude Code. The tools `generate_image`, `generate_video`, and `check_server_status` will appear as native Claude Code tools.

---

## 4. Option C — Direct ComfyUI API (No Setup Required)

ComfyUI's REST API is already accessible on the network. Claude Code can call it directly via bash/curl.

### 4a. ComfyUI is already network-accessible

```bash
# From any computer on LAN or Tailscale:
curl http://192.168.1.228:8188/system_stats       # LAN
curl http://100.73.84.27:8188/system_stats         # Tailscale
```

### 4b. Submit image generation workflow from remote

```python
# run from remote computer — generates image via ComfyUI on GX10
import requests, json, time

GX10 = "http://100.73.84.27:8188"  # Tailscale IP

workflow = {
    "1": {"class_type": "CheckpointLoaderSimple",
          "inputs": {"ckpt_name": "your_model.safetensors"}},
    # ... standard Stable Diffusion workflow nodes
}

r = requests.post(f"{GX10}/prompt", json={"prompt": workflow})
prompt_id = r.json()["prompt_id"]
print("Submitted:", prompt_id)
```

### 4c. Submit video generation from remote

```python
# Upload image and submit Wan2.2 video workflow remotely
import requests, json, time

GX10 = "http://100.73.84.27:8188"

# 1. Upload start image
with open("start_frame.jpg", "rb") as f:
    r = requests.post(f"{GX10}/upload/image",
        files={"image": ("start_frame.jpg", f, "image/jpeg")},
        data={"type": "input", "overwrite": "true"})
    
# 2. Load workflow template
with open("wan22_workflow.json") as f:
    workflow = json.load(f)
    
workflow["2"]["inputs"]["positive_prompt"] = "Your cinematic prompt here"

# 3. Submit
r = requests.post(f"{GX10}/prompt", json={"prompt": workflow})
prompt_id = r.json()["prompt_id"]

# 4. Poll
while True:
    hist = requests.get(f"{GX10}/history/{prompt_id}").json()
    if prompt_id in hist:
        if hist[prompt_id]["status"]["completed"]:
            fname = hist[prompt_id]["outputs"]["11"]["gifs"][0]["filename"]
            print(f"Done! File: {fname}")
            # Download the video
            # (use docker cp on GX10 side, or expose output folder via HTTP)
            break
    time.sleep(5)
```

---

## 5. Option D — SSH Direct (Simplest)

If Claude Code is on a machine with SSH access to GX10:

```bash
# Add to ~/.ssh/config on remote computer
Host gx10
  HostName 100.73.84.27      # Tailscale IP
  User yopitek
  IdentityFile ~/.ssh/id_ed25519

# Then in Claude Code bash tool:
ssh gx10 'gen-image "a futuristic robot in space"'
# Returns: IMAGE_PATH + DISCORD_MSG_ID
```

---

## 6. Tailscale Setup (If Remote Computer Not Yet Joined)

The GX10 is already on the `goolai@` tailnet. To add another computer:

```bash
# On the remote computer:
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --auth-key <your-tailscale-authkey>

# Verify GX10 is visible
tailscale status | grep gx10
# Should show: 100.73.84.27  gx10-e6c5  goolai@  linux
```

After joining, all GX10 services are accessible:
- Image API: `http://100.73.84.27:8080`
- ComfyUI: `http://100.73.84.27:8188`
- vLLM API: `http://100.73.84.27:8000`

---

## 7. Recommendation by Use Case

| Use Case | Best Option | Why |
|----------|-------------|-----|
| **Claude Code, native tools** | Option B (MCP) | First-class tool integration |
| **Claude Code, quick setup** | Option D (SSH) | Zero server setup needed |
| **Any AI agent** | Option A (CLI-Anything) | Universal, agent-first design |
| **Custom app / remote script** | Option C (Direct API) | Already works, no setup |
| **Team / multiple users** | Option B (MCP) | One server, many clients |

### Quickest Path (Works Right Now)

If your remote computer already has SSH access + Tailscale:

```bash
# On remote computer — test immediately
ssh gx10 'gen-image "test image of a mountain lake"'
```

For Claude Code integration with no server setup:
```bash
# claude.json on remote computer
{
  "mcpServers": {
    "gx10-ssh": {
      "type": "stdio",
      "command": "ssh",
      "args": ["gx10", "python3", "/home/yopitek/Project/mcp-servers/image-gen-server.py"]
    }
  }
}
```

---

## 8. Gemini Image API Reference

The Gemini image API runs at `http://GX10:8080`:

| Endpoint | Method | Body | Response |
|----------|--------|------|----------|
| `/health` | GET | — | `{"status":"ok","browser":"running"}` |
| `/generate` | POST | `{"prompt": "..."}` | JPEG image bytes or path |

```bash
# Test from remote (LAN)
curl -X POST http://192.168.1.228:8080/generate \
  -H "Content-Type: application/json" \
  -d '{"prompt": "a sunset over mountains, photorealistic"}' \
  --output generated.jpg
```

---

## 9. ComfyUI REST API Reference

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/system_stats` | GET | Server health + python version |
| `/object_info` | GET | All available node types |
| `/upload/image` | POST | Upload start image for I2V |
| `/prompt` | POST | Submit workflow → returns `prompt_id` |
| `/history/{id}` | GET | Poll job status + get output filename |
| `/queue` | GET | Current queue status |

---

## 10. Related Files

| File                           | Description                                 |
| ------------------------------ | ------------------------------------------- |
| `HW/machine.md`                | Full machine specs + all service details    |
| `HW/research_.md`              | Wan2.2 deep research                        |
| `/tmp/transformer_hq_api.json` | Working HQ video workflow (use as template) |
| `/tmp/hq_run.py`               | CLI runner script for video generation      |
| `~/.local/bin/gen-image`       | Image generation CLI (GX10 local)           |
| `~/Project/sparkyui/`          | ComfyUI Docker project                      |