# Alfa Network USB WiFi Adapters — Full Product Specifications
**For:** yupitek.com/en/products/alfa/  
**Last updated:** 2026-03-20  
**Sources cross-referenced:** alfa.com.tw · docs.alfa.com.tw · github.com/morrownr · github.com/aircrack-ng

> ⚠️ **macOS Notice (All Models):** None of the adapters listed below support macOS 11 Big Sur or later, or Apple Silicon (M1/M2/M3). macOS support is limited to macOS 10.15 Catalina and earlier on Intel Macs only.

---

## Phase Plan

- [x] Phase 1 — Research & source crawling (research.md)
- [x] Phase 2 — AWUS036AXML product profile
- [x] Phase 3 — AWUS036AXM product profile
- [x] Phase 4 — AWUS036AX product profile
- [x] Phase 5 — AWUS036AXER product profile
- [x] Phase 6 — AWUS036ACH product profile
- [x] Phase 7 — AWUS036ACM product profile
- [x] Phase 8 — AWUS036ACS product profile
- [x] Phase 9 — AWUS036EACS product profile
- [x] Phase 10 — Master comparison table

---

---

# 1. AWUS036AXML
## Alfa AWUS036AXML — WiFi 6E Tri-Band USB-C Adapter with Bluetooth 5.2

### Product Overview
The AWUS036AXML is Alfa Network's flagship WiFi 6E tri-band USB adapter, operating simultaneously on 2.4 GHz, 5 GHz, and the new 6 GHz band for a combined speed ceiling of 3000 Mbps. It is designed for users who want the latest wireless standard — whether for high-speed home networking, Linux/Kali penetration testing, or Raspberry Pi deployments. The USB-C connector and included screen clip make it especially practical for modern laptops.

---

### Product Features
- WiFi 6E (802.11ax) — next-generation wireless with OFDMA and MU-MIMO
- Tri-band: 2.4 GHz (600 Mbps) + 5 GHz (1200 Mbps) + 6 GHz (1200 Mbps) = up to 3000 Mbps combined
- Bluetooth 5.2 built-in — add BT to any device with a single adapter
- USB-C connector (USB 3.2 Gen 1, 5 Gbps) — included 2-in-1 USB-C/USB-A cable for compatibility with all computers
- 1× detachable RP-SMA antenna — upgradeable to higher-gain directional or omnidirectional antennas
- Screen clip mount included — attaches directly to laptop or monitor bezel
- MediaTek MT7921AUN chipset — in-kernel Linux driver (kernel ≥ 5.18), plug & play on modern distros
- Monitor mode and packet injection supported — recommended for Kali Linux and security research
- TAA compliant — suitable for government and enterprise procurement

---

### Technical Specifications

| Parameter | Value |
|---|---|
| Chipset | MediaTek MT7921AUN |
| WiFi Standards | IEEE 802.11 a/b/g/n/ac/ax (WiFi 6E) |
| Frequency Bands | 2.4 GHz (20/40 MHz) · 5 GHz (20/40/80 MHz) · 6 GHz (20/40/80 MHz) |
| Max Data Rate | 2.4 GHz: up to 600 Mbps · 5 GHz: up to 1200 Mbps · 6 GHz: up to 1200 Mbps |
| Combined Max Speed | 3000 Mbps (requires WiFi 6E router; typical real-world: 800–1200 Mbps) |
| Bluetooth | BT 5.2 (combo chip) |
| Antenna Connector | 1× RP-SMA female (detachable) |
| Included Antenna | 1× dual-band dipole (gain: TBC) |
| USB Interface | USB 3.2 Gen 1 Type-C (5 Gbps) |
| Included Cable | 2-in-1 USB-C / USB-A power + data cable |
| Accessories | Screen clip mount |
| Wireless Security | WPA3 / WPA2 / WPA / WEP / WPS |
| Country of Origin | Taiwan |
| Manufacturer | Alfa Network Inc. |

---

### Supported Operating Systems

| OS | Status | Notes |
|---|---|---|
| Windows 10 | ✅ Supported | 2.4 GHz and 5 GHz only; 6 GHz band not available on Windows 10 |
| Windows 11 | ✅ Supported | Full tri-band including 6 GHz; driver from Alfa website or Windows Update |
| macOS | ❌ Not supported | No support for macOS 11+ or Apple Silicon (M1/M2/M3) |
| Ubuntu | ✅ Supported | In-kernel driver (mt7921u) requires kernel ≥ 5.18 (Ubuntu 22.10+). Firmware files may need manual copy on first boot. |
| Kali Linux | ✅ Supported | In-kernel mt7921u driver. Monitor mode works on kernel 5.18+; active monitor mode from kernel 6.12+. Packet injection supported. Firmware files may need manual copy on first boot. |
| NetHunter (Android) | ⚠️ Partial | OTG connection supported; compatibility depends on NetHunter kernel version on device |

---

### Supported Hardware

