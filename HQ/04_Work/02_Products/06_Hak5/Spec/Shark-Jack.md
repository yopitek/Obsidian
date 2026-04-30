---
title: Shark Jack
model: Shark Jack / Shark Jack Cable
category: Network Attack Tool
tags: [hak5, ethernet, linux, payload, duckyscript, cloud-c2, recon, portable]
shop_url: https://shop.hak5.org/products/shark-jack
docs_url: https://docs.hak5.org/shark-jack/
captured_at: 2026-04-16
---

# Shark Jack

> Pocket-sized pentest box. Network recon in seconds with the flick of a switch.

## Overview

The Shark Jack is a pocket-sized Linux device that performs network assessments instantly. Plug it into any Ethernet port, flip the switch, and it runs DuckyScript™ payloads powered by Bash. Armed out-of-the-box with an ultra-fast network scanner and Cloud C² support.

## Variants

| Variant | Interface | Notes |
|---------|-----------|-------|
| Shark Jack | Ethernet | Core device |
| Shark Jack Cable | Ethernet + USB-C Serial (CP2102) | Live shell access |

## Specifications

### Shark Jack
| Spec | Value |
|------|-------|
| **SOC** | MT7628DAN |
| **Interface** | Ethernet |
| **Standards** | 802.3 |
| **Size** | 62 × 21 × 12 mm |
| **Power** | 2.5W (USB 5V 0.5A) |
| **Battery** | 1S 401020 3.7V 50mAh 0.2W LiPo |
| **Operating Temp** | 35°C ~ 45°C |
| **Storage Temp** | -20°C ~ 50°C |
| **Humidity** | 0% to 90% (non-condensing) |

### Shark Jack Cable (additions)
| Spec | Value |
|------|-------|
| **Interface** | Ethernet + USB UART (CP2102) |
| **Battery** | None (USB-C powered) |

## Key Features

- **Instant Recon** — Built-in ultra-fast network scanner activated with switch flip
- **DuckyScript™ Payloads** — Written in Bash; run network tools (nmap, etc.)
- **Cloud C² Enabled** — Gather loot, exfiltrate, interact with payloads, drop into Linux shell via web
- **RGB LED Feedback** — Visual payload status
- **Arming Mode** — Flip to arming mode to sync with online payload library
- **Linux Core** — Root SSH access; familiar CLI network utilities

## Use Cases

- Network reconnaissance on physical engagements
- Remote access and exfiltration
- Automated network payloads
- Opportunistic wired network attacks

## DuckyScript Commands

- `NETMODE` — Set network mode
- `LED` — Control RGB LED
- `SWITCH` — Detect switch position
- `BATTERY` — Check battery level
- `SERIAL_WRITE` — Output to serial
- Cloud C² integration commands

## Documentation

- [Official Docs](https://docs.hak5.org/shark-jack/)
- [Shop Page](https://shop.hak5.org/products/shark-jack)
