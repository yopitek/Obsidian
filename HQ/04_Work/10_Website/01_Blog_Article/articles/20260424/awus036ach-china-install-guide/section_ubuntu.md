## Ubuntu 22.04 / 24.04

Ubuntu splits into two branches with different package file formats. The steps below handle both. Use **阿里云 (Aliyun)** as your mirror — it's fast, reliable, and maintained by Alibaba.

### Step 1: Switch to China Mirror

Pick your Ubuntu version and follow that path only.

#### Ubuntu 24.04 (Noble)

Open the new DEB822-format sources file:

```bash
sudo nano /etc/apt/sources.list.d/ubuntu.sources
```

Delete everything in the file and paste this exact content:

```
Types: deb
URIs: http://mirrors.aliyun.com/ubuntu/
Suites: noble noble-updates noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
```

Save with `Ctrl+O`, then exit with `Ctrl+X`.

#### Ubuntu 22.04 (Jammy)

Open the classic sources file instead:

```bash
sudo nano /etc/apt/sources.list
```

Replace all existing lines with:

```
deb http://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
```

Save and exit the same way (`Ctrl+O`, then `Ctrl+X`).

#### Refresh the package index

Run this for both versions after editing your sources file:

```bash
sudo apt update
```

---

### Step 2: Install Build Dependencies

The driver compiles from source, so you need the kernel headers and build tools first:

```bash
sudo apt install -y git dkms build-essential libelf-dev linux-headers-$(uname -r)
```

This pulls in gcc, make, and the exact headers that match your running kernel. The `$(uname -r)` part auto-detects your kernel version — no need to type it manually.

---

### Step 3: Download Driver Source (China Mirror)

Clone the driver repository from Gitee, which is accessible inside China:

```bash
git clone https://gitee.com/mirrors/rtl8812au.git
```

Then move into the cloned folder:

```bash
cd rtl8812au
```

> **Note:** If that URL times out or returns a 404, go to [gitee.com](https://gitee.com) and search for `rtl8812au`. Pick the fork with the most recent commit date.

---

### Step 4: Compile and Install

Build the kernel module from source:

```bash
make
```

Install it into the system:

```bash
sudo make install
```

Register the module with DKMS so it survives kernel upgrades:

```bash
sudo dkms add .
sudo dkms install rtl8812au/$(cat VERSION)
```

Load the module into the running kernel:

```bash
sudo modprobe 88XXau
```

Verify the module loaded correctly:

```bash
modinfo 88XXau | grep filename
```

You should see a path ending in `88XXau.ko` or similar. If the command returns output, the driver is active.

---

### Step 5: Enable Monitor Mode

First, kill any processes that might interfere with the wireless interface:

```bash
sudo airmon-ng check kill
```

Then put the adapter into monitor mode:

```bash
sudo airmon-ng start wlan0
```

> **Note:** Your interface may be named `wlan1` instead of `wlan0`. Run `iwconfig` first to see all wireless interfaces listed, then substitute the correct name in the command above.

---

### Step 6: Test Packet Injection

With the adapter in monitor mode, run the injection test:

```bash
sudo aireplay-ng --test wlan0mon
```

A successful result shows lines like `Injection is working!`. If you see errors about the interface, double-check that monitor mode is active with `iwconfig wlan0mon`.

---
