# Gemini Web Image Generation Skill

Generate high-quality images using the Gemini Web interface via a local Playwright API server. This skill bridges the gap between CLI automation and the premium "Pro Mode" image generation features of Gemini Web.

## 🛠 Prerequisites & Dependencies

This skill relies on a local Mac-specific automation stack. Before generating images, ensure these components are available:

1.  **API Server Script**: `/Users/goooolai/gemini_api_server_mac.py`
    - A FastAPI + Playwright server that controls a Chromium instance.
2.  **Login Helper Script**: `/Users/goooolai/gemini_login_mac.py`
    - Used to manually prime the browser session and cookies.
3.  **Profile Directory**: `/Users/goooolai/.gemini-playwright-profile`
    - Stores authenticated session data.
4.  **Runtime**: Python 3.x with `fastapi`, `uvicorn`, and `playwright` installed.

## 🚀 Execution Workflow

### Step 1: Verification & Startup
Before any generation attempt, verify if the server is running.

```bash
# Check server health
curl -s http://localhost:8080/health || echo "Server not running"
```

If the server is NOT running, you must start it in the background and wait for the browser to initialize:

```bash
python3 /Users/goooolai/gemini_api_server_mac.py > /tmp/gemini_server.log 2>&1 &
# Wait at least 60 seconds for browser startup and login verification
sleep 60
```

### Step 2: Authentication Check
If the server logs indicate session expiration or login issues, guide the user to run the login helper:
`python3 ~/gemini_login_mac.py`

### Step 3: Image Generation
Send a POST request to the local API server.

**API Endpoint**: `http://localhost:8080/generate`
**Method**: `POST`
**Headers**: `Content-Type: application/json`

#### Request Payload Schema
```json
{
  "prompt": "Detailed AI Prompt (string)",
  "output_dir": "Absolute path to save images (string)",
  "reference_image": "Optional: Absolute path to a reference image (string)"
}
```

**Example Curl Command**:
```bash
curl -X POST http://localhost:8080/generate \
     -H "Content-Type: application/json" \
     -d '{
           "prompt": "Create a high-end luxury product shot...",
           "output_dir": "/path/to/project/images",
           "reference_image": "/path/to/reference/product.png"
         }'
```

## 🎨 Best Practices for Prompts

- **Product Consistency**: Always include the `--reference-image` path if provided by the user. Instruct the model to keep the product in the reference image **exactly unchanged**.
- **Style Keywords**: Use descriptive keywords to steer the aesthetic (e.g., "Quiet Luxury", "Fashion Editorial", "Dark Cyberpunk", "Hacker UI").
- **Typography**: Specify "Traditional Chinese" (繁體中文) and provide exact text strings in quotes (e.g., 「Text Here」) to improve rendering accuracy.
- **Aspect Ratio**: Default to square (800x800) unless specified otherwise.

## 📁 File Organization
- Keep output directories organized by project or date.
- The server will generate filenames in the format `gemini_[timestamp].jpeg`.

## ⚠️ Troubleshooting
- **Connection Refused (Exit Code 7)**: The server is likely still starting up or crashed. Increase sleep time or check `/tmp/gemini_server.log`.
- **No Image Returned**: Check the browser context. The server uses the native Mac display context (`--headless=False`); ensure the user is not interfering with the automated window.
- **Pro Mode Timeout**: Gemini can take 30s-180s to generate complex images. Ensure your timeout settings (e.g., in curl) are sufficient.
