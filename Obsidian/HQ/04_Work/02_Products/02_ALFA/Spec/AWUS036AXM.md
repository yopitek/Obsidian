---
model: AWUS036AXM
brand: ALFA Network
category: USB WiFi Adapter
wifi_gen: WiFi 6E
chipset: MediaTek MT7921AUN
max_speed_mbps: 3000
usb_type: USB-A 3.2 Gen1 (L-elbow)
antenna: 2x RP-SMA 5dBi detachable
bluetooth: "5.2"
monitor_mode: true
kali_linux: true
linux_driver: in-kernel (mt7921u ≥5.18)
status: Active
tags: [alfa, usb-adapter, wifi6e, linux, kali, bluetooth, dual-antenna]
---

# AWUS036AXM
## WiFi 6E Tri-Band USB-A Adapter with Dual Antennas & Bluetooth 5.2

### Overview
Same MT7921AUN chipset as the AXML but with USB-A and two external 5 dBi antennas for improved coverage. L-shaped connector prevents blocking adjacent USB ports. Best for WiFi 6E with dual-antenna coverage + Linux.

> ⚠️ macOS 11+ and Apple Silicon NOT supported.

---

### Technical Specifications

| Parameter | Value |
|---|---|
| Chipset | MediaTek MT7921AUN |
| WiFi Standards | IEEE 802.11 a/b/g/n/ac/ax (WiFi 6E) |
| Frequency Bands | 2.4 GHz · 5 GHz · 6 GHz |
| Max Data Rate | 2.4 GHz: 600 Mbps · 5 GHz: 1200 Mbps · 6 GHz: 1200 Mbps |
| Combined Max Speed | 3000 Mbps |
| Bluetooth | BT 5.2 (integrated antenna) |
| Antenna Connectors | 2× RP-SMA female (detachable) |
| Included Antennas | 2× dual-band dipole, 5 dBi |
| USB Interface | USB 3.2 Gen 1 Type-A L-elbow (5 Gbps) |
| LED Indicator | Yes (WLAN + BT status) |
| Wireless Security | WPA3 / WPA2 / WPA / WEP / WPS |
| Country of Origin | Taiwan |

---

### OS Support

| OS | Status | Notes |
|---|---|---|
| Windows 10 | ✅ | 2.4 + 5 GHz only |
| Windows 11 | ✅ | Full tri-band incl. 6 GHz |
| macOS | ❌ | No macOS 11+ or Apple Silicon |
| Ubuntu | ✅ | In-kernel mt7921u (kernel ≥ 5.18) |
| Kali Linux | ✅ | Monitor mode + packet injection supported |
| NetHunter | ⚠️ | OTG; kernel-dependent |
| Raspberry Pi 3B+/4/5 | ✅ | Updated Pi OS (kernel ≥ 5.18) |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ✅ |
| Packet Injection | ✅ |
| Soft AP Mode | ✅ |
| Bluetooth | ✅ BT 5.2 |
| VIF | ✅ |

---

### In the Box
- 1× AWUS036AXM adapter (L-elbow USB-A)
- 2× Detachable 5 dBi dipole antennas
- Quick setup guide

---

### Resources
| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036axm |
| Documentation | https://docs.alfa.com.tw/ |
| Linux Driver | mt7921u — in-kernel ≥ 5.18 |
