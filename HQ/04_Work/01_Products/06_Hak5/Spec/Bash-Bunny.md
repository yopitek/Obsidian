---
title: Bash Bunny Mark II
model: Bash Bunny Mark II
category: Multi-Vector USB Attack
tags: [hak5, usb, hid, ethernet, storage, bash, duckyscript, bluetooth, hotplug]
shop_url: https://shop.hak5.org/products/bash-bunny
docs_url: https://docs.hak5.org/bash-bunny/
captured_at: 2026-04-16
---

# Bash Bunny Mark II

> When the light turns green, it's a hacked machine.

## Overview

The Bash Bunny is the world's most advanced USB attack platform. It simultaneously emulates multiple trusted USB devices — keyboard, Ethernet adapter, serial, and flash storage — to trick computers into divulging data, installing backdoors, and exfiltrating documents. Mark II adds Bluetooth LE, MicroSD, and a 7-second boot time.

## Specifications

| Spec | Mark I | Mark II |
|------|--------|---------|
| **CPU** | Quad-Core A7 @ 1.3 GHz | Quad-Core A7 @ 1.3 GHz |
| **Storage** | 8 GB NAND SSD | 8 GB NAND SSD + MicroSD XC (up to 2 TB) |
| **Wireless** | — | Bluetooth Low Energy |
| **Boot Time** | — | 7 seconds |
| **Switch** | 3-position mode switch | 3-position mode switch |
| **LED** | RGB | RGB |
| **Console** | Serial | Serial (dedicated) |

## Mark II New Features

- **MicroSD XC** — Expand storage up to 2 TB for mass exfiltration
- **Bluetooth LE** — Remote triggers and geofencing
- **Geofencing** — Prevent payload execution outside target premises; destroy loot if removed
- **Remote Triggers** — Trigger payload stages from phone app or BT device
- **Faster Performance** — Optimized quad-core CPU and desktop-class SSD

## Attack Modes

| Mode | Command Example |
|------|----------------|
| HID + Ethernet | `ATTACKMODE HID AUTO_ETHERNET` |
| Keystroke Injection | `RUN WIN cmd /K color a \& tree c:\\` |
| Hostname Discovery | `GET TARGET_HOSTNAME` |
| BT Wait | `WAIT_FOR_PRESENT my-device-name` |
| LED | `LED R` (red), `LED B` (blue) |

## Use Cases

- Credential harvesting from locked machines
- Data exfiltration (gigs of loot via MicroSD)
- Backdoor installation
- Network hijacking via USB Ethernet emulation
- IT automation and vulnerability scanning (nmap, metasploit, responder, impacket)
- Physical engagement payloads

## Payload System

- Written in **DuckyScript™** (simple text files)
- Full **Bash** and Linux tool access
- Community payload library: [payloads.hak5.org](https://payloads.hak5.org)
- Select payload with 3-way switch; monitor via RGB LED
- Flash drive mode for easy configuration

## Documentation

- [Official Docs](https://docs.hak5.org/bash-bunny/)
- [Shop Page](https://shop.hak5.org/products/bash-bunny)
