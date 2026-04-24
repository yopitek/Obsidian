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
AWUS036AX_spec.md

1. Hero Cover

- **Product Title:** ALFA Network AWUS036AX – WiFi 6 AX1800 Dual-Band USB 3.0 Adapter
- **Tagline:** Next-Generation WiFi 6 Speed and Efficiency for Desktop & Laptop PCs
- **Badges:** ✅ WiFi 6 (802.11ax) | ✅ AX1800 Dual-Band | ✅ MU-MIMO & OFDMA | ⚠️ Limited Security Research Support (Driver Dependent)

2. Product Conceptual Map

- **Form Factor:** Streamlined, flat black matte chassis designed for high-performance desktop or laptop upgrades.
- **Antenna Design:** Two RP-SMA female connectors equipped with dual-band 5dBi detachable dipole omnidirectional antennas, providing flexibility for directional antenna upgrades.
- **Connectivity:** High-speed USB 3.2 Gen 1 Type-A interface.
- **Mounting:** Connects directly into standard USB-A ports, delivering an instant hardware upgrade to modern WiFi 6 networks.

3. 6 Core Features (Radiating Map)

4. **Realtek RTL8832BU Chipset:** Powers the next-generation wireless architecture with dedicated hardware optimization for WiFi 6.
5. **WiFi 6 (802.11ax) Dual-Band:** Operates on both 2.4 GHz and 5 GHz bands, maximizing compatibility with both legacy IoT devices and modern high-speed routers.
6. **AX1800 Combined Speeds:** Delivers up to 1201 Mbps on the 5 GHz band and 573.5 Mbps on the 2.4 GHz band.
7. **OFDMA & MU-MIMO Technology:** Significantly improves network efficiency, reduces latency, and enhances capacity in highly congested multi-device environments.
8. **Hardware Flexibility:** Dual detachable RP-SMA antennas allow users to customize their RF reach by attaching specialized high-gain or directional antennas.
9. **USB 3.2 Gen 1 Interface:** Eliminates data bottlenecks with 5 Gbps transfer speeds, outperforming standard USB 2.0 connections.

10. Full Specifications Table

|Feature|Specification|
|---|---|
|**Chipset**|Realtek™ RTL8832BU|
|**WiFi Standards**|IEEE 802.11 a/b/g/n/ac/ax (WiFi 6)|
|**Frequency**|2.4 GHz / 5 GHz (Note: Does not support 6 GHz)|
|**Interface**|USB 3.2 Gen 1 Type-A|
|**Antenna Connector**|2x RP-SMA (female)|
|**Included Antennas**|2x dual-band 2.4 GHz + 5 GHz detachable dipole antennas (5 dBi)|
|**Wireless Security**|WEP 64/128-bit, WPA, WPA2, WPA3|
|**Power Consumption**|3.6 W (Max) at 5V|
|**Dimensions**|87.4 x 28.5 x 12 mm (3.44 x 1.13 x 0.47 inches)|
|**Operating Temperature**|-20°C to 70°C|

**Hardware Support:**

- Desktop / Laptop PC (Windows & Linux)
- Raspberry Pi 3B+ / 4 / 5 (Requires manual driver installation on older kernels)
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
- **Kali Linux (2025):** Supported (Requires manual out-of-kernel DKMS driver installation)
- **NetHunter (Android):** Limited (Kernel-dependent; limited confirmed support)

**Advanced Capabilities:**

- **Monitor Mode:** Limited (Dependent on Linux kernel and driver version; not recommended as a primary penetration testing tool)
- **Packet Injection:** Limited
- **Soft AP Mode:** Supported (Can act as a wireless hotspot)
- **Bluetooth:** Not supported
- **VIF (Virtual Interface / Fusion):** Not natively supported by the out-of-kernel Realtek driver.

7. Target Audience × Application Scenarios

- **Home & Office Power Users:** The primary audience. Instantly upgrades older Windows or Linux laptops/desktops to modern WiFi 6 standards, providing seamless 4K/8K streaming, low-latency gaming, and rapid file transfers.
- **Congested Network Environments:** Excellent for users in apartments or dense offices where OFDMA and MU-MIMO technologies are required to maintain a stable connection amidst heavy background interference.
- **Custom Network Projects:** Ideal for PC builders or Raspberry Pi developers who need high-speed managed mode networking with the flexibility to attach long-range directional antennas.
- _(Note: Cybersecurity Professionals looking for robust Monitor Mode, Packet Injection, and VIF support should look toward the AWUS036ACH or AWUS036ACM instead.)_

--------------------------------------------------------------------------------

8. Kali Linux (2025): Driver Installation & Advanced Modes

_Because the AWUS036AX uses the Realtek RTL8832BU chipset, its driver is out-of-kernel for versions prior to Linux 6.14. You must compile the DKMS driver from community repositories (such as morrownr)._

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

**4. Fusion / VIF (Virtual Interface):** _Note: Out-of-kernel Realtek drivers generally lack robust multi-state Virtual Interface (VIF) concurrency. Operating Monitor Mode and Managed/AP mode simultaneously is not recommended on this hardware._

--------------------------------------------------------------------------------

9. Ubuntu 22.04 & 24.04: Driver Installation & Advanced Modes

**1. Driver Installation:** Ubuntu distributions require the exact same manual DKMS compilation to ensure the driver survives kernel updates:

```
sudo apt update
sudo apt install -y build-essential dkms git linux-headers-$(uname -r)
git clone https://github.com/morrownr/rtl8852bu-20240418.git
cd rtl8852bu-20240418
sudo ./install-driver.sh
sudo reboot
```

**2. Enable Monitor Mode and Injection:** The commands for attempting Monitor Mode and Packet Injection on Ubuntu are exactly identical to the Kali Linux instructions in Section 8.

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

**2. Enable Monitor Mode and Injection:** The commands for configuring Monitor Mode and Packet Injection on Debian are exactly identical to the Kali Linux instructions in Section 8.

--------------------------------------------------------------------------------

11. Raspberry Pi 4B & 5: Driver Installation

For the Raspberry Pi, you must use the specific ARM-compatible kernel headers to compile the driver successfully.

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

Once rebooted, the Raspberry Pi will recognize the AWUS036AX, allowing you to connect to high-speed WiFi 6 networks or deploy basic Soft AP configurations.


---

### Resources
| Resource | Link |
|---|---|
| Documentation | https://docs.alfa.com.tw/ |
| Linux Driver (RTL8832BU) | https://github.com/morrownr/rtl8852bu-20240418 |
