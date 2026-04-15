---
model: AWUS036AX
brand: ALFA Network
category: USB WiFi Adapter
wifi_gen: WiFi 6
chipset: Realtek RTL8832BU
max_speed_mbps: 1200
usb_type: USB-A 3.0
antenna: Integrated
bluetooth: false
monitor_mode: limited
kali_linux: limited
linux_driver: out-of-kernel (<6.14)
status: Active
tags: [alfa, usb-adapter, wifi6, windows]
---

# AWUS036AX
## WiFi 6 Dual-Band USB 3.0 Adapter

### Overview
Entry-level WiFi 6 (802.11ax) dual-band adapter delivering 1200 Mbps. Compact integrated antenna. **No 6 GHz band** — WiFi 6 only, not WiFi 6E. Best for Windows 10/11 home/office WiFi upgrade.

> ⚠️ Linux monitor mode limited on kernels < 6.12. Not recommended for Kali/penetration testing.

---

### Technical Specifications

| Parameter | Value |
|---|---|
| Chipset | Realtek RTL8832BU |
| WiFi Standards | IEEE 802.11 a/b/g/n/ac/ax (WiFi 6) |
| Frequency Bands | 2.4 GHz + 5 GHz (no 6 GHz) |
| Max Data Rate | Up to 1200 Mbps combined |
| Antenna | Integrated (non-removable) |
| USB Interface | USB 3.0 Type-A |
| MIMO | MU-MIMO 2×2 |
| Wireless Security | WPA3 / WPA2 / WPA / WEP |
| Country of Origin | Taiwan |

---

### OS Support

| OS | Status | Notes |
|---|---|---|
| Windows 10 / 11 | ✅ | Driver from Alfa website |
| macOS | ❌ | No macOS 11+ or Apple Silicon |
| Ubuntu | ⚠️ | In-kernel on Ubuntu 24.10+ (kernel ≥ 6.14); earlier needs DKMS |
| Kali Linux | ⚠️ | Monitor mode limited < kernel 6.12. Not recommended for pen-testing |
| NetHunter | ⚠️ | Limited confirmed support |
| Raspberry Pi 4/5 | ⚠️ | Manual driver install needed |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ⚠️ Limited (kernel ≥ 6.12 recommended) |
| Packet Injection | ⚠️ Limited |
| Soft AP Mode | ✅ |
| Bluetooth | ❌ |

---

### Resources
| Resource | Link |
|---|---|
| Documentation | https://docs.alfa.com.tw/ |
| Linux Driver (RTL8832BU) | https://github.com/morrownr/rtl8852bu-20240418 |