| Hardware | Status | Notes |
|---|---|---|
| Raspberry Pi 3B+ / 4 / 5 | ✅ Supported | Works on updated Raspberry Pi OS with kernel ≥ 5.18. May require firmware file copy. |
| Desktop / Laptop (PC) | ✅ Supported | USB-C or USB-A (via included 2-in-1 cable) |
| Desktop / Laptop (Mac Intel) | ⚠️ Limited | macOS 10.15 Catalina maximum |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ✅ Yes (kernel ≥ 5.18; active monitor mode ≥ kernel 6.12) |
| Packet Injection | ✅ Yes |
| Soft AP Mode | ✅ Yes |
| Bluetooth | ✅ BT 5.2 |
| VIF (Virtual Interface) | ✅ Yes |

**Best for:** WiFi 6E home/office upgrade · Kali Linux security research · Raspberry Pi networking · Users needing WiFi + Bluetooth from one adapter · USB-C laptop users

---

### What's in the Box
- 1× AWUS036AXML adapter
- 1× Detachable dipole antenna
- 1× 2-in-1 USB-C / USB-A cable
- 1× Screen clip mount

---

### Resources & Links

| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036axml |
| Official Documentation | https://docs.alfa.com.tw/ |
| Linux Driver (in-kernel) | mt7921u — built into Linux kernel ≥ 5.18 |

---

---

# 2. AWUS036AXM
## Alfa AWUS036AXM — WiFi 6E Tri-Band USB-A Adapter with Dual Antennas & Bluetooth 5.2

### Product Overview
The AWUS036AXM shares the same MediaTek MT7921AUN chipset as the AXML but targets users with standard USB-A ports who want two external antennas for improved directional coverage. Its L-shaped connector prevents it from blocking adjacent USB ports — a thoughtful design detail for compact laptops and mini PCs. Like the AXML, it delivers tri-band WiFi 6E performance and is fully Linux-compatible out of the box on modern kernels.

---

### Product Features
- WiFi 6E (802.11ax) — tri-band 2.4 GHz / 5 GHz / 6 GHz, up to 3000 Mbps
- Bluetooth 5.2 built-in — high-quality audio and low-latency peripherals
- USB-A connector with L-shaped elbow — does not block neighbouring USB ports
- USB 3.2 Gen 1 (5 Gbps) for maximum data throughput
- 2× RP-SMA female connectors with 2× detachable 5 dBi dipole antennas — superior coverage vs single-antenna AXML
- Dedicated internal Bluetooth antenna + LED status indicator
- MediaTek MT7921AUN — in-kernel Linux driver (kernel ≥ 5.18), zero compilation required on modern distros
- Monitor mode and packet injection supported
- TAA compliant

---

### Technical Specifications

| Parameter | Value |
|---|---|
| Chipset | MediaTek MT7921AUN |
| WiFi Standards | IEEE 802.11 a/b/g/n/ac/ax (WiFi 6E) |
| Frequency Bands | 2.4 GHz · 5 GHz · 6 GHz |
| Max Data Rate | 2.4 GHz: up to 600 Mbps · 5 GHz: up to 1200 Mbps · 6 GHz: up to 1200 Mbps |
| Combined Max Speed | 3000 Mbps (requires WiFi 6E router) |
| Bluetooth | BT 5.2 (integrated antenna) |
| Antenna Connectors | 2× RP-SMA female (detachable) |
| Included Antennas | 2× dual-band dipole, 5 dBi gain |
| USB Interface | USB 3.2 Gen 1 Type-A (L-elbow connector, 5 Gbps) |
| LED Indicator | Yes (WLAN activity + BT status) |
| Wireless Security | WPA3 / WPA2 / WPA / WEP / WPS |
| Country of Origin | Taiwan |
| Manufacturer | Alfa Network Inc. |

---

### Supported Operating Systems

| OS | Status | Notes |
|---|---|---|
| Windows 10 | ✅ Supported | 2.4 GHz + 5 GHz only; 6 GHz requires Windows 11 |
| Windows 11 | ✅ Supported | Full tri-band operation including 6 GHz |
| macOS | ❌ Not supported | No macOS 11+ or Apple Silicon support |
| Ubuntu | ✅ Supported | In-kernel mt7921u driver (Ubuntu 22.10+ / kernel ≥ 5.18) |
| Kali Linux | ✅ Supported | In-kernel driver. Monitor mode + packet injection supported. Firmware files may be needed. |
| NetHunter (Android) | ⚠️ Partial | OTG connection; kernel-dependent |

---

### Supported Hardware

| Hardware | Status | Notes |
|---|---|---|
| Raspberry Pi 3B+ / 4 / 5 | ✅ Supported | Updated Pi OS (kernel ≥ 5.18) required |
| Desktop / Laptop (PC) | ✅ Supported | L-elbow USB-A connector avoids port blocking |
| Desktop / Laptop (Mac Intel) | ⚠️ Limited | macOS 10.15 Catalina maximum |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ✅ Yes |
| Packet Injection | ✅ Yes |
| Soft AP Mode | ✅ Yes |
| Bluetooth | ✅ BT 5.2 (integrated BT antenna) |
| VIF (Virtual Interface) | ✅ Yes |

