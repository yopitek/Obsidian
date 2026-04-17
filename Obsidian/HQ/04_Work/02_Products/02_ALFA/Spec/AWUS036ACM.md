---
model: AWUS036ACM
brand: ALFA Network
category: USB WiFi Adapter
wifi_gen: WiFi 5
chipset: MediaTek MT7612U
max_speed_mbps: 867
usb_type: USB-A 3.0
antenna: 2x RP-SMA 5dBi detachable
bluetooth: false
monitor_mode: true
kali_linux: true
linux_driver: in-kernel (mt76x2u ≥4.19)
status: Active
tags: [alfa, usb-adapter, wifi5, linux, kali, raspberry-pi, plug-and-play, vif]
---

# AWUS036ACM
## WiFi 5 AC1200 Dual-Band USB 3.0 Adapter — Best Linux Plug & Play

### Overview
Top recommendation for Linux users wanting zero-hassle setup. MediaTek MT7612U in-kernel driver since Linux 4.19 — works out of the box on Ubuntu, Kali, Raspberry Pi OS, Arch with zero compilation. Full monitor mode, packet injection, and VIF (Virtual Interface) support.

---

### Technical Specifications

| Parameter | Value |
|---|---|
| Chipset | MediaTek MT7612U |
| WiFi Standards | IEEE 802.11 a/b/g/n/ac (WiFi 5) |
| Frequency Bands | 2.4 GHz (2.412–2.472 GHz) · 5 GHz (5.15–5.825 GHz) |
| Channel Widths | 20 / 40 / 80 MHz |
| Max Data Rate | 5 GHz: 867 Mbps · 2.4 GHz: 300 Mbps |
| Combined Max Speed | AC1200 (867 + 300 Mbps) |
| Antenna Connectors | 2× RP-SMA female |
| Included Antennas | 2× dual-band dipole, 5 dBi |
| USB Interface | USB 3.0 Type-A (backward compatible USB 2.0) |
| Output Power | 802.11a: 20 dBm · 802.11b: 23 dBm · 802.11g: 23 dBm · 802.11n: 21 dBm · 802.11ac: 20 dBm |
| Receive Sensitivity | 802.11a: −92 dBm · 802.11b: −97 dBm · 802.11g: −90 dBm · 802.11n: −90 dBm |
| Wireless Security | WPA2 / WPA / WEP / WPA-PSK / 802.1X / 64–128 bit WEP |
| LED | Yes (power + WLAN activity) |
| Accessories | USB 3.0 extension cable |
| Country of Origin | Taiwan |

---

### OS Support

| OS | Status | Notes |
|---|---|---|
| Windows XP–11 | ✅ | Driver from Alfa website |
| macOS 10.7–10.12 | ⚠️ | macOS 11+ and Apple Silicon NOT supported |
| Ubuntu 19.04+ | ✅ Plug & Play | In-kernel mt76 (kernel ≥ 4.19). Zero install on Ubuntu 20.04 LTS+ |
| Kali Linux 2019.3+ | ✅ Plug & Play | In-kernel. Monitor mode confirmed. VIF supported. AP mode on 5 GHz: add `disable_usb_sg` parameter |
| NetHunter | ✅ | OTG USB; in-kernel driver means broader Android compatibility |
| Raspberry Pi 3B+/4/5 | ✅ Excellent | Works out of the box on Pi OS — no driver install. Best Alfa adapter for Pi |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ✅ (in-kernel, no extra steps on modern distros) |
| Packet Injection | ✅ |
| Soft AP Mode | ✅ (5 GHz AP: add `disable_usb_sg` module parameter) |
| Bluetooth | ❌ |
| VIF | ✅ Full VIF support in Kali |

---

### In the Box
- 1× AWUS036ACM adapter
- 2× Detachable 5 dBi dual-band dipole antennas
- 1× USB 3.0 extension cable
- 1× Driver CD (Windows)

---

### Resources
| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036acm_1 |
| Documentation | https://docs.alfa.com.tw/Product/AWUS036ACM/ |
| Linux Driver | mt76 — in-kernel ≥ 4.19, no installation needed |
