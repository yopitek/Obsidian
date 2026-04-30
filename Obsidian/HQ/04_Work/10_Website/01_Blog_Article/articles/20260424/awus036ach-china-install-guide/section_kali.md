## Kali Linux

Kali comes with strong wireless tooling built in. Getting the AWUS036ACH driver running takes four steps. Start by switching to a fast Chinese mirror so every download stays quick.

### Step 1: Switch to China Mirror

Open your sources list in the terminal.

```bash
sudo nano /etc/apt/sources.list
```

Delete whatever is there, then paste this line:

```
deb http://mirrors.ustc.edu.cn/kali kali-rolling main contrib non-free non-free-firmware
```

Save the file: press **Ctrl+O**, then Enter, then Ctrl+X to exit. Refresh the package index.

```bash
sudo apt update
```

> **Backup mirror:** If 中科大 (USTC) is slow on your connection, use 清华 (Tsinghua) instead:
> `deb https://mirrors.tuna.tsinghua.edu.cn/kali kali-rolling main contrib non-free non-free-firmware`

---

### Step 2: Install the Driver

Kali's package repository includes a prebuilt DKMS driver. Install it with one command.

```bash
sudo apt install -y realtek-rtl88xxau-dkms
```

DKMS automatically recompiles the driver whenever your kernel updates, so you will not need to reinstall manually after an upgrade.

Verify the driver loaded correctly.

```bash
modinfo 88XXau | grep -E "filename|version"
```

You should see a `filename` line ending in `.ko` and a `version` line showing a version string like `5.6.4.2`. If both appear, the driver is ready.

---

### Step 2 (Alternative): Manual Compile from Source

Only follow this section if the `apt install` above failed. First install the build dependencies.

```bash
sudo apt install -y git dkms build-essential libelf-dev linux-headers-$(uname -r)
```

Download the driver source from Gitee.

```bash
git clone https://gitee.com/mirrors/rtl8812au.git
```

> **NOTE:** If that URL does not load, search Gitee for `rtl8812au` and pick the most recently updated fork. You can also download a source archive directly from [files.alfa.com.tw](https://files.alfa.com.tw).

Move into the cloned directory, then compile and install.

```bash
make
sudo make install
sudo dkms add .
sudo dkms install rtl8812au/$(cat VERSION)
```

Load the driver into the running kernel.

```bash
sudo modprobe 88XXau
```

---

### Step 3: Enable Monitor Mode {#enable-monitor-mode}

Before putting the adapter into monitor mode, check which interface name your system assigned it.

```bash
iwconfig
```

Look for a `wlan0` or `wlan1` entry. Use that name in the commands below.

Stop NetworkManager and wpa_supplicant — both fight over the adapter and will block monitor mode.

```bash
sudo airmon-ng check kill
sudo airmon-ng start wlan0
```

Confirm the switch worked.

```bash
iwconfig
```

Look for an entry like `wlan0mon` with `Mode:Monitor`. When you see that, the adapter is ready for packet capture.

---

### Step 4: Test Packet Injection {#test-packet-injection}

Run the injection test against the monitor interface.

```bash
sudo aireplay-ng --test wlan0mon
```

A successful result looks like this:

```
Trying broadcast probe requests...
Injection is working!
Found 1 AP
```

If the test fails, reboot the machine and run the test again. If it still fails after a reboot, confirm no other process holds the interface — run `iwconfig` and make sure only `wlan0mon` appears, with nothing else claiming the adapter.

---