**Best for:** WiFi 6E with dual-antenna coverage · Linux/Kali users on USB-A machines · Users needing WiFi + BT combo · Power users who want to swap antennas for directional access

---

### What's in the Box
- 1× AWUS036AXM adapter (L-elbow USB-A)
- 2× Detachable 5 dBi dipole antennas
- Quick setup guide

---

### Resources & Links

| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036axm |
| Official Documentation | https://docs.alfa.com.tw/ |
| Linux Driver (in-kernel) | mt7921u — built into Linux kernel ≥ 5.18 |

---

---

# 3. AWUS036AX
## Alfa AWUS036AX — WiFi 6 Dual-Band USB 3.0 Adapter

### Product Overview
The AWUS036AX is Alfa's entry-level WiFi 6 (802.11ax) dual-band adapter, providing a clean speed boost over older WiFi 5 hardware for Windows and Linux desktops. Based on the Realtek RTL8832BU chipset, it delivers 1200 Mbps combined throughput with OFDMA and MU-MIMO for improved performance in congested environments. Note: this model does NOT support the 6 GHz band (WiFi 6 only, not 6E).

---

### Product Features
- WiFi 6 (802.11ax) — next-gen efficiency with OFDMA and MU-MIMO
- Dual-band: 2.4 GHz + 5 GHz (no 6 GHz — this is WiFi 6, not WiFi 6E)
- Up to 1200 Mbps combined throughput
- USB 3.0 (USB-A) connection
- Integrated high-performance antenna — compact, no external connectors
- Realtek RTL8832BU chipset — improved Linux support in kernel 6.12+

> ⚠️ **Linux / Kali Note:** The RTL8832BU driver was merged into the Linux kernel in v6.14. On older kernels (Ubuntu 22.04 LTS, Kali 2023.x), manual driver installation is required. Monitor mode support is limited — **not recommended** as a primary security research adapter. Consider AWUS036ACM or AWUS036ACH for Kali/pen-testing use.

---

### Technical Specifications

| Parameter | Value |
|---|---|
| Chipset | Realtek RTL8832BU |
| WiFi Standards | IEEE 802.11 a/b/g/n/ac/ax (WiFi 6) |
| Frequency Bands | 2.4 GHz · 5 GHz (dual-band only, no 6 GHz) |
| Max Data Rate | Up to 1200 Mbps combined |
| Antenna | Integrated (non-removable) |
| USB Interface | USB 3.0 Type-A |
| MIMO | MU-MIMO 2×2 |
| Wireless Security | WPA3 / WPA2 / WPA / WEP |
| Country of Origin | Taiwan |
| Manufacturer | Alfa Network Inc. |

---

### Supported Operating Systems

| OS | Status | Notes |
|---|---|---|
| Windows 10 / 11 | ✅ Supported | Driver download from Alfa website |
| macOS | ❌ Not supported | No macOS 11+ or Apple Silicon support |
| Ubuntu | ⚠️ Requires driver | In-kernel on Ubuntu 24.10+ (kernel ≥ 6.14). Earlier versions need manual DKMS install. |
| Kali Linux | ⚠️ Limited | Monitor mode limited on kernels < 6.12. Not recommended for penetration testing. |
| NetHunter (Android) | ⚠️ Limited | Kernel-dependent; limited confirmed support |

---

### Supported Hardware

| Hardware | Status | Notes |
|---|---|---|
| Raspberry Pi 4 / 5 | ⚠️ Requires driver | Manual driver install needed on Pi OS with kernel < 6.14 |
| Desktop / Laptop (PC) | ✅ Supported | Standard USB-A |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ⚠️ Limited (kernel ≥ 6.12 recommended) |
| Packet Injection | ⚠️ Limited |
| Soft AP Mode | ✅ Yes |
| Bluetooth | ❌ No |

**Best for:** Windows 10/11 home or office WiFi 6 upgrade · Users who do NOT need Linux security features · Clean, compact form factor with no protruding antennas

---

### What's in the Box
- 1× AWUS036AX adapter

---

### Resources & Links

| Resource | Link |
|---|---|
| Official Documentation | https://docs.alfa.com.tw/ |
| Linux Driver (RTL8832BU) | https://github.com/morrownr/rtl8852bu-20240418 |

---

---

# 4. AWUS036AXER
## Alfa AWUS036AXER — WiFi 6 Nano Dual-Band USB 3.2 Adapter

### Product Overview
The AWUS036AXER is the most compact WiFi 6 adapter in Alfa's lineup — a nano-sized dongle that disappears into your USB port. Sharing the Realtek RTL8832BU chipset with the AWUS036AX but in a dramatically smaller enclosure, it is the ideal adapter when portability and discretion matter more than antennas or Linux compatibility. It supports 1800 Mbps and is purpose-built for Windows users who travel frequently.

---

### Product Features
- WiFi 6 (802.11ax) in an ultra-compact nano body
- Dual-band: 2.4 GHz (573 Mbps) + 5 GHz (1200 Mbps) = up to 1800 Mbps
- USB 3.2 Gen 1 (USB-A) — 5 Gbps interface
- Integrated high-performance antenna — no external connectors
- OFDMA and MU-MIMO support for efficient multi-device environments
- Weighs approx. 10g — near-invisible form factor (65 × 24 × 10 mm)
- Same driver as AWUS036AX (Realtek RTL8832BU)

