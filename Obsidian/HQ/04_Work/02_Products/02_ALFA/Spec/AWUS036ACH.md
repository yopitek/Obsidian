---
model: AWUS036ACH
brand: ALFA Network
category: USB WiFi Adapter
wifi_gen: WiFi 5
chipset: Realtek RTL8812AU
max_speed_mbps: 867
usb_type: USB-C 3.0
antenna: 2x RP-SMA 5dBi detachable
bluetooth: false
monitor_mode: excellent
kali_linux: excellent
linux_driver: out-of-kernel (in-kernel ≥6.14)
power_amplifier: true
status: Active
tags: [alfa, usb-adapter, wifi5, kali, pentest, monitor-mode, gold-standard]
---
AWUS036ACH_spec.md

1. Hero Cover

- **Product Title:** ALFA Network AWUS036ACH – WiFi 5 AC1200 USB-C Adapter
- **Tagline:** The Gold Standard for Security Research and Extreme Range
- **Badges:** ✅ Kali Linux Official Support | ✅ AC1200 Dual-Band | ✅ High Power Amplifier | ✅ USB 3.0 Type-C

2. Product Conceptual Map

- **Form Factor:** Sleek, dark grey matte finish with a rugged, professional design built for long-range operations.
- **Antenna Design:** Dual detachable high-gain 5dBi dipole antennas ensuring a wide range across greater distances.
- **Connectivity:** World's first WiFi 5 adapter featuring a robust USB Type-C SuperSpeed interface (with backward compatibility to USB 2.0).
- **Mounting:** Comes with an exclusive screen clip mount to easily attach the adapter to a laptop screen or monitor bezel.

3. 6 Core Features (Radiating Map)

4. **Realtek RTL8812AU Chipset:** The industry's most tested and trusted chipset for penetration testing and cybersecurity auditing.
5. **Superb Dual-Band Performance:** Operates on 2.4 GHz and 5 GHz bands with AC1200 combined speeds.
6. **Extreme Range & High Power:** Built-in power amplifier delivers unmatched wireless signal penetration, picking up signals at up to 3x the range of internal laptop cards.
7. **Advanced Security Research:** Native community support for Monitor Mode and Packet Injection in Kali Linux and Parrot OS.
8. **Type-C SuperSpeed:** USB 3.0 Type-C connectivity eliminates bottlenecks and provides stable power delivery during high-load packet injection.
9. **Hardware Flexibility:** Detachable RP-SMA female connectors allow seamless upgrades to directional panel or Yagi antennas.

10. Full Specifications Table

|Feature|Specification|
|---|---|
|**Chipset**|Realtek™ RTL8812AU|
|**WiFi Standards**|IEEE 802.11 a/b/g/n/ac (WiFi 5)|
|**Frequency**|2.4 GHz / 5 GHz|
|**Interface**|Type-C SuperSpeed USB 3.0 (USB 2.0 backward compatible)|
|**Antenna Connector**|2x RP-SMA (female)|
|**Included Antennas**|2x 2.4GHz + 5GHz Dual-Band 5dBi dipole antennas|
|**Wireless Security**|WEP, WPA, WPA2, WPA Mixed, WPS, 802.1X|
|**Power Consumption**|0.7 A on 5 V (Max)|
|**Dimensions**|85 x 63 x 20 mm|
|**Weight**|0.5 kg (packaged)|

**Hardware Support:**

- Desktop / Laptop PC (Windows & Linux)
- Raspberry Pi 3B+ / 4 / 5
- Mac (Intel) - Supported up to macOS 10.15 Catalina
- _(Note: Mac ARM / Apple Silicon is NOT supported)_

5. Speed Dashboard

- **2.4 GHz Band:** Up to 300 Mbps (Ideal for legacy compatibility and extreme distance wall penetration)
- **5 GHz Band:** Up to 867 Mbps (High-speed AC performance for data-heavy tasks)
- **Combined Capacity:** AC1200 Class

6. Support OS Version & Advanced Capabilities

**OS Support:**

- **Windows 10 / 11:** Full support with WPA3 capabilities via updated drivers
- **macOS:** macOS 10.15 Catalina maximum (Intel only)
- **Ubuntu 22.04 / 24.04:** Supported (Requires manual DKMS out-of-kernel driver installation)
- **Kali Linux (2025):** Excellent support (Supported natively by Aircrack-ng community drivers)
- **NetHunter (Android):** Supported via USB-OTG cable

**Advanced Capabilities:**

