---
model: AWUS036AXER
brand: ALFA Network
category: USB WiFi Adapter
wifi_gen: WiFi 6
chipset: Realtek RTL8832BU
max_speed_mbps: 1800
usb_type: USB-A 3.2 Gen1
antenna: Integrated (nano)
bluetooth: false
monitor_mode: limited
kali_linux: limited
linux_driver: out-of-kernel (<6.14)
dimensions_mm: 65x24x10
weight_g: 10
status: Active
tags: [alfa, usb-adapter, wifi6, nano, travel, windows]
---

# AWUS036AXER
## WiFi 6 Nano Dual-Band USB 3.2 Adapter

### Overview
Ultra-compact nano WiFi 6 dongle — near-invisible in USB port. Same RTL8832BU chipset as AWUS036AX in dramatically smaller enclosure. 1800 Mbps, ~10g. Purpose-built for Windows travel users.

> ⚠️ No RP-SMA port — antenna cannot be upgraded.  
> ⚠️ Not recommended for Linux security research or Kali Linux.

---

### Technical Specifications

| Parameter | Value |
|---|---|
| Chipset | Realtek RTL8832BU |
| WiFi Standards | IEEE 802.11 a/b/g/n/ac/ax (WiFi 6) |
| Frequency Bands | 2.4 GHz (573 Mbps) · 5 GHz (1200 Mbps) |
| Combined Max Speed | 1800 Mbps |
| Antenna | Integrated (no external connector) |
| USB Interface | USB 3.2 Gen 1 Type-A |
| Dimensions | Approx. 65 × 24 × 10 mm |
| Weight | Approx. 10 g |
| Wireless Security | WPA3 / WPA2 / WPA / WEP |
| Country of Origin | Taiwan |

---

### OS Support

| OS | Status | Notes |
|---|---|---|
| Windows 10 / 11 | ✅ | Driver from Alfa website |
| macOS | ❌ | No macOS 11+ or Apple Silicon |
| Ubuntu | ⚠️ | In-kernel on kernel ≥ 6.14; earlier needs manual install |
| Kali Linux | ⚠️ | Not recommended for monitor mode / security testing |
| NetHunter | ⚠️ | Limited data |
| Raspberry Pi 4/5 | ⚠️ | Manual install needed on older kernels |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ⚠️ Limited |
| Packet Injection | ⚠️ Limited |
| Soft AP Mode | ✅ |
| Bluetooth | ❌ |

---

### Resources
| Resource | Link |
|---|---|
| Documentation | https://docs.alfa.com.tw/ |
| Linux Driver (RTL8832BU) | https://github.com/morrownr/rtl8852bu-20240418 |
