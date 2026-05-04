---
model: AWUS036AXML
brand: ALFA Network
category: USB WiFi Adapter
wifi_gen: WiFi 6E
chipset: MediaTek MT7921AUN
max_speed_mbps: 3000
usb_type: USB-C 3.2 Gen1
antenna: 2x RP-SMA detachable
bluetooth: "5.2"
monitor_mode: true
kali_linux: true
linux_driver: in-kernel (mt7921u ≥5.18)
status: Active
tags: [alfa, usb-adapter, wifi6e, linux, kali, bluetooth]
---

AWUS036AXML_spec.md

1. Hero Cover

- **Product Title:** ALFA Network AWUS036AXML – WiFi 6E Tri-Band USB-C Adapter
- **Tagline:** Next-Generation Tri-Band Speed & Bluetooth 5.2 Connectivity
- **Badges:** ✅ Kali Linux Official Support | ✅ WiFi 6E | ✅ Bluetooth 5.2 | ✅ In-Kernel Driver

2. Product Conceptual Map

- **Form Factor:** Compact, premium dark grey matte finish for professional use.
- **Antenna Design:** Dual detachable high-gain 5dBi dipole antennas for superior range and directional upgrades.
- **Connectivity:** Robust USB 3.2 Gen 1 Type-C interface. Includes a 2-in-1 (USB-C / USB-A) power and data cable to adapt to any PC or laptop.
- **Mounting:** Comes with an exclusive screen clip mount to easily attach the adapter to a laptop or monitor bezel.

3. 6 Core Features (Radiating Map)

4. **WiFi 6E Tri-Band:** Operates on 2.4 GHz, 5 GHz, and the new uncongested 6 GHz band.
5. **Extreme Speeds (3000 Mbps):** 600 Mbps (2.4GHz) + 1200 Mbps (5GHz) + 1200 Mbps (6GHz).
6. **MediaTek MT7921AUN Chipset:** True plug-and-play on modern Linux distros (in-kernel support ≥ v5.18) without GitHub driver compilation.
7. **Bluetooth 5.2 Coexistence:** Built-in Bluetooth 5.2 for high-quality audio and low-latency peripherals alongside WiFi.
8. **Advanced Security Research:** Native support for Monitor Mode and Packet Injection in Kali Linux.
9. **WPA3 Security:** Supports the latest WPA3 encryption protocols for maximum network protection.

10. Full Specifications Table

|Feature|Specification|
|---|---|
|**Chipset**|MediaTek MT7921AUN|
|**WiFi Standards**|IEEE 802.11 a/b/g/n/ac/ax (WiFi 6 / WiFi 6E)|
|**Bluetooth**|Version 5.2|
|**Interface**|USB Type-C (USB 3.2 Gen 1)|
|**Antenna Connector**|2x RP-SMA (female)|
|**Included Antennas**|2x 5dBi external dual-band dipole antennas|
|**Wireless Security**|WPA3 / WPA2 / WPA / WEP|
|**Power Consumption**|2.7 Watts (Max)|
|**Dimensions**|85 x 63 x 20 mm (3.4 x 2.5 x 0.8 inches)|

**Hardware Support:**

- Desktop / Laptop PC (Windows & Linux)
- Raspberry Pi 3B+ / 4 / 5
- _(Note: Mac Intel and Mac ARM are NOT supported)_

5. Speed Dashboard

- **2.4 GHz Band:** Up to 600 Mbps (Ideal for long-range and legacy IoT devices)
- **5 GHz Band:** Up to 1200 Mbps (High-speed streaming and gaming)
- **6 GHz Band:** Up to 1200 Mbps (Ultra-low latency, zero congestion for WiFi 6E routers)
- **Combined Capacity:** 3000 Mbps Class

6. Support OS Version & Advanced Capabilities

**OS Support:**

- **Windows 10 / 11:** Full support (6GHz band requires Windows 11)
- **Ubuntu 22.04 / 24.04:** Native in-kernel support
- **Kali Linux (2025):** Native in-kernel support
- **NetHunter (Android):** Supported via OTG (kernel dependent)

**Advanced Capabilities:**

