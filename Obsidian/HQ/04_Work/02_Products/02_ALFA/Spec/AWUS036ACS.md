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

AWUS036ACS_spec.md

1. Hero Cover

- **Product Title:** ALFA Network AWUS036ACS – WiFi 5 AC600 USB 2.0 Adapter
- **Tagline:** The Ultra-Compact, Budget-Friendly Security Research Adapter
- **Badges:** ✅ Kali Linux Support | ✅ AC600 Dual-Band | ✅ Ultra-Compact | ✅ Detachable Antenna

2. Product Conceptual Map

- **Form Factor:** Compact, lightweight black matte chassis with a distinctive stepped design that minimizes bulk.
- **Antenna Design:** Features a single detachable 2dBi dual-band dipole antenna, providing a low-profile footprint while allowing upgrades to high-gain directional antennas.
- **Connectivity:** USB 2.0 Type-A interface with a durable brass-colored connector.
- **Mounting:** Comes with an included USB cradle dock, providing flexibility for desktop placement to achieve optimal signal reception without blocking adjacent laptop ports.

3. 6 Core Features (Radiating Map)

4. **Realtek RTL8811AU Chipset:** Renowned for its community-driven out-of-kernel Linux driver, enabling essential security research features.
5. **AC600 Dual-Band Performance:** Operates on both 2.4 GHz and 5 GHz bands, perfect for targeting both legacy devices and modern access points.
6. **Ultra-Compact Portability:** Measuring just 5.5 x 2.5 cm, it is highly portable for on-the-go wireless auditing.
7. **Hardware Flexibility:** The RP-SMA female connector allows for seamless upgrades to directional panel antennas (like the ALFA APA-M25) or high-gain Yagi antennas.
8. **Advanced Security Research:** Supports Monitor Mode and Packet Injection in Kali Linux, Ubuntu, and Parrot OS.
9. **Included USB Dock:** Extends placement options to improve line-of-sight signal capture.

10. Full Specifications Table

|Feature|Specification|
|---|---|
|**Chipset**|Realtek™ RTL8811AU|
|**WiFi Standards**|IEEE 802.11 a/b/g/n/ac (WiFi 5)|
|**Frequency**|2.412GHz – 2.472GHz / 5.15GHz – 5.825GHz|
|**Interface**|USB 2.0 Type-A|
|**Antenna Connector**|1x RP-SMA (female)|
|**Included Antenna**|1x External detachable dual-band 2.4GHz+5GHz 2dBi antenna|
|**Wireless Security**|64/128bit WEP, WPA, WPA2, WPA Mixed, WPS|
|**Dimensions**|5.5 x 1.0 x 2.5 cm (L x H x W)|
|**Weight**|80g (with packaging/accessories)|

**Hardware Support:**

- Raspberry Pi 3B+ / 4 / 5
- Desktop / Laptop PC (Windows & Linux)
- Mac (Intel) - Supported up to macOS 10.14 Mojave maximum
- _(Note: Mac ARM / Apple Silicon is NOT supported)_

5. Speed Dashboard

- **2.4 GHz Band:** Up to 150 Mbps
- **5 GHz Band:** Up to 433 Mbps
- **Combined Capacity:** AC600 Class

6. Support OS Version & Advanced Capabilities

**OS Support:**

- **Windows 10 / 11:** Full support via official ALFA drivers
- **macOS:** macOS 10.5 to 10.14 Mojave maximum (Intel only)
- **Ubuntu 22.04 / 24.04:** Supported (Requires manual DKMS driver installation)
- **Kali Linux (2025):** Supported (Requires manual DKMS driver installation)
- **NetHunter (Android):** Supported via USB-OTG cable

**Advanced Capabilities:**

- **Monitor Mode:** Supported (Requires community DKMS driver)
- **Packet Injection:** Supported (Requires community DKMS driver)
- **Soft AP Mode:** Supported
- **Bluetooth:** Not supported
- **VIF (Virtual Interface / Fusion):** Not natively supported (The RTL8811AU driver lacks robust multi-state virtual interface concurrency compared to MediaTek alternatives).

