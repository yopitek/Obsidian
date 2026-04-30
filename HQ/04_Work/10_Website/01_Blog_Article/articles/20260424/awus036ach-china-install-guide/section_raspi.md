## Raspberry Pi 4B / 5

> The AWUS036ACH draws ~500mW. Plugging it directly into a Raspberry Pi USB port can cause the Pi to throttle or restart under load. **Always use a powered USB hub.**

---

### Step 1: Download Kali Linux ARM64 Image

Go to the official Kali ARM downloads page:
https://www.kali.org/get-kali/#kali-arm

Pick **Raspberry Pi 4 (64-bit)** or **Raspberry Pi 5 (64-bit)** to match your board. Do not download the 32-bit image — the driver build requires a 64-bit kernel.

> **China mirror:** If kali.org loads slowly, try 华为云 instead:
> https://repo.huaweicloud.com/kali-images/
> Browse to the latest release folder and download the same ARM64 image from there.

---

### Step 2: Flash to MicroSD

Insert your microSD card, then check its device path before writing anything.

```bash
lsblk
```

Find your card in the list — it will show as something like `sdb` or `mmcblk0`. Then flash the image, replacing `/dev/sdX` with your actual path.

```bash
# Replace /dev/sdX with your actual SD card (check with lsblk)
sudo dd if=kali-linux-2025.1-raspberry-pi-arm64.img of=/dev/sdX bs=4M status=progress conv=fsync
sync
```

Wait for `sync` to finish before pulling the card. Boot the Pi from the card. Default credentials after boot: **kali / kali**.

---

### Step 3: Switch to China Mirror

After first boot, open the package sources file.

```bash
sudo nano /etc/apt/sources.list
```

Delete everything in the file and replace it with this single line:

```
deb http://mirrors.ustc.edu.cn/kali kali-rolling main contrib non-free non-free-firmware
```

Save: press **Ctrl+O**, then Enter, then Ctrl+X. Now apply the mirror and upgrade the system.

```bash
sudo apt update && sudo apt full-upgrade -y
sudo reboot
```

The reboot picks up any kernel updates before you install the driver.

---

### Step 4: Install Driver (ARM64)

The DKMS package works on ARM64 exactly the same as x86 — no special steps needed.

```bash
sudo apt install -y realtek-rtl88xxau-dkms
```

If that command returns an error saying the package is not found, compile the driver from source instead.

```bash
sudo apt install -y git dkms build-essential libelf-dev linux-headers-$(uname -r)
git clone https://gitee.com/mirrors/rtl8812au.git
cd rtl8812au
make
sudo make install
sudo dkms add .
sudo dkms install rtl8812au/$(cat VERSION)
sudo modprobe 88XXau
```

---

### Step 5: Enable Monitor Mode

Before touching the adapter, check which interface name the Pi assigned it.

```bash
iwconfig
```

On a Pi with a built-in Wi-Fi chip, the AWUS036ACH often shows up as `wlan1` rather than `wlan0`. Note the name, then substitute it below.

```bash
sudo airmon-ng check kill
sudo airmon-ng start wlan0
```

Run `iwconfig` again and look for an entry ending in `mon` with `Mode:Monitor`. That confirms the adapter switched successfully.

---

### Step 6: Test Packet Injection

```bash
sudo aireplay-ng --test wlan0mon
```

A working adapter prints `Injection is working!`. If the test fails, reboot and try once more. A bad USB connection through an unpowered hub is the most common cause on Pi — double-check you are using the powered hub.

---
