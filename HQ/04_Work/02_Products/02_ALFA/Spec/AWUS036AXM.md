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
AWUS036AXM_spec.md

1. Hero Cover

- **Product Title:** ALFA Network AWUS036AXM – WiFi 6E Tri-Band USB-A Adapter
- **Tagline:** Tri-Band WiFi 6E & Bluetooth 5.2 in an Innovative L-Shaped Design
- **Badges:** ✅ Kali Linux Official Support | ✅ WiFi 6E | ✅ L-Shaped USB-A | ✅ In-Kernel Driver

2. Product Conceptual Map

- **Form Factor:** Compact, premium dark matte finish with a unique L-shaped (elbow) design that prevents the adapter from blocking adjacent USB ports on laptops and mini PCs.
- **Antenna Design:** Dual detachable high-gain 5dBi dipole antennas ensuring wide coverage and allowing for directional antenna upgrades.
- **Connectivity:** Robust USB 3.2 Gen 1 Type-A interface.
- **Mounting:** Direct plug-and-play into standard USB-A ports, functioning perfectly in tight spaces thanks to its right-angle form factor.

3. 6 Core Features (Radiating Map)

4. **WiFi 6E Tri-Band:** Operates on 2.4 GHz, 5 GHz, and the uncongested 6 GHz band.
5. **Extreme Speeds (3000 Mbps):** Delivers 600 Mbps (2.4GHz) + 1200 Mbps (5GHz) + 1200 Mbps (6GHz).
6. **MediaTek MT7921AUN Chipset:** True plug-and-play on modern Linux distros (in-kernel support ≥ v5.18) without the need for GitHub driver compilation.
7. **Bluetooth 5.2 Coexistence:** Built-in Bluetooth 5.2 (with a dedicated internal BT antenna) for high-quality audio and peripherals alongside WiFi.
8. **L-Shaped USB-A Design:** Ergonomic elbow connector perfectly tailored for port-dense laptops.
9. **Advanced Security Research:** Native support for Monitor Mode, Packet Injection, and VIF in Kali Linux.

10. Full Specifications Table

|Feature|Specification|
|---|---|
|**Chipset**|MediaTek MT7921AUN|
|**WiFi Standards**|IEEE 802.11 a/b/g/n/ac/ax (WiFi 6E)|
|**Bluetooth**|Version 5.2|
|**Interface**|USB 3.2 Gen 1 Type-A (L-elbow connector)|
|**Antenna Connector**|2x RP-SMA (female)|
|**Included Antennas**|2x 5dBi external dual-band dipole antennas|
|**BT Antenna**|Integrated internal antenna|
|**Wireless Security**|WPA3 / WPA2 / WPA / WEP / WPS|
|**Power Consumption**|2.7 Watts (Max)|
|**Dimensions**|87.4 x 28.5 x 12 mm (3.44 x 1.13 x 0.47 inches)|

**Hardware Support:**

- Desktop / Laptop PC (Windows & Linux)
- Raspberry Pi 3B+ / 4 / 5
- _(Note: Mac Intel and Mac ARM are NOT supported)_

5. Speed Dashboard

- **2.4 GHz Band:** Up to 600 Mbps (Ideal for long-range and legacy IoT devices)
- **5 GHz Band:** Up to 1200 Mbps (High-speed streaming and data analysis)
- **6 GHz Band:** Up to 1200 Mbps (Ultra-low latency, zero congestion for WiFi 6E networks)
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

- **Cybersecurity Professionals & Penetration Testers:** Features native Kali Linux support and out-of-the-box monitor mode for auditing across 2.4GHz, 5GHz, and 6GHz networks.
- **Laptop Power Users:** The L-shaped USB-A connector prevents blocking adjacent ports, making it the perfect WiFi 6E upgrade for users with crowded I/O panels.
- **Network Administrators:** Ideal for 6 GHz site surveys, spectrum analysis, and troubleshooting modern enterprise networks.
- **IoT & Raspberry Pi Developers:** Highly stable MT7921AUN in-kernel drivers make it perfect for custom Linux drop-boxes without relying on fragile out-of-kernel code.

--------------------------------------------------------------------------------

8. Kali Linux (2025): Driver Installation & Advanced Modes

_Because the AWUS036AXM uses the_ _mt7921u_ _driver built directly into modern Linux kernels (>= 5.18), you do NOT need to download or compile source code from GitHub._

**1. Driver & Firmware Installation:** Ensure your system has the required MediaTek firmware blobs installed:

```
sudo apt update
sudo apt install linux-firmware firmware-misc-nonfree
sudo reboot
```

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

Raspberry Pi OS (based on Debian) supports the MT7921AUN out of the box as long as the OS and kernel are fully updated (requires kernel >= 5.18).

**1. System Update & Driver Installation:** Connect the adapter to a USB 3.0 port on the Raspberry Pi.

```
sudo apt update
sudo apt full-upgrade
sudo apt install linux-firmware
sudo reboot
```

After rebooting, use `iwconfig` or `ip a` to confirm the presence of the new wireless interface. You can now configure it for standard Wi-Fi use or deploy penetration testing tools identically to standard Linux environments.



---

### Resources
| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036axm |
| Documentation | https://docs.alfa.com.tw/ |
| Linux Driver | mt7921u — in-kernel ≥ 5.18 |
