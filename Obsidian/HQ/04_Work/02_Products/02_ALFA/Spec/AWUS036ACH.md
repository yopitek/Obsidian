---
model: AWUS036ACH
brand: ALFA Network
category: USB WiFi Adapter
wifi_gen: WiFi 5
chipset: Realtek RTL8812AU
max_speed_mbps: 867
usb_type: USB-C 3.0
antenna: 2x RP-SMA 5dBi detachable
bluetooth: false
monitor_mode: excellent
kali_linux: excellent
linux_driver: out-of-kernel (in-kernel ≥6.14)
power_amplifier: true
status: Active
tags: [alfa, usb-adapter, wifi5, kali, pentest, monitor-mode, gold-standard]
---

# AWUS036ACH
## WiFi 5 AC1200 Dual-Band USB-C Adapter — Kali Linux Gold Standard

### Overview
Alfa's most iconic security research adapter — the gold standard for Kali Linux penetration testing since 2017. RTL8812AU chipset with built-in power amplifier, two 5 dBi antennas, and world's first WiFi 5 USB-C connector. Community-proven monitor mode and packet injection since Kali 2017.1.

---

### Technical Specifications

| Parameter | Value |
|---|---|
| Chipset | Realtek RTL8812AU |
| WiFi Standards | IEEE 802.11 a/b/g/n/ac (WiFi 5) |
| Frequency Bands | 2.4 GHz + 5 GHz |
| Max Data Rate | 802.11b: 11 Mbps · 802.11a/g: 54 Mbps · 802.11n: 300 Mbps · 802.11ac: 867 Mbps |
| Combined Max Speed | AC1200 (867 + 300 Mbps) |
| Antenna Connectors | 2× RP-SMA female |
| Included Antennas | 2× dual-band dipole omni, 5 dBi |
| USB Interface | Type-C SuperSpeed (5 Gbps); backward compatible USB 2.0 |
| Power Amplifier | ✅ Yes — extended range vs standard cards |
| Wireless Security | WPA3 / WPA2 / WPA / WEP / WPS / 802.1X |
| Accessories | Screen clip mount, USB cable |
| Country of Origin | Taiwan |

---

### OS Support

| OS | Status | Notes |
|---|---|---|
| Windows 10 / 11 | ✅ | Driver from Alfa website. WPA3 supported (Oct 2019+) |
| macOS 10.15 Catalina | ⚠️ | Manual install. macOS 11+ and Apple Silicon NOT supported |
| Ubuntu | ✅ | DKMS RTL8812AU install. In-kernel on Ubuntu 24.10+ (kernel ≥ 6.14) |
| Kali Linux | ✅✅ | Supported since Kali 2017.1. Full monitor mode + packet injection. Working on kernel 6.12.33 (Jul 2025 confirmed) |
| NetHunter (Android) | ✅ | OTG USB. Widely confirmed working |
| Raspberry Pi 3B+/4/5 | ✅ | Manual driver via morrownr DKMS script |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ✅✅ Excellent (gold standard — community-proven since 2017) |
| Packet Injection | ✅✅ Excellent |
| Soft AP Mode | ✅ |
| Bluetooth | ❌ |
| VIF | ⚠️ Limited (use AWUS036ACM for full VIF support) |

---

### In the Box
- 1× AWUS036ACH adapter
- 2× Detachable 5 dBi dual-band dipole antennas
- 1× USB cable (USB-C to USB-A)
- 1× Screen clip mount

---

### Resources
| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036ach_1 |
| Documentation | https://docs.alfa.com.tw/Product/AWUS036ACH/ |
| Driver (Kali/aircrack-ng) | https://github.com/aircrack-ng/rtl8812au |
| Driver (general Linux) | https://github.com/morrownr/8812au-20210708 |