> ⚠️ **Important:** No RP-SMA connector — antenna cannot be upgraded. **Not recommended for Linux security research or Kali Linux use** — monitor mode support is limited on kernels prior to 6.12.

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
| Manufacturer | Alfa Network Inc. |

---

### Supported Operating Systems

| OS | Status | Notes |
|---|---|---|
| Windows 10 / 11 | ✅ Supported | Driver from Alfa website |
| macOS | ❌ Not supported | No macOS 11+ or Apple Silicon support |
| Ubuntu | ⚠️ Requires driver | In-kernel on kernel ≥ 6.14 (Ubuntu 24.10+); earlier versions need manual install |
| Kali Linux | ⚠️ Limited | Not recommended for monitor mode / security testing |
| NetHunter (Android) | ⚠️ Limited | Kernel-dependent; limited data |

---

### Supported Hardware

| Hardware | Status | Notes |
|---|---|---|
| Raspberry Pi 4 / 5 | ⚠️ Requires driver | Manual install needed on older Pi OS kernels |
| Desktop / Laptop (PC) | ✅ Supported | Ultra-low profile; ideal for travel |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ⚠️ Limited |
| Packet Injection | ⚠️ Limited |
| Soft AP Mode | ✅ Yes |
| Bluetooth | ❌ No |

**Best for:** Windows travel users needing WiFi 6 · Laptops where a large adapter would be inconvenient · Embedded systems where a tiny footprint is required

---

### What's in the Box
- 1× AWUS036AXER nano adapter

---

### Resources & Links

| Resource | Link |
|---|---|
| Official Documentation | https://docs.alfa.com.tw/ |
| Linux Driver (RTL8832BU) | https://github.com/morrownr/rtl8852bu-20240418 |

---

---

# 5. AWUS036ACH
## Alfa AWUS036ACH — WiFi 5 AC1200 Dual-Band USB-C Adapter (Security Research Reference)

### Product Overview
The AWUS036ACH is Alfa Network's most iconic security research adapter — the gold standard for Kali Linux penetration testing since 2017. Powered by the battle-tested Realtek RTL8812AU chipset, it delivers rock-solid monitor mode and packet injection support, a built-in power amplifier for long-range reception, and two detachable 5 dBi antennas for maximum signal reach. It was the world's first WiFi 5 adapter with a USB Type-C connector. If you use Kali Linux, aircrack-ng, or wireless network analysis tools — this is the adapter most widely recommended by the community.

---

### Product Features
- Realtek RTL8812AU — the most widely tested and documented chipset for WiFi security research
- WiFi 5 (802.11ac) dual-band AC1200 — 867 Mbps on 5 GHz, 300 Mbps on 2.4 GHz
- Built-in power amplifier — picks up WiFi signals at up to 3× the range of typical laptop internal cards
- 2× RP-SMA female connectors with 2× 5 dBi detachable dual-band antennas — upgradeable to high-gain or directional antennas
- World's first WiFi 5 USB adapter with USB Type-C connector
- Screen clip mount included for laptop/monitor attachment
- Kali Linux packet injection support since Kali 2017.1
- Monitor mode and packet injection: excellent — community-verified and documented since 2017
- Backward compatible with 802.11a/b/g/n

---

### Technical Specifications

| Parameter | Value |
|---|---|
| Chipset | Realtek RTL8812AU |
| WiFi Standards | IEEE 802.11 a/b/g/n/ac (WiFi 5) |
| Frequency Bands | 2.4 GHz · 5 GHz (dual-band) |
| Max Data Rate | 802.11b: 11 Mbps · 802.11a/g: 54 Mbps · 802.11n: 300 Mbps · 802.11ac: 867 Mbps |
| Combined Max Speed | AC1200 (867 + 300 Mbps) |
| Antenna Connectors | 2× RP-SMA female |
| Included Antennas | 2× dual-band dipole omni, 5 dBi gain |
| USB Interface | Type-C SuperSpeed USB (5 Gbps); backward compatible with USB 2.0 |
| Power Amplifier | Yes — extended range vs standard cards |
| Wireless Security | WPA3 / WPA2 / WPA / WEP / WPS / 802.1X |
| Accessories | Screen clip mount · USB cable |
| Country of Origin | Taiwan |
| Manufacturer | Alfa Network Inc. |

---

### Supported Operating Systems

| OS | Status | Notes |
|---|---|---|
| Windows 10 / 11 | ✅ Supported | Download driver from the Alfa website. WPA3 support available (driver released Oct 2019). |
| macOS 10.15 Catalina | ⚠️ Limited | Supported via manual install. macOS 11+ and Apple Silicon NOT supported. |
| Ubuntu | ✅ Supported | Requires manual RTL8812AU driver install via DKMS. In-kernel on Ubuntu 24.10+ (kernel ≥ 6.14). Driver: github.com/aircrack-ng/rtl8812au |
| Kali Linux | ✅ Excellent | Supported since Kali 2017.1. Full monitor mode + packet injection. Use aircrack-ng driver. Working as of kernel 6.12.33 (Jul 2025 confirmed). |
| NetHunter (Android) | ✅ Supported | OTG USB connection. Widely confirmed working with NetHunter OTG cable. |

