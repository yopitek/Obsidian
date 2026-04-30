# ALFA AWUS036AXML — PowerPoint Outline & Prompt Guide
**Product:** ALFA Network AWUS036AXML USB WiFi Adapter  
**Style:** Technology & Innovation / Dell Alienware Dark Theme  
**Language:** English  
**Images:** Must use original ALFA AWUS036AXML product photos  

---

## ✅ OUTLINE REVIEW — Additions & Suggestions

### 🔴 Missing / Recommended Additions

| # | Gap Identified | Recommended Slide |
|---|---------------|-------------------|
| A | No chipset/hardware core info | Add chipset callout to specs or cover |
| B | No competitive comparison | Add "vs. Competitors" slide (AWUS036ACM, Panda, TP-Link) |
| C | No warranty / support info | Add "Where to Buy & Support" or closing CTA slide |
| D | Step 9 is missing (numbered 7,8,10,11 — gap at 9) | Add or renumber |
| E | "Fusion" term undefined | Clarify: is this "SoftAP + Monitor simultaneous"? Define per OS section |
| F | No Bluetooth detail slide | Bluetooth 5.2 coexistence deserves its own callout row in Advanced Capabilities |
| G | No package contents slide | Add "What's in the Box" (adapter, USB-C cable, driver CD/link) |
| H | No QR code / resource links | Add closing slide with QR → Kali driver repo, ALFA GitHub, docs |

---

## 📋 COMPLETE REVISED SLIDE STRUCTURE (14 Slides + Cover)

---

### Slide 01 — HERO COVER
- **Product name:** ALFA Network AWUS036AXML
- **Tagline:** "WiFi 6E Tri-Band USB Adapter — Built for Hackers, Made for Everyone"
- **Badges:** Kali Linux Official Support · WiFi 6E · USB-C 3.0
- **Visual:** Full-bleed dark background, product hero shot, glowing cyan/green accent
- **Sub-elements:** ALFA logo, model number, chipset name (MT7921AUN)

---

### Slide 02 — 6 Core Product Features (Radial / Spider Chart)
**6 Axes:**
1. Speed & Bandwidth (WiFi 6E, tri-band, up to 2.4 Gbps)
2. Security Research (Monitor Mode + Packet Injection)
3. Compatibility (5 OS × 4 hardware platforms)
4. Connectivity (USB-C 3.0, backward compatible)
5. Range & Signal (high-gain antenna, OFDMA, MU-MIMO)
6. Advanced Modes (SoftAP, VIF, Bluetooth 5.2 coexistence)

> ⚠️ **Suggestion:** Add numeric ratings (e.g. 1–10) per axis so the radar chart has actual data to render. Use comparison axis against previous gen AWUS036ACM if available.

---

### Slide 03 — Full Specifications Table
| Category | Specification |
|----------|--------------|
| Chipset | MediaTek MT7921AUN |
| WiFi Standard | IEEE 802.11ax/ac/n/a/b/g (WiFi 6E) |
| Frequency Bands | 2.4 GHz / 5 GHz / 6 GHz |
| Max Data Rate | 2.4G: 574 Mbps · 5G: 2402 Mbps · 6G: 2402 Mbps |
| Interface | USB Type-C 3.0 (USB 2.0 backward compatible) |
| Antenna | Internal high-gain antenna |
| Security | WPA3 / WPA2 / WPA / WEP |
| OS Support | Windows 10/11, macOS, Ubuntu, Kali Linux, Android |
| Special Modes | Monitor Mode, Packet Injection, SoftAP, VIF |
| Bluetooth | BT 5.2 coexistence |
| Power | Bus-powered via USB |
| Dimensions | (fill from official spec sheet) |

---

### Slide 04 — Speed Rate Dashboard (Gauge / Infographic)
- Three speedometer gauges: 2.4 GHz → 5 GHz → 6 GHz
- Visual hierarchy: 6 GHz as the "hero" speed
- Compare to WiFi 5 (802.11ac) baseline for context
- Real-world vs. theoretical labels

> ⚠️ **Suggestion:** Add latency metric if available. Show channel width: 20/40/80/160 MHz support.

---

### Slide 05 — Hardware Compatibility
**4 Platform Cards:**
1. 🥧 Raspberry Pi 3B+ / 4 / 5
2. 💻 Desktop / Laptop PC (Windows & Linux)
3. 🍎 Mac — Intel (x86_64)
4. 🍎 Mac — ARM (Apple Silicon M1/M2/M3)

> ⚠️ **Suggestion:** Note USB-C OTG capability → Android phone support (ties into NetHunter slide).

---