- **Monitor Mode:** Excellent (Gold standard for passive capturing of 802.11 frames)
- **Packet Injection:** Excellent (Industry-leading active frame injection performance)
- **Soft AP Mode:** Supported (Can act as a rogue access point/evil twin)
- **Bluetooth:** Not supported
- **VIF (Virtual Interface / Fusion):** Limited (The RTL8812AU driver has limited VIF concurrency capabilities compared to MediaTek alternatives)

7. Target Audience × Application Scenarios

- **Cybersecurity Professionals & Penetration Testers:** The undisputed favorite for capturing WPA/WPA2 handshakes, running deauthentication attacks, and mapping networks using the Aircrack-ng suite.
- **Kali Linux Students & Beginners:** The most widely documented adapter in ethical hacking courses, guaranteeing compatibility with standard training labs.
- **Long-Range Reconnaissance:** Ideal for users needing to audit distant targets, thanks to the high-power amplifier and dual external 5dBi antennas.
- **Mobile Hackers (NetHunter):** Security researchers running Kali NetHunter on rooted Android phones via OTG connections for discrete, on-the-go auditing.

--------------------------------------------------------------------------------

8. Kali Linux (2025): Driver Installation & Advanced Modes

_Because the AWUS036ACH uses the Realtek RTL8812AU chipset, its driver is out-of-kernel. You must compile the DKMS driver from the community repositories._

**1. Driver Installation:** Ensure your system is fully updated, install the headers, and clone the official `aircrack-ng` repository:

```
sudo apt update && sudo apt upgrade -y
sudo apt install make iw git linux-headers-$(uname -r) build-essential dkms
git clone https://github.com/aircrack-ng/rtl8812au.git
cd rtl8812au
make
sudo make install
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

**4. Fusion / VIF (Virtual Interface):** _Note: The_ _rtl8812au_ _driver does not natively support complex multi-state Virtual Interfaces (VIF) or Active Monitor Mode robustly._ It is recommended to use the adapter either strictly in Monitor Mode or Managed Mode.

--------------------------------------------------------------------------------

9. Ubuntu 22.04 & 24.04: Driver Installation & Advanced Modes

Ubuntu distributions require manual compilation of the DKMS driver to ensure it survives kernel updates.

**1. Driver Installation:**

```
sudo apt update
sudo apt install git build-essential dkms linux-headers-$(uname -r)
git clone https://github.com/morrownr/8812au-20210708.git
cd 8812au-20210708
sudo ./install-driver.sh
sudo reboot
```

**2. Enable Monitor Mode and Injection:** The commands for setting Monitor Mode (`iw dev wlan1 set type monitor`) and Packet Injection (`aireplay-ng -9 wlan1`) on Ubuntu are identical to the Kali Linux instructions in Section 8.

--------------------------------------------------------------------------------

10. Debian: Driver Installation & Advanced Modes

**1. Driver Installation:** Debian requires identical steps to Ubuntu. Ensure you have the `build-essential` and `dkms` packages installed:

```
sudo apt update
sudo apt install git build-essential dkms linux-headers-$(uname -r)
git clone https://github.com/aircrack-ng/rtl8812au.git
cd rtl8812au
sudo make dkms_install
sudo reboot
```

**2. Enable Monitor Mode and Injection:** The commands for Monitor Mode and Packet Injection on Debian are identical to the Kali Linux instructions in Section 8.

--------------------------------------------------------------------------------

11. Raspberry Pi 4B & 5: Driver Installation

The AWUS036ACH requires a powerful power supply (at least 2.5A to 3A) when used with a Raspberry Pi to prevent brownouts during packet injection.

**1. System Update & Dependencies:**

```
sudo apt update && sudo apt full-upgrade
sudo apt install git bc dkms build-essential raspberrypi-kernel-headers
```

**2. Driver Compilation (ARM architecture):** Clone a repository optimized for the Pi (such as `morrownr`) and install:

```
git clone https://github.com/morrownr/8812au-20210708.git
cd 8812au-20210708
sudo ./install-driver.sh
```

**3. Power Optimization Fix:** Because the AWUS036ACH draws high power, you must disable USB power savings to prevent drops during penetration testing:

```
sudo nano /etc/modprobe.d/8812au.conf
# Add the following line:
options 8812au rtw_power_mgnt=0 rtw_enusbss=0
```

Save, exit, and `sudo reboot`



---

### Resources
| Resource | Link |
|---|---|
| Official Product Page | https://www.alfa.com.tw/products/awus036ach_1 |
| Documentation | https://docs.alfa.com.tw/Product/AWUS036ACH/ |
| Driver (Kali/aircrack-ng) | https://github.com/aircrack-ng/rtl8812au |
| Driver (general Linux) | https://github.com/morrownr/8812au-20210708 |
