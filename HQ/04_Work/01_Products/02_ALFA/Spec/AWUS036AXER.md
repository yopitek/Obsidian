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
AWUS036AXER_spec.md

1. Hero Cover

- **Product Title:** ALFA Network AWUS036AXER – WiFi 6 AX1800 Nano USB 3.2 Adapter
- **Tagline:** Next-Generation WiFi 6 Speed in an Ultra-Compact, Travel-Ready Design
- **Badges:** ✅ WiFi 6 (802.11ax) | ✅ AX1800 Dual-Band | ✅ Ultra-Compact (10g) | ⚠️ Limited Security Research Support

2. Product Conceptual Map

- **Form Factor:** Nano-sized, ultra-compact dongle (65 x 24 x 10 mm) with a smooth, dark blue/grey finish, designed to remain plugged into a laptop without snagging.
- **Antenna Design:** Features an integrated, internal 2x2 high-performance antenna. (Note: No external RP-SMA connector means the antenna cannot be upgraded).
- **Connectivity:** High-speed USB 3.2 Gen 1 Type-A interface.
- **Mounting:** Direct plug-and-play into standard USB-A ports, providing a highly discreet and portable hardware upgrade.

3. 6 Core Features (Radiating Map)

4. **Realtek RTL8832BU Chipset:** Drives high-speed WiFi 6 efficiency in a miniaturized footprint.
5. **Ultra-Compact Portability:** Weighing only 10.5g and measuring just 6.5 cm in length, it is the most portable WiFi 6 adapter in ALFA's lineup.
6. **WiFi 6 (802.11ax) Dual-Band:** Operates on both 2.4 GHz and 5 GHz bands (Note: Does not support the 6 GHz WiFi 6E band).
7. **AX1800 Combined Speeds:** Delivers up to 1201 Mbps on the 5 GHz band and 573.5 Mbps on the 2.4 GHz band.
8. **OFDMA & MU-MIMO Technology:** Enhances network capacity and reduces latency in crowded environments like airports, cafes, and offices.
9. **USB 3.2 Gen 1 Interface:** Ensures the physical USB connection does not bottleneck the high-speed wireless throughput.

10. Full Specifications Table

|Feature|Specification|
|---|---|
|**Chipset**|Realtek™ RTL8832BU|
|**WiFi Standards**|IEEE 802.11 a/b/g/n/ac/ax (WiFi 6)|
|**Frequency**|2.4 GHz / 5 GHz|
|**Interface**|USB 3.2 Gen 1 Type-A|
|**Antenna Connector**|None (Integrated)|
|**Included Antennas**|Integrated 2x2 high-performance antenna|
|**Wireless Security**|WEP 64/128-bit, WPA, WPA2, WPA3|
|**Power Consumption**|0.8 A on 5 V (Max)|
|**Dimensions**|65 x 24 x 10 mm|
|**Weight**|10.5 g|

**Hardware Support:**

- Desktop / Laptop PC (Windows & Linux)
- Raspberry Pi 3B+ / 4 / 5 (Requires manual driver installation; not recommended for advanced projects)
- _(Note: Mac Intel and Mac ARM are NOT supported)_

5. Speed Dashboard

- **2.4 GHz Band:** Up to 573.5 Mbps
- **5 GHz Band:** Up to 1201 Mbps
- **Combined Capacity:** AX1800 Class

6. Support OS Version & Advanced Capabilities

**OS Support:**

- **Windows 10 / 11:** Full support (Plug-and-play or via official ALFA driver)
- **macOS:** Not supported (No drivers for macOS 11+ or Apple Silicon)
- **Ubuntu 22.04 / 24.04:** Supported (Requires manual out-of-kernel DKMS driver installation on kernels prior to 6.14)
- **Kali Linux (2025):** Limited (Driver can be installed, but it is not recommended for security testing)
- **NetHunter (Android):** Limited / Not Recommended

**Advanced Capabilities:**

- **Monitor Mode:** Limited (Dependent on Linux kernel and driver version; highly unreliable due to lack of external antennas and Realtek driver limitations)
- **Packet Injection:** Limited
- **Soft AP Mode:** Supported (Can act as a mobile wireless hotspot)
- **Bluetooth:** Not supported
- **VIF (Virtual Interface / Fusion):** Not natively supported by the out-of-kernel Realtek driver.

7. Target Audience × Application Scenarios