---

### Supported Hardware

| Hardware | Status | Notes |
|---|---|---|
| Raspberry Pi 3B+ / 4 / 5 | ✅ Supported | Manual driver install via morrownr DKMS script. |
| Desktop / Laptop (PC) | ✅ Supported | USB-C or USB-A (via included cable) |
| Desktop / Laptop (Mac Intel) | ⚠️ Limited | macOS 10.15 Catalina maximum |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ✅ Excellent (gold standard — community-proven since 2017) |
| Packet Injection | ✅ Excellent |
| Soft AP Mode | ✅ Yes |
| Bluetooth | ❌ No |
| VIF (Virtual Interface) | ⚠️ Limited (use AWUS036ACM for full VIF support) |

**Best for:** Kali Linux penetration testing · aircrack-ng / airmon-ng workflows · Long-range WiFi reconnaissance · Security researchers who need battle-tested monitor mode · NetHunter / Android OTG users

---

### What's in the Box
- 1× AWUS036ACH adapter
- 2× Detachable 5 dBi dual-band dipole antennas
- 1× USB cable (USB-C to USB-A)
- 1× Screen clip mount

---

### Resources & Links

| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036ach_1 |
| Official Documentation | https://docs.alfa.com.tw/Product/AWUS036ACH/ |
| Driver (aircrack-ng, best for Kali) | https://github.com/aircrack-ng/rtl8812au |
| Driver (morrownr, general Linux) | https://github.com/morrownr/8812au-20210708 |

---

---

# 6. AWUS036ACM
## Alfa AWUS036ACM — WiFi 5 AC1200 Dual-Band USB 3.0 Adapter (Best Linux Plug & Play)

### Product Overview
The AWUS036ACM is the top recommendation for Linux users who want zero-hassle setup. Its MediaTek MT7612U chipset has been built into the Linux kernel since version 4.19 — meaning it works out of the box on Ubuntu, Kali Linux, Raspberry Pi OS, Arch Linux, and virtually any modern distribution without compiling a single line of code. It matches the AWUS036ACH in physical size and antenna configuration but uses MediaTek's rock-solid in-kernel driver instead of Realtek's out-of-kernel stack. Monitor mode, packet injection, and VIF (Virtual Interface) are all fully supported.

---

### Product Features
- MediaTek MT7612U chipset — in-kernel Linux driver since kernel 4.19 (plug & play, no compilation needed)
- WiFi 5 (802.11ac) dual-band AC1200 — up to 867 Mbps on 5 GHz, 300 Mbps on 2.4 GHz
- 2× RP-SMA female connectors with 2× 5 dBi detachable dual-band antennas — identical physical format to AWUS036ACH
- USB 3.0 (USB-A) interface for high-speed data transfer
- Full monitor mode, packet injection, and AP mode support
- VIF (Virtual Interface) support in Kali Linux
- Included USB 3.0 extension cable
- TAA compliant — suitable for US government procurement (GSA compatible)
- Works out of the box on Raspberry Pi OS — no driver installation

---

### Technical Specifications

| Parameter | Value |
|---|---|
| Chipset | MediaTek MT7612U |
| WiFi Standards | IEEE 802.11 a/b/g/n/ac (WiFi 5) |
| Frequency Bands | 2.4 GHz (2.412–2.472 GHz) · 5 GHz (5.15–5.825 GHz) |
| Channel Widths | 20 / 40 / 80 MHz |
| Max Data Rate | 5 GHz: up to 867 Mbps · 2.4 GHz: up to 300 Mbps |
| Combined Max Speed | AC1200 (867 + 300 Mbps) |
| Antenna Connectors | 2× RP-SMA female |
| Included Antennas | 2× dual-band dipole, 5 dBi gain |
| USB Interface | USB 3.0 Type-A (backward compatible with USB 2.0) |
| Output Power | 802.11a: 20 dBm · 802.11b: 23 dBm · 802.11g: 23 dBm · 802.11n: 21 dBm · 802.11ac: 20 dBm |
| Receive Sensitivity | 802.11a: −92 dBm · 802.11b: −97 dBm · 802.11g: −90 dBm · 802.11n: −90 dBm |
| Wireless Security | WPA2 / WPA / WEP / WPA-PSK / 802.1X / 64–128 bit WEP |
| LED | Yes (power + WLAN activity) |
| Accessories | USB 3.0 extension cable |
| Country of Origin | Taiwan |
| Manufacturer | Alfa Network Inc. |

---

### Supported Operating Systems