- **Monitor Mode:** Supported natively (Passive capture of 802.11 frames)
- **Packet Injection:** Supported natively (Frame injection for penetration testing)
- **Soft AP Mode:** Supported (Turn the adapter into an Access Point/Evil Twin)
- **Bluetooth:** Integrated BT 5.2
- **VIF (Virtual Interface / Fusion):** Supported (Run managed mode and monitor mode concurrently)

7. Target Audience × Application Scenarios

- **Cybersecurity Professionals & Penetration Testers:** Features native Kali Linux support, out-of-the-box monitor mode, and packet injection for auditing 2.4GHz, 5GHz, and 6GHz networks.
- **Network Administrators:** Ideal for WiFi 6E site surveys, spectrum analysis, and troubleshooting congested enterprise environments.
- **Power Users & PC Gamers:** Instantly upgrades older laptops or desktop PCs without USB-C (via the included 2-in-1 cable) to the latest 3000 Mbps tri-band speed and Bluetooth 5.2 capabilities.
- **IoT & Raspberry Pi Developers:** High performance and stable MT7921AUN in-kernel drivers make it perfect for custom Linux drop-boxes, wardriving rigs, and mobile APs.

--------------------------------------------------------------------------------

8. Kali Linux (2025): Driver Installation & Advanced Modes

_Because the AWUS036AXML uses the_ _mt7921u_ _driver built directly into modern Linux kernels (>= 5.18), you do NOT need to download or compile source code from GitHub._

**1. Driver & Firmware Installation:** Ensure your system has the required MediaTek firmware blobs installed:

```
sudo apt update
sudo apt install linux-firmware firmware-misc-nonfree
sudo reboot
```

_(If your specific Kali 2025 build is missing the newest Mediatek firmware, you can manually copy_ _WIFI_MT7961_patch_mcu_1_2_hdr.bin_ _and_ _WIFI_RAM_CODE_MT7961_1.bin_ _to_ _/lib/firmware/mediatek__)_.

**2. Enable Monitor Mode:** Assuming your adapter is `wlan1`:

```
sudo ip link set wlan1 down
sudo iw dev wlan1 set type monitor
sudo ip link set wlan1 up
```

**3. Packet Injection Test:**

```
sudo aireplay-ng --test wlan1
```

**4. Fusion / VIF (Virtual Interface):** To act as an Access Point while simultaneously sniffing traffic:

```
sudo iw dev wlan1 interface add mon0 type monitor
sudo ip link set mon0 up
```

--------------------------------------------------------------------------------

9. Ubuntu 22.04 & 24.04: Driver Installation & Advanced Modes

Ubuntu 22.04 and 24.04 feature very modern kernels natively equipped to handle the MT7921AUN chip.

**1. Driver & Firmware Installation:**

```
sudo apt update
sudo apt install linux-firmware
sudo reboot
```

**2. Enable Monitor Mode, Injection, and Fusion:** The commands for Monitor Mode, Packet Injection, and Fusion (VIF) on Ubuntu are exactly identical to the Kali Linux instructions in Section 8.

--------------------------------------------------------------------------------

10. Debian: Driver Installation & Advanced Modes

**1. Driver & Firmware Installation:** Debian requires the "non-free" repositories to fetch the correct proprietary firmware files for MediaTek.

```
sudo apt update
sudo apt install firmware-misc-nonfree linux-firmware
sudo reboot
```

**2. Enable Monitor Mode, Injection, and Fusion:** Once the firmware is loaded, Debian utilizes the same in-kernel `mt7921u` driver. The commands for Monitor Mode, Packet Injection, and Fusion (VIF) are exactly identical to the Kali Linux instructions in Section 8.

--------------------------------------------------------------------------------

11. Raspberry Pi 4B & 5: Driver Installation

Raspberry Pi OS (based on Debian) supports the MT7921AUN out of the box as long as the OS and kernel are fully updated.

**1. System Update & Driver Installation:** Connect the adapter to a blue USB 3.0 port on the Raspberry Pi.

```
sudo apt update
sudo apt full-upgrade
sudo apt install linux-firmware
sudo reboot
```

After rebooting, use `iwconfig` or `ip a` to confirm the presence of the new wireless interface. You can now configure it for standard Wi-Fi use or deploy penetration testing tools identically to standard Linux environments.