- **Business Travelers & Digital Nomads:** The primary audience. Its nano-size means it can be left plugged into a laptop indefinitely, instantly upgrading older machines to fast, stable WiFi 6 connections in hotel rooms and cafes.
- **Discrete Desktop/Laptop Upgrades:** Ideal for users who want to upgrade to AX1800 speeds without dealing with large, protruding external antennas that risk snapping off or getting in the way.
- **Embedded Systems:** Suitable for custom enclosures, kiosks, or robotics where a tiny physical footprint is mandatory.
- _(Note: Cybersecurity Professionals and Kali Linux users looking for robust Monitor Mode, Packet Injection, and VIF support should absolutely avoid this model and choose the AWUS036ACM or AWUS036ACH instead)_.

--------------------------------------------------------------------------------

8. Kali Linux (2025): Driver Installation & Advanced Modes

_Because the AWUS036AXER uses the Realtek RTL8832BU chipset, its driver is out-of-kernel for versions prior to Linux 6.14. You must compile the DKMS driver from community repositories (such as morrownr). Note: This adapter is not recommended for advanced penetration testing._

**1. Driver Installation:** Ensure your system is fully updated and install the necessary build tools and headers:

```
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential dkms git bc iw linux-headers-$(uname -r)
git clone https://github.com/morrownr/rtl8852bu-20240418.git
cd rtl8852bu-20240418
sudo ./install-driver.sh
sudo reboot
```

**2. Enable Monitor Mode (If supported by your specific kernel/driver build):** Assuming your adapter is recognized as `wlan1`:

```
sudo ip link set wlan1 down
sudo iw dev wlan1 set type monitor
sudo ip link set wlan1 up
```

**3. Packet Injection Test:**

```
sudo aireplay-ng --test wlan1
```

**4. Fusion / VIF (Virtual Interface):** _Note: Out-of-kernel Realtek drivers generally lack robust multi-state Virtual Interface (VIF) concurrency. Operating Monitor Mode and Managed/AP mode simultaneously is not supported on this hardware._

--------------------------------------------------------------------------------

9. Ubuntu 22.04 & 24.04: Driver Installation & Advanced Modes

**1. Driver Installation:** Ubuntu distributions require the exact same manual DKMS compilation to ensure the driver survives kernel updates (unless running kernel >= 6.14):

```
sudo apt update
sudo apt install -y build-essential dkms git linux-headers-$(uname -r)
git clone https://github.com/morrownr/rtl8852bu-20240418.git
cd rtl8852bu-20240418
sudo ./install-driver.sh
sudo reboot
```

**2. Enable Monitor Mode and Injection:** The commands for attempting Monitor Mode and Packet Injection on Ubuntu are exactly identical to the Kali Linux instructions in Section 8. _(Results will be highly limited)._

--------------------------------------------------------------------------------

10. Debian: Driver Installation & Advanced Modes

**1. Driver Installation:** Debian requires the same `build-essential` and `dkms` packages. Ensure your `sources.list` includes the necessary repositories to fetch headers:

```
sudo apt update
sudo apt install -y git build-essential dkms linux-headers-$(uname -r)
git clone https://github.com/morrownr/rtl8852bu-20240418.git
cd rtl8852bu-20240418
sudo ./install-driver.sh
sudo reboot
```

**2. Enable Monitor Mode and Injection:** The commands for configuring Monitor Mode and Packet Injection on Debian are exactly identical to the Kali Linux instructions in Section 8. _(Results will be highly limited)._

--------------------------------------------------------------------------------

11. Raspberry Pi 4B & 5: Driver Installation

For the Raspberry Pi, you must use the specific ARM-compatible kernel headers to compile the driver successfully. Note that range will be severely limited compared to ALFA adapters with external antennas.

**1. System Update & Dependencies:**

```
sudo apt update && sudo apt full-upgrade -y
sudo apt install -y git bc dkms build-essential raspberrypi-kernel-headers
```

**2. Driver Compilation (ARM architecture):** Clone the `rtl8852bu` repository and run the installer script:

```
git clone https://github.com/morrownr/rtl8852bu-20240418.git
cd rtl8852bu-20240418
sudo ./install-driver.sh
sudo reboot
```

Once rebooted, the Raspberry Pi will recognize the AWUS036AXER, allowing you to connect to high-speed WiFi 6 networks or deploy basic Soft AP configurations.


---

### Resources
| Resource | Link |
|---|---|
| Documentation | https://docs.alfa.com.tw/ |
| Linux Driver (RTL8832BU) | https://github.com/morrownr/rtl8852bu-20240418 |