| OS | Status | Notes |
|---|---|---|
| Windows XP–11 | ✅ Supported | Driver from the Alfa website. Windows 10/11 recommended. |
| macOS 10.7–10.12 | ⚠️ Limited | Official support ends at macOS 10.12 Sierra. macOS 11+ and Apple Silicon NOT supported. |
| Ubuntu 19.04+ | ✅ Plug & Play | In-kernel mt76 driver (kernel ≥ 4.19). Zero driver installation needed on Ubuntu 20.04 LTS and later. |
| Kali Linux 2019.3+ | ✅ Plug & Play | In-kernel driver. Monitor mode confirmed working on Ubuntu 18.04+. VIF (Virtual Interface) supported. AP mode on 5 GHz may require `disable_usb_sg` module parameter for full performance. |
| NetHunter (Android) | ✅ Supported | OTG USB; in-kernel driver means broader Android kernel compatibility than RTL adapters |

---

### Supported Hardware

| Hardware | Status | Notes |
|---|---|---|
| Raspberry Pi 3B+ / 4 / 5 | ✅ Excellent | Works out of the box on Raspberry Pi OS — no driver installation required. Best Alfa adapter for Pi. |
| Desktop / Laptop (PC) | ✅ Supported | Standard USB-A, with included extension cable |
| Desktop / Laptop (Mac Intel) | ⚠️ Limited | macOS 10.7–10.12 only |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ✅ Yes (in-kernel, no extra steps on modern distros) |
| Packet Injection | ✅ Yes |
| Soft AP Mode | ✅ Yes (5 GHz AP: add `disable_usb_sg` module parameter for best performance) |
| Bluetooth | ❌ No |
| VIF (Virtual Interface) | ✅ Yes (full VIF support in Kali) |

**Best for:** Linux users who want zero-setup plug & play · Raspberry Pi deployments · Kali Linux with VIF support · Ubuntu / Arch Linux desktops · Users who want reliable monitor mode without manual driver compilation

---

### What's in the Box
- 1× AWUS036ACM adapter
- 2× Detachable 5 dBi dual-band dipole antennas
- 1× USB 3.0 extension cable
- 1× Driver CD (Windows)

---

### Resources & Links

| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036acm_1 |
| Official Documentation | https://docs.alfa.com.tw/Product/AWUS036ACM/ |
| Linux Driver Info (in-kernel) | mt76 driver — included in Linux kernel ≥ 4.19, no installation needed |

---

---

# 7. AWUS036ACS
## Alfa AWUS036ACS — WiFi 5 AC600 Dual-Band USB Adapter (Budget Security Research)

### Product Overview
The AWUS036ACS is Alfa's most affordable entry point into the dual-band 802.11ac lineup with monitor mode and packet injection support. Powered by the Realtek RTL8811AU chipset, it is compact and lightweight with a single detachable RP-SMA antenna that can be upgraded for better range. While not as powerful as the ACH or ACM, it is a practical choice for beginners in wireless security research or users who need a budget-friendly 5 GHz adapter with external antenna capability.

---

### Product Features
- Realtek RTL8811AU chipset — monitor mode and packet injection supported
- WiFi 5 (802.11ac) dual-band — 2.4 GHz (150 Mbps) + 5 GHz (433 Mbps) = AC600
- 1× RP-SMA female connector with 1× 2 dBi mini detachable antenna — upgradeable to panel or high-gain antennas
- Compact form factor — small profile for easy portability
- USB 2.0 (USB-A) interface — compatible with any USB port
- Compatible with Alfa APA-M25 dual-band panel antenna for directional reception
- Supports Kali Linux on Raspberry Pi (KaliPi) — driver installation via DKMS

> ⚠️ **Note:** USB 2.0 only — maximum 480 Mbps data bus speed. Throughput capped at 433 Mbps regardless of 802.11ac theoretical rates. For maximum speed, use AWUS036ACM or AWUS036ACH with USB 3.0.

---

### Technical Specifications

| Parameter | Value |
|---|---|
| Chipset | Realtek RTL8811AU |
| WiFi Standards | IEEE 802.11 a/b/g/n/ac (WiFi 5) |
| Frequency Bands | 2.4 GHz (150 Mbps) · 5 GHz (433 Mbps) |
| Combined Max Speed | AC600 / AC750 (see note: 583 Mbps actual maximum) |
| Antenna Connector | 1× RP-SMA female |
| Included Antenna | 1× dual-band dipole mini, 2 dBi gain |
| USB Interface | USB 2.0 Type-A |
| Receive Sensitivity | 802.11b: −85 dBm · 802.11g: −69 dBm · 802.11n: −68 dBm · 802.11ac: −59 dBm |
| Wireless Security | WPA2 / WPA / WEP / 802.1X / 64–128 bit WEP |
| Country of Origin | Taiwan |
| Manufacturer | Alfa Network Inc. |

> **AC600 vs AC750 note:** Combined theoretical maximum is 583 Mbps; AC600 is the more accurate rating.

---

### Supported Operating Systems

| OS | Status | Notes |
|---|---|---|
| Windows XP–11 | ✅ Supported | Driver from Alfa website |
| macOS 10.5–10.14 | ⚠️ Limited | macOS 10.15+ and Apple Silicon NOT supported |
| Ubuntu | ✅ Supported | Manual DKMS driver install required (morrownr/8821au). No in-kernel support. |
| Kali Linux | ✅ Supported | Monitor mode + packet injection supported. Community driver from morrownr GitHub. |
| NetHunter (Android) | ✅ Supported | OTG USB connection; RTL8811AU has confirmed NetHunter compatibility |

