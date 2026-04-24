You just got the AWUS036ACH and your Linux machine doesn't recognize it. That's normal — this chip needs the RTL8812AU driver, and it's not plug-and-play. This guide walks you through the full install in about 30 minutes, using only domestic mirrors. No GitHub access needed.

## Before You Start

Make sure you have these ready:

1. **ALFA AWUS036ACH** adapter
2. USB cable (the one that came in the box works fine)
3. A powered USB hub — required if you're on Raspberry Pi
4. Active internet connection to reach domestic mirrors

Plug in the adapter, then confirm your system sees it:

```bash
lsusb
```

Look for this in the output:

```bash
Bus 001 Device 003: ID 0bda:8812 Realtek Semiconductor Corp.
```

If you see `0bda:8812`, the adapter is detected. Move to your OS section below.

If you don't see it, try a different USB port or swap the cable, then run `lsusb` again.

## Choose Your Operating System

Jump to the right section for your OS:

- [Kali Linux](#kali-linux)
- [Ubuntu 22.04 / 24.04](#ubuntu-2204--2404)
- [Debian](#debian)
- [Raspberry Pi 4B / 5](#raspberry-pi-4b--5)

Already installed? Skip to:

- [Enable Monitor Mode](#enable-monitor-mode)
- [Test Packet Injection](#test-packet-injection)
- [VM USB Passthrough](#vm-usb-passthrough)

---