### Slide 06 — OS Support Matrix
| OS | Version | Status |
|----|---------|--------|
| Windows | 10 / 11 | ✅ Plug & Play |
| macOS | 10.15 Catalina → Sonoma | ✅ Driver required |
| Ubuntu | 22.04 / 24.04 LTS | ✅ DKMS driver |
| Kali Linux | Rolling (2023.x+) | ✅ Official Support |
| Nethunter | Android (rooted) | ✅ OTG supported |

> ⚠️ **Suggestion:** Add Parrot OS and Arch Linux as "community supported" row.

---

### Slide 07 — Advanced Capabilities
**5 Feature Cards:**
| Feature | Description |
|---------|-------------|
| 📡 Monitor Mode | Passive capture of all 802.11 frames on any channel |
| 💉 Packet Injection | Active frame injection for penetration testing |
| 📶 Soft AP Mode | Turn adapter into a wireless access point |
| 🔵 Bluetooth 5.2 | BT coexistence on 2.4 GHz band |
| 🔀 VIF (Virtual Interface) | Simultaneous multi-mode operation |

> ⚠️ **Suggestion:** Add "Concurrent Monitor + AP" (Fusion Mode) as a 6th capability card.

---


---

### Slide 08 — Target Audience × Use Cases
**3-Column Layout:**
| Audience | Use Case | Why AWUS036AXML |
|----------|----------|-----------------|
| Penetration Testers | WiFi auditing, WPA handshake capture | Monitor Mode + Injection |
| CTF / Security Students | Lab environments, Kali Linux setups | Official Kali support |
| Network Engineers | Site surveys, signal analysis | Tri-band, OFDMA |
| Home Power Users | Fast WiFi 6E on older machines | Up to 2.4 Gbps |
| Raspberry Pi Makers | Portable AP, IoT projects | Low power USB bus |
| Android Hackers | Mobile pen-test with NetHunter | USB-C OTG |

---

### Slide 9 — Step-by-Step: Kali Linux
**Sections:**
1. Driver Installation (apt / git clone / DKMS)
2. Enable Monitor Mode (`airmon-ng start wlan0`)
3. Packet Injection Test (`aireplay-ng --test`)
4. Fusion Mode (simultaneous monitor + SoftAP)

> Code blocks with syntax highlighting style recommended.

---

### Slide 10 — Step-by-Step: Ubuntu 22.04 / 24.04
**Sections:**
1. Driver Installation (DKMS or manual compile)
2. Enable Monitor Mode
3. Packet Injection
4. Fusion / VIF setup

---

### Slide 11 — Step-by-Step: Debian
**Sections:**
1. Driver Installation
2. Enable Monitor Mode
3. Packet Injection
4. Fusion / VIF setup

---

### Slide 12 — Step-by-Step: Raspberry Pi 4B / 5
**Sections:**
1. Driver Installation (armhf / arm64 build)
2. Headless AP setup
3. Cross-compile notes (if applicable)

> ⚠️ **Suggestion:** Add Raspberry Pi OS (Bookworm) specific notes since it differs from Debian x86.

---

### Slide 13 — *(NEW)* Competitive Comparison
| Feature | AWUS036AXML | AWUS036ACM | TP-Link AC600 | Panda PAU09 |
|---------|-------------|------------|--------------|-------------|
| WiFi Standard | WiFi 6E | WiFi 5 | WiFi 5 | WiFi 5 |
| Max Speed | 2402 Mbps | 867 Mbps | 433 Mbps | 300 Mbps |
| 6 GHz Band | ✅ | ❌ | ❌ | ❌ |
| Monitor Mode | ✅ | ✅ | ❌ | ✅ |
| Packet Injection | ✅ | ✅ | ❌ | ✅ |
| Kali Official | ✅ | ✅ | ❌ | ❌ |
| Interface | USB-C 3.0 | USB-A | USB-A | USB-A |

---

---

## 🔧 Design Notes for NotebookLM / Generation System

```
Style:       Dark technology theme (Dell Alienware aesthetic)
Background:  Deep navy / near-black (#050B18 to #0D1B2A)
Accent 1:    Electric cyan (#00D4FF)
Accent 2:    Alien green (#39FF14)
Font:        Headers: Arial Black / Impact | Body: Calibri Light
Images:      MUST use original ALFA AWUS036AXML product photography
Layout:      16:9 widescreen
Code blocks: Monospace font, dark background, syntax color
```

---

## 📝 Prompt Template for NotebookLM

Use the following prompt when feeding spec sheets into NotebookLM:

> "Based on the attached specification documents, generate detailed content for each slide in the ALFA AWUS036AXML product presentation. For technical slides (specs table, speed dashboard, step-by-step guides), extract exact values from the spec sheet. For marketing slides (hero cover, target audience, use cases), write in a professional yet engaging tone targeting cybersecurity professionals and network engineers. All content must be in English."

---

*Last reviewed: 2026-04-24*
*Product: ALFA Network AWUS036AXML*
