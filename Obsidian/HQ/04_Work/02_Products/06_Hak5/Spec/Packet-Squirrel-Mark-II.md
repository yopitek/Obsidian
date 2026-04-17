---
title: Packet Squirrel Mark II
model: Packet Squirrel Mark II
category: Network Man-in-the-Middle
tags: [hak5, ethernet, mitm, linux, duckyscript, python, bash, cloud-c2, packet-capture, vpn]
shop_url: https://shop.hak5.org/products/packet-squirrel
docs_url: https://docs.hak5.org/packet-squirrel-mk-ii/
captured_at: 2026-04-16
---

# Packet Squirrel Mark II

> The man-in-the-middle that's nuts for networks.

## Overview

The Packet Squirrel is a stealthy pocket-sized man-in-the-middle device. Plug it inline between a target and their network, flip a switch, and it runs network interception, manipulation, and exfiltration payloads. Now powered by DuckyScript™, Bash, and Python with 20+ new commands for advanced traffic control.

## Specifications

| Spec | Value |
|------|-------|
| **Size** | 50 × 40 × 15 mm |
| **Weight** | 24 grams |
| **Power** | USB-C (0.2A) |
| **Ethernet** | 2× Ethernet ports |
| **USB** | USB 2.0 host |
| **Input** | Push-button |
| **LED** | RGB |
| **OS** | Linux (root access) |
| **Operating Temp** | 35°C ~ 45°C |
| **Storage Temp** | -20°C ~ 50°C |
| **Humidity** | 0% to 90% (non-condensing) |

## Setup

1. Plug inline between target device and network
2. Flip switch to select payload
3. Connect USB-C power source

## Key DuckyScript Commands (Mark II)

| Command | Function |
|---------|----------|
| `DYNAMICPROXY` | Proxy & intercept TCP traffic; log client/server data |
| `KILLPORT` | Terminate traffic on a TCP port via RST injection |
| `KILLSTREAM` | Terminate TCP streams matching a regex |
| `SPOOFDNS` | Redirect DNS queries via packet injection |
| `SELFDESTRUCT` | Factory reset + wipe USB, enter TRANSPARENT mode |
| `NETMODE` | Set networking mode |
| `SWITCH` | Read switch position |
| `LED` | Control RGB LED |
| `C2EXFIL` | Exfiltrate to Cloud C² |
| `C2NOTIFY` | Send notification to Cloud C² |

## Pre-Loaded Payloads

- **Simple Packet Sniffing** — Log traffic to USB as PCAP
- **Gatekeeper** — Toggle network access with push-button
- **Printer Capture** — Capture PCL IP printer jobs in plaintext
- **DNS Sinkhole** — Intercept/redirect DNS requests
- **VPN** — OpenVPN and WireGuard for remote access

## Networking Capabilities

- Packet capture (pcap) for Wireshark analysis
- TCP stream manipulation and injection
- DNS spoofing
- Dynamic proxy with full logging
- VPN tunneling (OpenVPN, WireGuard)
- Python scripting support

## Bundle Options

| Bundle | Includes |
|--------|---------|
| Basic | Hardware + PayloadStudio Community |
| Pro | Hardware + PayloadStudio Pro + Pocket Guide |
| Elite | Hardware + PayloadStudio Pro + 290-page Textbook + Pocket Guide |
| Advanced | TAA Compliant + Cloud C² Teams + Priority Support |

## Documentation

- [Official Docs](https://docs.hak5.org/packet-squirrel-mk-ii/)
- [Shop Page](https://shop.hak5.org/products/packet-squirrel)
