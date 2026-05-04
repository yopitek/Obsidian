# Research Report: Hyperframes × ALFA APA-M04 — 30-Second Product Animation

---

## 1. What is Hyperframes?

**Hyperframes** (by HeyGen, Apache 2.0, fully open source) is a framework that lets you **write HTML → render MP4 video**. It is explicitly built for AI-agent-driven workflows.

- GitHub: https://github.com/heygen-com/hyperframes
- Docs: https://hyperframes.mintlify.app

### Core Philosophy
| Principle | Detail |
|-----------|--------|
| HTML-native | Compositions are plain HTML files + CSS + `data-*` attributes. No React, no DSL. |
| AI-first | CLI is non-interactive by default, designed for agent pipelines (Claude Code, Cursor, Gemini CLI) |
| Deterministic | Same HTML input = pixel-identical MP4 output every time |
| Frame Adapter | Bring any animation runtime: GSAP, Lottie, CSS, Three.js, AnimeJS, WAAPI |

### How It Works (3-Step Pipeline)
```
1. COMPOSE   →  Write HTML with data-* timing attributes + GSAP/CSS animations
2. PREVIEW   →  npx hyperframes preview  (live HMR browser preview at localhost:3000)
3. RENDER    →  npx hyperframes render   (headless Chrome → FFmpeg → output.mp4)
```

The engine loads your HTML in headless Chrome, seeks frame-by-frame (`frame = floor(time × fps)`), captures each frame, and streams it through FFmpeg for encoding.

### Key Concepts

#### Timed Elements (Clips)
Every element on screen must have:
```html
<div id="hero"
  class="clip"
  data-start="0"
  data-duration="5"
  data-track-index="0">
```

#### GSAP Animation (Required Pattern)
Timelines MUST be paused and registered on `window.__timelines`:
```javascript
const tl = gsap.timeline({ paused: true });
tl.from("#hero", { opacity: 0, y: -50, duration: 1 }, 0);
window.__timelines = window.__timelines || {};
window.__timelines["my-video"] = tl;
```

#### Stage / Root Element
```html
<div id="stage"
  data-composition-id="my-video"
  data-start="0"
  data-width="1920"
  data-height="1080">
```

### CLI Commands
| Command | Purpose |
|---------|---------|
| `npx hyperframes init my-project` | Scaffold new project (installs skills) |
| `npx hyperframes preview` | Live browser preview with HMR |
| `npx hyperframes render` | Render to MP4 in `./renders/` |
| `npx hyperframes render --quality draft` | Fast iteration render |
| `npx hyperframes lint` | Validate composition structure |
| `npx hyperframes add flash-through-white` | Add a shader transition block |
| `npx hyperframes add instagram-follow` | Add a social overlay block |
| `npx hyperframes tts` | Generate text-to-speech audio |
| `npx hyperframes transcribe` | Transcribe audio → captions |

### 50+ Ready-to-Use Blocks
- Shader transitions (flash-through-white, cinematic-zoom, whip-pan, etc.)
- Social overlays (Instagram follow, likes counter, etc.)
- Data visualizations (animated chart, bar race, etc.)
- Cinematic effects

### Claude Code Skills (Slash Commands)
After `npx hyperframes init`, skills are installed and register as Claude Code slash commands:
| Slash Command | Purpose |
|---------------|---------|
| `/hyperframes` | Composition authoring, timing, media, production workflow |
| `/hyperframes-cli` | CLI reference (init, add, lint, preview, render, tts) |
| `/gsap` | GSAP animation: timelines, easing, stagger, plugins |
| `/tailwind` | Tailwind v4 browser-runtime styles |
| `/lottie` | Lottie adapter animations |
| `/three` | Three.js adapter |
| `/css-animations` | Pure CSS animation patterns |
| `/animejs` | AnimeJS adapter |
| `/waapi` | Web Animations API adapter |

---

## 2. Product: ALFA Network APA-M04

**Product Name:** APA-M04 — 2.4 GHz Indoor Panel Antenna  
**Manufacturer:** ALFA Network Inc. (台灣，Taipei)  
**Product URL:** https://www.alfa.com.tw/products/apa-m04

### Full Technical Specifications
| Spec | Value |
|------|-------|
| Model | APA-M04 |
| Frequency Range | 2.4 GHz ~ 2.5 GHz (2400~2500 MHz) |
| Gain | **7 dBi** |
| Antenna Type | **Directional Panel Antenna** |
| VSWR | ≤ 2.0 |
| Polarization | Linear, Vertical |
| Impedance | 50 Ω |
| Connector | **RP-SMA Male (PR-SMA PLUG)** |
| Operating Temperature | -10°C ~ +55°C |
| Humidity | 95% @ 25°C |
| Dimensions | **120 × 90 × 15 mm** |
| Wi-Fi Standards | 802.11b/g/n (SISO 1×1) |
| Use Case | **Indoor** (light-duty outdoor out of direct sunlight is acceptable) |

### What It Does
- **Upgrades Wi-Fi signal** by replacing the stock omnidirectional antenna on routers, USB adapters, APs, VOIP devices, or PCI cards
- **Directional focus**: concentrates 7 dBi gain in one direction (ALFA logo side faces the signal source)
- **Easy install**: twist off factory antenna → twist on APA-M04 (RP-SMA screw-on)
- Compatible with ALFA Network USB adapters, drones (3DR Solo, DJI Phantom 3, Yuneec Typhoon H), and any RP-SMA device
- Engineer-tested for performance vs competing directionals

