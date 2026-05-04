---
model: WiFi Devboard
brand: Flipper Devices
category: Expansion Module
sku: FLP-M-WIFI
price_usd: 35
chipset: ESP32-S2
connectivity: [WiFi, USB-C]
compatibility: Flipper Zero
open_source: true
status: Active
tags: [flipper, wifi, esp32, devboard, expansion, pentest]
---

# WiFi Devboard for Flipper Zero
## ESP32-S2 Based WiFi Expansion Module

### Overview
Developer board with WiFi connectivity based on the ESP32-S2 module. Plugs directly into Flipper Zero's GPIO header and enables wireless firmware updates over the air and advanced in-circuit debugging via USB or WiFi using the open-source Black Magic Probe project.

---

### Technical Specifications

| Parameter | Value |
|---|---|
| SKU | FLP-M-WIFI |
| Chipset | Espressif ESP32-S2 |
| WiFi Standard | IEEE 802.11 b/g/n (2.4 GHz) |
| USB Interface | USB-C (direct to ESP32-S2) |
| GPIO Connection | Flipper Zero 18-pin GPIO header |
| Debugging | Black Magic Probe (open-source) via USB or WiFi |
| OTA Update | Wireless Flipper Zero firmware update |
| Firmware | Open-source |

---

### Key Features

| Feature | Status |
|---|---|
| Wireless OTA Firmware Update | ✅ |
| In-Circuit Debugging (USB) | ✅ |
| In-Circuit Debugging (WiFi) | ✅ |
| Black Magic Probe Support | ✅ |
| WiFi Pentest Capabilities | ⚠️ Must be implemented additionally |
| Standalone Operation | ⚠️ Requires Flipper Zero host |

---

### Compatibility

| Item | Details |
|---|---|
| Required Device | Flipper Zero (sold separately) |
| Connection | Plugs into GPIO header — no soldering needed |
| Firmware Source | Flipper Zero official + community forks |

---

### In the Box
- 1× WiFi Devboard (ESP32-S2)

---

### Resources

| Resource | Link |
|---|---|
| Official Product Page | https://flipper.net/products/wifi-devboard |
| Documentation | https://docs.flipper.net/development/hardware/wifi-debugger |
| Firmware (GitHub) | https://github.com/flipperdevices/blackmagic-esp32-s2 |