---

### Supported Hardware

| Hardware | Status | Notes |
|---|---|---|
| Raspberry Pi 3B+ / 4 / 5 | ✅ Supported | KaliPi-specific install available via morrownr DKMS. |
| Desktop / Laptop (PC) | ✅ Supported | Standard USB-A |
| Desktop / Laptop (Mac Intel) | ⚠️ Limited | macOS 10.5–10.14 only |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ✅ Yes |
| Packet Injection | ✅ Yes |
| Soft AP Mode | ✅ Yes |
| Bluetooth | ❌ No |

**Best for:** Budget entry into WiFi security research · Beginners learning Kali Linux and aircrack-ng · Users who want antenna upgrade capability at low cost · Compact 5 GHz adapter with RP-SMA port

---

### What's in the Box
- 1× AWUS036ACS adapter
- 1× Detachable 2 dBi dual-band mini dipole antenna

---

### Resources & Links

| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036acs_1 |
| Official Documentation | https://docs.alfa.com.tw/Product/AWUS036ACS/ |
| Linux Driver (RTL8811AU) | https://github.com/morrownr/8821au-20210708 |
| Windows Driver | https://docs.alfa.com.tw/Product/AWUS036ACS/ (Download driver for Windows) |
| macOS Driver | https://docs.alfa.com.tw/Product/AWUS036ACS/ (Download driver for macOS) |

---

---

# 8. AWUS036EACS
## Alfa AWUS036EACS — WiFi 5 AC600 + Bluetooth 4.2 Nano USB Adapter

### Product Overview
The AWUS036EACS is Alfa's ultra-compact WiFi + Bluetooth combination adapter, designed for home and office users who want both wireless connectivity in a single discreet USB dongle. Built around the Realtek RTL8821CU chipset, it integrates AC600 dual-band WiFi and Bluetooth 4.2 in a nano form factor with built-in driver support on Windows. Its Soft AP mode lets you share your internet connection to other devices. This adapter prioritises simplicity and compactness over performance — it is NOT recommended for Linux power users, Kali Linux, or security research.

---

### Product Features
- 802.11ac AC600 dual-band WiFi + Bluetooth 4.2 in a single nano USB adapter
- Plug-and-play on Windows — built-in driver software installs automatically
- Soft AP mode — create a WiFi hotspot directly from the adapter
- Ultra-compact and portable — disappears into any USB port
- Dual-band: 2.4 GHz (150 Mbps) + 5 GHz (433 Mbps)
- Integrated 2 dBi antenna — no external RP-SMA connector
- Ideal for desktops, embedded systems, or robotics needing WiFi + BT in minimal space
- Bluetooth 4.2 supports audio streaming, keyboards, mice, and other peripherals

> ⚠️ **Linux Notice:** The RTL8821CU chipset has poor Linux community driver support. Linux usage is unreliable. Community reports include devices not functioning after reinstalling OS. **Not recommended for Ubuntu, Kali Linux, or Raspberry Pi deployments.**  
> ⚠️ **No RP-SMA port:** The antenna cannot be upgraded or replaced.  
> ⚠️ **Not for security research:** Monitor mode and packet injection are not reliably supported.

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
| USB Interface | USB 2.0 (micro USB nano design) |
| Output Power | 17 dBm typical |
| Receive Sensitivity | 802.11b: −85 dBm · 802.11g: −69 dBm · 802.11n: −68 dBm · 802.11ac: −59 dBm |
| Wireless Security | WEP / WPA-PSK / WPA2-PSK / WPA/WPA2 64/128 bit |
| Operating Temperature | −10°C to 60°C |
| Storage Humidity | 5% to 98% (non-condensing) |
| Form Factor | Nano / low-profile |
| Country of Origin | Taiwan |
| Manufacturer | Alfa Network Inc. |

---

### Supported Operating Systems

| OS | Status | Notes |
|---|---|---|
| Windows XP–10 | ✅ Supported | Built-in driver; plug and play. Windows 11 compatibility TBC — check Alfa driver page. |
| macOS | ⚠️ Limited | Listed as compatible; exact version range TBC. No Apple Silicon support. |
| Ubuntu / Linux | ⚠️ Poor | RTL8821CU has poor community driver support. Not recommended for Linux use. |
| Kali Linux | ❌ Not recommended | Monitor mode and packet injection not reliably supported on RTL8821CU |
| NetHunter (Android) | ❌ Not recommended | RTL8821CU not confirmed working with NetHunter |

---

### Supported Hardware

| Hardware | Status | Notes |
|---|---|---|
| Raspberry Pi | ❌ Not recommended | RTL8821CU driver issues on Pi OS |
| Desktop / Laptop (PC) | ✅ Supported | Windows only recommended |
| Embedded / Robotics | ⚠️ Windows only | Compact design suits embedded Windows systems |

---

### Advanced Capabilities