7. Target Audience × Application Scenarios

- **Cybersecurity Students & Beginners:** The most budget-friendly ALFA adapter capable of monitor mode, making it perfect for those learning ethical hacking and the `aircrack-ng` suite.
- **Mobile Penetration Testers:** Its ultra-compact size combined with Kali NetHunter Android support makes it an excellent choice for discrete, on-the-go wardriving via OTG.
- **Budget Dual-Band Reconnaissance:** Ideal for users who need to audit 5 GHz networks but do not want to invest in the larger, more expensive AC1200 hardware.

--------------------------------------------------------------------------------

8. Kali Linux (2025): Driver Installation & Advanced Modes

_Because the AWUS036ACS uses the Realtek RTL8811AU chipset, the driver is out-of-kernel. You must compile the DKMS driver from the community repositories (such as morrownr)._

**1. Driver Installation:** Ensure your system is updated and has the necessary build tools:

```
sudo apt update && sudo apt upgrade -y
sudo apt install build-essential dkms bc iw git linux-headers-$(uname -r)
git clone https://github.com/morrownr/8821au-20210708.git
cd 8821au-20210708
sudo ./install-driver.sh
sudo reboot
```

**2. Enable Monitor Mode:** Assuming your adapter is `wlan1`:

```
sudo ip link set wlan1 down
sudo airmon-ng check kill
sudo iw dev wlan1 set type monitor
sudo ip link set wlan1 up
```

**3. Packet Injection Test:**

```
sudo aireplay-ng --test wlan1
```

**4. Fusion / VIF (Virtual Interface):** _Note: The RTL8811AU driver does not natively support robust Virtual Interfaces (VIF). Concurrent operation of Monitor Mode and Managed/AP mode is not recommended on this hardware._

--------------------------------------------------------------------------------

9. Ubuntu 22.04 & 24.04: Driver Installation & Advanced Modes

**1. Driver Installation:** Ubuntu distributions require identical manual DKMS compilation to survive kernel updates:

```
sudo apt update
sudo apt install build-essential dkms git linux-headers-$(uname -r)
git clone https://github.com/morrownr/8821au-20210708.git
cd 8821au-20210708
sudo ./install-driver.sh
sudo reboot
```

**2. Enable Monitor Mode and Injection:** The commands for setting Monitor Mode and testing Packet Injection on Ubuntu are exactly identical to the Kali Linux instructions in Section 8.

--------------------------------------------------------------------------------

10. Debian: Driver Installation & Advanced Modes

**1. Driver Installation:** Debian requires the "non-free" repositories to be enabled in your sources.list to retrieve proper dependencies.

```
sudo apt update
sudo apt install git build-essential dkms linux-headers-$(uname -r)
git clone https://github.com/morrownr/8821au-20210708.git
cd 8821au-20210708
sudo ./install-driver.sh
sudo reboot
```

**2. Enable Monitor Mode and Injection:** The commands for Monitor Mode and Packet Injection on Debian are exactly identical to the Kali Linux instructions in Section 8.

--------------------------------------------------------------------------------

11. Raspberry Pi 4B & 5: Driver Installation

For the Raspberry Pi, you must use the specific ARM-compatible kernel headers.

**1. System Update & Dependencies:**

```
sudo apt update && sudo apt full-upgrade
sudo apt install git bc dkms build-essential raspberrypi-kernel-headers
```

**2. Driver Compilation (ARM architecture):** Clone the repository and run the installer script:

```
git clone https://github.com/morrownr/8821au-20210708.git
cd 8821au-20210708
sudo ./install-driver.sh
sudo reboot
```

Once rebooted, the Raspberry Pi will recognize the AWUS036ACS, allowing you to utilize `airmon-ng` just as you would on a standard PC.

---

### Resources
| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036acs_1 |
| Documentation | https://docs.alfa.com.tw/Product/AWUS036ACS/ |
| Linux Driver (RTL8811AU) | https://github.com/morrownr/8821au-20210708 |
