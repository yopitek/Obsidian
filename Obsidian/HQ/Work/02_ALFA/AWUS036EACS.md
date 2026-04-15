---
model: AWUS036EACS
brand: ALFA Network
category: USB WiFi Adapter
wifi_gen: WiFi 5
chipset: Realtek RTL8821CU
max_speed_mbps: 433
usb_type: USB 2.0 (nano)
antenna: Integrated 2dBi
bluetooth: "4.2"
monitor_mode: false
kali_linux: false
linux_driver: poor
form_factor: nano
output_power_dbm: 17
status: Active
tags: [alfa, usb-adapter, wifi5, bluetooth, nano, windows-only, ac600]
---

# AWUS036EACS
## WiFi 5 AC600 + Bluetooth 4.2 Nano USB Adapter

### Overview
Ultra-compact WiFi + Bluetooth combo adapter. RTL8821CU chipset in nano form factor, plug-and-play on Windows. Integrates AC600 dual-band WiFi and Bluetooth 4.2 in a single dongle. Prioritises compactness over performance.

> ⚠️ NOT recommended for Linux, Kali Linux, or security research.  
> ⚠️ No RP-SMA port — antenna cannot be upgraded.  
> ⚠️ Monitor mode and packet injection NOT reliably supported.

---

### Technical Specifications

| Parameter | Value |
|---|---|
| Chipset | Realtek RTL8821CU |
| WiFi Standards | IEEE 802.11 a/b/g/n/ac (WiFi 5) |
| Bluetooth | BT 4.2 (2.4 GHz) |
| Frequency Bands | WiFi: 2.412–2.472 GHz · 5.15–5.825 GHz · BT: 2.4 GHz |
| Max Data Rate | 802.11b: 11 Mbps · 802.11g: 54 Mbps · 802.11n: 150 Mbps · 802.11ac: 433 Mbps |
| Combined Max Speed | AC600 (150 + 433 Mbps) |
| Antenna | Integrated, 2 dBi (non-removable) |
| USB Interface | USB 2.0 (nano form factor) |
| Output Power | 17 dBm typical |
| Receive Sensitivity | 802.11b: −85 dBm · 802.11g: −69 dBm · 802.11n: −68 dBm · 802.11ac: −59 dBm |
| Wireless Security | WEP / WPA-PSK / WPA2-PSK / WPA/WPA2 64/128 bit |
| Operating Temperature | −10°C to 60°C |
| Storage Humidity | 5% to 98% (non-condensing) |
| Country of Origin | Taiwan |

---

### OS Support

| OS | Status | Notes |
|---|---|---|
| Windows XP–10 | ✅ | Built-in driver; plug and play. Win 11 compatibility TBC |
| macOS | ⚠️ | Listed compatible; no Apple Silicon support |
| Ubuntu / Linux | ⚠️ Poor | RTL8821CU has poor community driver support. Not recommended |
| Kali Linux | ❌ | Monitor mode and packet injection not reliably supported |
| NetHunter | ❌ | RTL8821CU not confirmed working |
| Raspberry Pi | ❌ | Driver issues on Pi OS |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ❌ Not reliably supported |
| Packet Injection | ❌ Not reliably supported |
| Soft AP Mode | ✅ |
| Bluetooth | ✅ BT 4.2 |

---

### Resources
| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036eacs_1 |
| Documentation | https://docs.alfa.com.tw/Product/AWUS036EACS/ |
