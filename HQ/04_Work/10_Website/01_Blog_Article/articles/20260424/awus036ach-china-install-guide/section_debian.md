## Debian

Debian's package manager points to overseas servers by default. Switching to 清华大学 (Tsinghua University) mirror brings download speeds from overseas crawl to local sprint.

### Step 1: Switch to China Mirror

Open the sources list:

```bash
sudo nano /etc/apt/sources.list
```

Delete everything inside and paste these three lines (Debian 12 Bookworm):

```
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware
```

Save with `Ctrl+O`, then exit with `Ctrl+X`. Refresh the package index:

```bash
sudo apt update
```

### Step 2: Install Build Dependencies

The AWUS036ACH driver compiles from source, so you need the kernel headers and build tools:

```bash
sudo apt install -y git dkms build-essential libelf-dev linux-headers-$(uname -r)
```

This command tailors the header package to your running kernel version automatically.

### Step 3: Download Driver Source (China Mirror)

Clone the driver repository from Gitee:

```bash
git clone https://gitee.com/mirrors/rtl8812au.git
```

Move into the project folder:

```bash
cd rtl8812au
```

> **Can't reach that URL?** Search Gitee for `rtl8812au` and pick the most recently updated fork.

### Step 4: Compile and Install

Run these commands in sequence inside the `rtl8812au` folder:

```bash
make
sudo make install
sudo dkms add .
sudo dkms install rtl8812au/$(cat VERSION)
sudo modprobe 88XXau
```

`dkms` registers the driver so it survives kernel updates automatically.

### Step 5: Enable Monitor Mode

**Kill interfering processes** before switching modes:

```bash
sudo airmon-ng check kill
```

Start monitor mode on your adapter:

```bash
sudo airmon-ng start wlan0
```

If `airmon-ng` is missing, install it first:

```bash
sudo apt install -y aircrack-ng
```

Confirm the interface came up:

```bash
iwconfig
```

Look for an interface named `wlan0mon` in the output.

### Step 6: Test Packet Injection

```bash
sudo aireplay-ng --test wlan0mon
```

A stream of injection test results confirms the adapter works. You're ready to go.

---
