---
model: AWUS036ACS
brand: ALFA Network
category: USB WiFi Adapter
wifi_gen: WiFi 5
chipset: Realtek RTL8811AU
max_speed_mbps: 433
usb_type: USB-A 2.0
antenna: 1x RP-SMA 2dBi detachable
bluetooth: false
monitor_mode: true
kali_linux: true
linux_driver: out-of-kernel (DKMS)
status: Active
tags: [alfa, usb-adapter, wifi5, kali, budget, ac600]
---

# AWUS036ACS
## WiFi 5 AC600 Dual-Band USB Adapter — Budget Security Research

### Overview
Alfa's most affordable dual-band 802.11ac adapter with monitor mode and packet injection. RTL8811AU chipset, compact form factor, single upgradeable RP-SMA antenna. Practical entry point for beginners in wireless security research or budget 5 GHz with external antenna capability.

> ⚠️ USB 2.0 only — throughput capped at 433 Mbps. For higher speed use AWUS036ACM or AWUS036ACH.

---

### Technical Specifications

| Parameter | Value |
|---|---|
| Chipset | Realtek RTL8811AU |
| WiFi Standards | IEEE 802.11 a/b/g/n/ac (WiFi 5) |
| Frequency Bands | 2.4 GHz (150 Mbps) · 5 GHz (433 Mbps) |
| Combined Max Speed | AC600 (583 Mbps actual max) |
| Antenna Connector | 1× RP-SMA female |
| Included Antenna | 1× dual-band dipole mini, 2 dBi |
| USB Interface | USB 2.0 Type-A |
| Receive Sensitivity | 802.11b: −85 dBm · 802.11g: −69 dBm · 802.11n: −68 dBm · 802.11ac: −59 dBm |
| Wireless Security | WPA2 / WPA / WEP / 802.1X / 64–128 bit WEP |
| Compatible External Antenna | APA-M25 dual-band panel antenna |
| Country of Origin | Taiwan |

---

### OS Support

| OS | Status | Notes |
|---|---|---|
| Windows XP–11 | ✅ | Driver from Alfa website |
| macOS 10.5–10.14 | ⚠️ | macOS 10.15+ and Apple Silicon NOT supported |
| Ubuntu | ✅ | Manual DKMS driver install (morrownr/8821au). No in-kernel support |
| Kali Linux | ✅ | Monitor mode + packet injection. Community driver from morrownr GitHub |
| NetHunter | ✅ | OTG USB; RTL8811AU confirmed NetHunter compatible |
| Raspberry Pi 3B+/4/5 | ✅ | KaliPi install via morrownr DKMS |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ✅ |
| Packet Injection | ✅ |
| Soft AP Mode | ✅ |
| Bluetooth | ❌ |

---

### In the Box
- 1× AWUS036ACS adapter
- 1× Detachable 2 dBi dual-band mini dipole antenna

---

### Resources
| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036acs_1 |
| Documentation | https://docs.alfa.com.tw/Product/AWUS036ACS/ |
| Linux Driver (RTL8811AU) | https://github.com/morrownr/8821au-20210708 |