### Directional vs Omni — Key Selling Point
> Omnidirectional antennas see signals from all directions but are weaker in any single direction.  
> The APA-M04 **concentrates gain toward the target**, delivering stronger signal to the source it's aimed at — ideal when you know where the AP/router is.

### Brand Context
ALFA Network is a **Taiwanese brand** trusted by Wi-Fi professionals worldwide, known for high-gain wireless adapters and antennas. The APA-M04 is a flagship entry-level panel antenna in their lineup.

---

## 3. How to Start With Claude Code CLI

### Prerequisites
- Node.js installed (LTS)
- FFmpeg installed (`brew install ffmpeg` on macOS)
- Claude Code CLI installed (`npm install -g @anthropic-ai/claude-code`)

### Step-by-Step Setup

#### Step 1 — Clone your existing hyperframes repo
```bash
cd /Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/HQ/10_resources/04_Video_Director/
# The hyperframes folder is already cloned here
cd hyperframes
```

#### Step 2 — Install dependencies and skills
```bash
npm install
# Skills are auto-installed; they register as /hyperframes slash commands in Claude Code
```

#### Step 3 — Initialize your product video project
```bash
npx hyperframes init alfa-apa-m04-promo
cd alfa-apa-m04-promo
```

#### Step 4 — Launch Claude Code in this directory
```bash
claude  # Opens Claude Code CLI in the project folder
```

#### Step 5 — Give Claude Code this exact prompt
```
/hyperframes Create a 30-second 1920×1080 product promo video for the ALFA Network APA-M04 antenna.

Product facts:
- 7 dBi gain directional panel antenna
- 2.4 GHz indoor use
- RP-SMA Male connector
- Dimensions: 120×90×15mm
- Replaces stock antennas on routers/adapters
- Works with drones (DJI Phantom 3, 3DR Solo)
- ALFA Network brand (trusted Taiwanese networking brand)
- Key message: "Point. Connect. Dominate."

Video structure (30 seconds total):
- Scene 1 (0–5s): Hook — Wi-Fi signal struggling, weak bars, frustration
- Scene 2 (5–10s): Product reveal — APA-M04 slides in, brand name animates
- Scene 3 (10–18s): Spec showcase — 7dBi, 2.4GHz, directional beam animation
- Scene 4 (18–24s): Use cases — router upgrade, drone range extension
- Scene 5 (24–30s): CTA — "Upgrade Your Signal" + alfa.com.tw

Use GSAP for all animations. Add a shader transition between scene 2 and 3.
Style: dark/tech, electric blue accent (#0066FF), white text, clean and modern.
```

#### Step 6 — Preview and iterate
```bash
npx hyperframes preview   # Opens at http://localhost:3000
# Edit index.html as Claude Code suggests
# Browser hot-reloads on save
```

#### Step 7 — Render final MP4
```bash
npx hyperframes render
# Output: ./renders/output.mp4
```

---

## 4. Recommended 30-Second Scene Structure

| Time | Scene | Animation | Content |
|------|-------|-----------|---------|
| 0–5s | **Hook** | Signal bars fading in/out weak, CSS pulse | "Your Wi-Fi is losing the battle" |
| 5–10s | **Product Reveal** | GSAP slide-up + scale, glow effect | APA-M04 product image, ALFA logo fade in |
| 10–18s | **Spec Showcase** | Directional beam SVG animation (Three.js or CSS) | 7 dBi, 2.4 GHz, 120×90mm, RP-SMA |
| 18–24s | **Use Cases** | Card flip animations, icons | Router upgrade / Drone range / USB adapter |
| 24–30s | **CTA** | Text slam + underline reveal | "Upgrade Your Signal" + alfa.com.tw |

**Transitions:** Use `flash-through-white` shader between scenes 2→3, `cinematic-zoom` for scene 4→5.

---

## 5. Tips for Best Results

1. **Always run `/hyperframes` first** in Claude Code before asking it to write any composition — this loads the skill context and prevents structural errors
2. **Lint before render**: `npx hyperframes lint` catches missing `class="clip"`, wrong `data-track-index`, etc.
3. **Use `--quality draft`** for quick iteration: `npx hyperframes render --quality draft`
4. **Animation map**: After authoring, run `node skills/hyperframes/scripts/animation-map.mjs <comp-dir>` to verify choreography
5. **GSAP timeline MUST be paused**: `gsap.timeline({ paused: true })` — if not paused, the render engine can't seek frames
6. **Track indices must not overlap in time** — each simultaneous layer needs a different `data-track-index`
7. **Product images**: Download from alfa.com.tw or use SVG representations of the antenna for clean animation

---

## 6. Files To Produce

```
alfa-apa-m04-promo/
├── index.html          ← Root composition (30s timeline)
├── compositions/
│   ├── scene-hook.html
│   ├── scene-reveal.html
│   ├── scene-specs.html
│   ├── scene-usecases.html
│   └── scene-cta.html
├── assets/
│   ├── apa-m04.png     ← Product image
│   └── alfa-logo.svg   ← Brand logo
└── renders/
    └── output.mp4      ← Final rendered video
```

---

*Research compiled: May 2026*  
*Sources: github.com/heygen-com/hyperframes, hyperframes.mintlify.app, alfa.com.tw, rokland.com, alfadistribution.com*
