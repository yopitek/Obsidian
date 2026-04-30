---
title: Key Croc
model: Key Croc
category: Keylogger / Pentest Implant
tags: [hak5, usb, keylogger, hid, ethernet, storage, serial, duckyscript, cloud-c2]
shop_url: https://shop.hak5.org/products/key-croc
docs_url: https://docs.hak5.org/key-croc/
captured_at: 2026-04-16
---

# Key Croc

> More than just a keylogger — a full pentest implant that triggers active payloads when target keywords are typed.

## Overview

The Key Croc is a smart keylogger and pentest implant. It sits inline between a USB keyboard and a computer, recording all keystrokes while passively monitoring for keyword patterns. When a match is found (even accounting for typos/backspaces), it triggers a DuckyScript™ payload. Supports multi-vector attacks via HID, Ethernet, Storage, and Serial emulation.

## Specifications

| Spec | Value |
|------|-------|
| **Interface** | USB |
| **Standards** | USB 2.0 |
| **Frequency Range** | 2.412 ~ 2.4835 GHz |
| **Size** | 74 × 27 × 14 mm |
| **Power** | 5W (USB 5V 1A) |
| **CPU** | Quad-core 1.2 GHz ARM |
| **Storage** | 8 GB desktop-class SSD |
| **Operating Temp** | 35°C ~ 45°C |
| **Storage Temp** | -20°C ~ 50°C |
| **Humidity** | 0% to 90% (non-condensing) |

## Key Features

### Pattern Matching Payloads
- Triggers on keywords or advanced regular expressions
- Handles typos (backspace-tolerant matching)
- Captures keystrokes before/after match
- Use captured keystrokes in Cloud C² notifications or active payloads

### Multi-Vector USB Attacks
- **HID** — Keystroke injection passthrough
- **Ethernet** — Network access to target
- **Storage** — Present as USB flash drive
- **Serial** — Serial device emulation

### Remote Access
- **Cloud C²** — Watch keystrokes in real-time, inject keystrokes live, manage payloads, get root shell from browser
- **WiFi** — Built-in 2.4 GHz for Cloud C² connectivity

### Simple Configuration
- Auto-clones keyboard hardware IDs
- Hidden arming button → flash drive mode → drag-and-drop log access
- Settings via plain text file editing

## Use Cases

- Credential capture (login sequences, passwords)
- Lock-screen sequence detection
- Automated exfiltration after credential capture
- Network infiltration via USB Ethernet emulation
- Live remote pentest operations via Cloud C²

## Payload Tools Available

- nmap, Responder, Impacket, Metasploit (via full Linux base)

## Documentation

- [Official Docs](https://docs.hak5.org/key-croc/)
- [Shop Page](https://shop.hak5.org/products/key-croc)
