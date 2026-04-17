---
title: Screen Crab
model: Screen Crab
category: Video Capture Implant
tags: [hak5, hdmi, screen-capture, mitm, wifi, cloud-c2, microsd, stealth]
shop_url: https://shop.hak5.org/products/screen-crab
docs_url: https://docs.hak5.org/screen-crab/
captured_at: 2026-04-16
---

# Screen Crab

> A stealthy video man-in-the-middle implant that captures everything on screen.

## Overview

The Screen Crab is a covert inline HDMI screen grabber. It sits between any HDMI source and display (computer/monitor, console/TV) and quietly captures screenshots or video. WiFi-enabled for live streaming to Cloud C².

## Specifications

| Spec | Value |
|------|-------|
| **Interface** | HDMI, USB, MicroSD |
| **Standards** | HDMI 1.4 / DVI 1.0, 802.11 b/g/n |
| **WiFi** | 2.4 GHz (2.412 ~ 2.4835 GHz) |
| **Max Resolution** | Up to 1920×1080 (most 16:9 resolutions below) |
| **Size** | 105 × 51 × 21 mm |
| **Power** | 5W (USB 5V 1A) |
| **Storage** | MicroSD card (user-supplied) |
| **Operating Temp** | 35°C ~ 45°C |
| **Storage Temp** | -20°C ~ 50°C |
| **Humidity** | 0% to 90% (non-condensing) |

## Key Features

- **Inline HDMI Capture** — Plugs between any HDMI source and display, fully transparent
- **Screenshot & Video Modes** — Configurable capture type
- **MicroSD Storage** — Captures saved locally; configurable loop (delete oldest or stop when full)
- **WiFi + Cloud C²** — Stream screenshots live from anywhere; manage settings remotely
- **Simple Configuration** — Auto-generated `config.txt` on MicroSD; edit plain text to change settings
- **LED & Button Control** — Disable LED; button configurable
- **Zero Setup Out-of-Box** — Works immediately with MicroSD inserted

## Configuration Options (config.txt)

- Capture mode: `image` or `video`
- Capture interval (seconds)
- Storage behavior: loop (overwrite) or stop when full
- WiFi SSID/password
- Cloud C² device file path
- LED enable/disable
- Button enable/disable

## Use Cases

- Covert screen monitoring during physical engagements
- Screenshot capture between sessions
- Sysadmin remote screen monitoring
- Console/kiosk screen recording
- Live surveillance via Cloud C²

## Getting Started

1. Insert MicroSD card
2. Connect HDMI source → Screen Crab → Display
3. Connect USB power
4. Captures begin immediately to MicroSD

## Cloud C² Setup

1. Add WiFi credentials to `config.txt`
2. Copy Cloud C² device provisioning file to MicroSD
3. Access live screenshot stream from Cloud C² web interface

## Documentation

- [Official Docs](https://docs.hak5.org/screen-crab/)
- [Shop Page](https://shop.hak5.org/products/screen-crab)