| Feature | Status |
|---|---|
| Monitor Mode | ❌ Not reliably supported |
| Packet Injection | ❌ Not reliably supported |
| Soft AP Mode | ✅ Yes |
| Bluetooth | ✅ BT 4.2 |

**Best for:** Windows home users who want WiFi + Bluetooth in one dongle · Embedded Windows systems · Desktop PCs without built-in Bluetooth · Users who value compact design over range or Linux compatibility

---

### What's in the Box
- 1× AWUS036EACS nano adapter

---

### Resources & Links

| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036eacs_1 |
| Official Documentation | https://docs.alfa.com.tw/Product/AWUS036EACS/ |

---

---

# Master Comparison Table — All 8 Models

| Model | WiFi Gen | Chipset | Bands | Max Speed | USB | Antennas | Monitor Mode | Packet Inject | Linux Driver | Bluetooth | Best For |
|---|---|---|---|---|---|---|---|---|---|---|---|
| **AWUS036AXML** | WiFi 6E (ax) | MT7921AUN | 2.4 + 5 + 6 GHz | 3000 Mbps | USB-C 3.2 | 1× detach RP-SMA | ✅ | ✅ | In-kernel ≥ 5.18 | BT 5.2 | WiFi 6E + Linux + USB-C laptops |
| **AWUS036AXM** | WiFi 6E (ax) | MT7921AUN | 2.4 + 5 + 6 GHz | 3000 Mbps | USB-A 3.2 (L-elbow) | 2× detach RP-SMA 5 dBi | ✅ | ✅ | In-kernel ≥ 5.18 | BT 5.2 | WiFi 6E + dual antenna + Linux |
| **AWUS036AX** | WiFi 6 (ax) | RTL8832BU | 2.4 + 5 GHz | 1200 Mbps | USB-A 3.0 | Integrated | ⚠️ Limited | ⚠️ Limited | Out-of-kernel (< 6.14) | ❌ | Windows WiFi 6 home upgrade |
| **AWUS036AXER** | WiFi 6 (ax) | RTL8832BU | 2.4 + 5 GHz | 1800 Mbps | USB-A 3.2 | Integrated (nano) | ⚠️ Limited | ⚠️ Limited | Out-of-kernel (< 6.14) | ❌ | Ultra-compact travel WiFi 6 |
| **AWUS036ACH** | WiFi 5 (ac) | RTL8812AU | 2.4 + 5 GHz | 867 Mbps | USB-C 3.0 | 2× detach RP-SMA 5 dBi | ✅✅ Best | ✅✅ Best | Out-of-kernel (in-kernel ≥ 6.14) | ❌ | Kali Linux / pen testing (gold standard) |
| **AWUS036ACM** | WiFi 5 (ac) | MT7612U | 2.4 + 5 GHz | 867 Mbps | USB-A 3.0 | 2× detach RP-SMA 5 dBi | ✅ | ✅ | **In-kernel ≥ 4.19** | ❌ | Linux plug & play / Raspberry Pi |
| **AWUS036ACS** | WiFi 5 (ac) | RTL8811AU | 2.4 + 5 GHz | 433 Mbps | USB-A 2.0 | 1× detach RP-SMA 2 dBi | ✅ | ✅ | Out-of-kernel | ❌ | Budget pen testing / Kali beginners |
| **AWUS036EACS** | WiFi 5 (ac) | RTL8821CU | 2.4 + 5 GHz | 433 Mbps | USB 2.0 (nano) | Integrated 2 dBi | ❌ | ❌ | ⚠️ Poor | BT 4.2 | Windows home WiFi + BT combo |

---

## Quick Buyer Guide

### By Primary Use Case

| Use Case | Recommended Model |
|---|---|
| Best overall for WiFi 6E | AWUS036AXML (USB-C) or AWUS036AXM (USB-A) |
| Best for Kali Linux / penetration testing | AWUS036ACH (monitor mode gold standard) |
| Best plug & play on Linux / Raspberry Pi | AWUS036ACM (in-kernel since kernel 4.19) |
| Best compact WiFi 6 for travel | AWUS036AXER (nano, ~10g) |
| Budget Kali Linux / security research | AWUS036ACS |
| WiFi + Bluetooth combo in one dongle | AWUS036AXML / AWUS036AXM (BT 5.2) or AWUS036EACS (BT 4.2, Windows only) |
| Windows home WiFi upgrade | AWUS036AX, AWUS036AXER, or AWUS036ACH |

### By OS / Platform

| Platform | Best Choice | Runner-Up |
|---|---|---|
| Kali Linux (pen test) | AWUS036ACH | AWUS036ACM |
| Ubuntu / Debian | AWUS036ACM | AWUS036AXML |
| Raspberry Pi | AWUS036ACM | AWUS036ACH |
| Windows 10 | Any model | — |
| Windows 11 + WiFi 6E | AWUS036AXML | AWUS036AXM |
| macOS | ⚠️ All limited to 10.15 | Check per model |
| NetHunter Android | AWUS036ACH | AWUS036ACM |

---

*Document complete. All 8 models profiled. Ready for yupitek.com website implementation.*
