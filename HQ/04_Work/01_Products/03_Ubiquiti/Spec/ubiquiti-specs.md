# Ubiquiti 產品規格彙整報告

**生成時間 Generated At:** 2026/3/19 上午7:08:25
**產品總數 Total Products:** 10

**資料來源 Data Sources:**
- https://ui.com/
- https://techspecs.ui.com/

════════════════════════════════════════════════════════════

## 目錄 Table of Contents

1. [Wave MLO6 `Wave-MLO6`](#1-wave-mlo6-wavemlo6)
2. [Wave MLO5 `Wave-MLO5`](#2-wave-mlo5-wavemlo5)
3. [UniFi Dream Router 7 `UDR7`](#3-unifi-dream-router-7-udr7)
4. [UniFi Cloud Gateway Fiber `UCG-Fiber`](#4-unifi-cloud-gateway-fiber-ucgfiber)
5. [UniFi Flex Mini 2.5G `USW-Flex-2.5G-5`](#5-unifi-flex-mini-25g-uswflex25g5)
6. [UniFi U7 Pro `U7-Pro`](#6-unifi-u7-pro-u7pro)
7. [UniFi U7 Pro Max `U7-Pro-Max`](#7-unifi-u7-pro-max-u7promax)
8. [UniFi U7 Pro XG `U7-Pro-XG`](#8-unifi-u7-pro-xg-u7proxg)
9. [UniFi U7 Pro XGS `U7-Pro-XGS`](#9-unifi-u7-pro-xgs-u7proxgs)
10. [UniFi U7 Long-Range `U7-LR`](#10-unifi-u7-long-range-u7lr)

════════════════════════════════════════════════════════════

## 1. Wave MLO6 `Wave-MLO6`

> **資料來源 Source:** https://techspecs.ui.com/uisp/wireless/wave-mlo6

────────────────────────────────────────────────────────────

### 產品特色 Features

- WiFi 7 雙頻無線回傳，同時支援 5 GHz + 6 GHz（Multi-Link Operation）
- 總吞吐量達 8+ Gbps，最遠傳輸距離 100 km
- 內建 GPS 天線，支援精確對準與定時
- IPX6 防水防塵，適合全天候戶外部署
- 搭載 (1) 10 GbE RJ45 + (1) 10G SFP+ 雙上行埠
- WPA3-PSK (AES) 加密，NDAA 合規
- 由 UISP 平台管理

### 產品規格 Specifications

#### Mechanical

| 尺寸 Dimensions            | 249.3 × 82 × 47.6 mm (9.8 × 3.2 × 1.9") |
| 重量 Weight                | 不含掛架：575 g / 含掛架：595 g |
| 外殼材質 Enclosure Material  | Aluminum alloy, UV-resistant polycarbonate |
| 掛架材質 Mount Material      | Strap: stainless steel; Universal bracket: UV-resistant polycarbonate |
| 安裝方式 Mounting            | Pole Mount (1–2" / 25.4–50.8 mm) |
| 防水等級 Weatherproofing     | IPX6 |

#### Hardware

| 處理器 Processor                         | Quad-core IPQ5322 @ 1.5 GHz |
| 記憶體 Memory                            | DDR4 1 GB |
| 網路介面 Networking Interface             | (1) 10 GbE RJ45 + (1) 10G SFP+ |
| 最大功耗 Max. Power Consumption           | 20W |
| 供電方式 Power Method                     | Passive PoE 4-pairs / 2-pairs |
| 電壓範圍 Supported Voltage Range          | 44–54V DC / 22–27V DC |
| 電源供應器 Power Supply                    | 54V DC, 0.56A, 10 GbE PoE adapter（隨附） |
| MIMO (5 GHz)                          | 2 × 2 |
| MIMO (6 GHz)                          | 2 × 2 |
| 最大發射功率 Max. TX Power (5 GHz)          | 24 dBm |
| 最大發射功率 Max. TX Power (6 GHz)          | 24 dBm |
| GPS                                   | ✓ |
| 射頻連接器 RF Connections                  | (2) RP-SMA 防水 + (1) GPS 防水 |
| 環境操作溫度 Ambient Operating Temperature  | -40 to 60°C (-40 to 140°F) |
| 操作濕度 Ambient Operating Humidity       | 5 to 95% noncondensing |
| NDAA 合規                               | ✓ |
| 認證 Certifications                     | FCC, IC |

#### System

| 總吞吐量 Total Throughput  | 8+ Gbps |
| 最大距離 Max. Range        | 100 km (62.1 mi) |
| 運作模式 Operating Mode    | PtP（點對點） |
| 加密 Encryption          | WPA3-PSK (AES) |

#### Radio Frequency

| 操作頻率 Operating Frequency (US/CA)  | 5 GHz: 5180–5320 / 5500–5700 / 5745–5825 MHz; 6 GHz: 5945–6425 / 6525–6875 MHz |
| 頻道頻寬 Channel Bandwidth            | Radio 1: 20/40/80/160/240 MHz; Radio 2: 20/40/80/160/320 MHz |

#### Software

| 管理平台 Management Platform  | UISP |
| Ping Watchdog             | ✓ |
| NTP Client                | ✓ |
| 天線對準 Antenna Alignment    | ✓ |
| 網路模式 Network Mode         | Bridge Mode |

### 應用環境 Application Environment

適用於 ISP、電信業者與企業廣域網路（WAN）的點對點（PtP）無線回傳鏈路。支援 6 GHz 頻段，最高吞吐量 8+ Gbps，可在最遠 100 km 距離內穩定運作。適合戶外桿掛安裝，在有 6 GHz 頻譜授權的地區提供更高容量。由 UISP 平台統一管理。

────────────────────────────────────────────────────────────

## 2. Wave MLO5 `Wave-MLO5`

> **資料來源 Source:** https://techspecs.ui.com/uisp/wireless/wave-mlo5

────────────────────────────────────────────────────────────

### 產品特色 Features

- WiFi 7 雙 5 GHz 無線回傳（Multi-Link Operation），全球 5 GHz 頻段適用
- 總吞吐量達 5+ Gbps，最遠傳輸距離 100 km
- 內建 GPS 天線，支援精確對準與定時
- IPX6 防水防塵，適合全天候戶外部署
- 搭載 (1) 10 GbE RJ45 + (1) 10G SFP+ 雙上行埠
- WPA3-PSK (AES) 加密，NDAA 合規
- CE 認證，適用全球市場

### 產品規格 Specifications

#### Mechanical

| 尺寸 Dimensions            | 249.3 × 82 × 47.6 mm (9.8 × 3.2 × 1.9") |
| 重量 Weight                | 575 g (1.3 lb) |
| 外殼材質 Enclosure Material  | Aluminum alloy, UV-resistant polycarbonate |
| 掛架材質 Mount Material      | Strap: stainless steel; Universal bracket: UV-resistant polycarbonate |
| 安裝方式 Mounting            | Pole Mount (1–2" / 25.4–50.8 mm) |
| 防水等級 Weatherproofing     | IPX6 |

#### Hardware

| 處理器 Processor                         | Quad-core IPQ5322 @ 1.5 GHz |
| 記憶體 Memory                            | DDR4 1 GB |
| 網路介面 Networking Interface             | (1) 10 GbE RJ45 + (1) 10G SFP+ |
| 最大功耗 Max. Power Consumption           | 20W |
| 供電方式 Power Method                     | Passive PoE 4-pairs / 2-pairs |
| 電壓範圍 Supported Voltage Range          | 44–54V DC / 22–27V DC |
| 電源供應器 Power Supply                    | 54V DC, 0.56A, 10 GbE PoE adapter（隨附） |
| MIMO (5 GHz)                          | (2) 2 × 2（雙射頻） |
| 最大發射功率 Max. TX Power (5 GHz)          | 24 dBm |
| GPS                                   | ✓ |
| 射頻連接器 RF Connections                  | (2) RP-SMA 防水 + (1) GPS 防水 |
| 環境操作溫度 Ambient Operating Temperature  | -40 to 60°C (-40 to 140°F) |
| 操作濕度 Ambient Operating Humidity       | 5 to 95% noncondensing |
| NDAA 合規                               | ✓ |
| 認證 Certifications                     | FCC, IC, CE |

#### System

| 總吞吐量 Total Throughput  | 5+ Gbps |
| 最大距離 Max. Range        | 100 km (62.1 mi) |
| 運作模式 Operating Mode    | PtP（點對點） |
| 加密 Encryption          | WPA3-PSK (AES) |

#### Radio Frequency

| 操作頻率 Operating Frequency (Worldwide)  | 5180–5320 MHz / 5500–5700 MHz / 5745–5825 MHz |
| 頻道頻寬 Channel Bandwidth                | Radio 1: 20/40/80/160 MHz; Radio 2: 20/40/80/160/240 MHz |

#### Software

| 管理平台 Management Platform  | UISP |
| Ping Watchdog             | ✓ |
| NTP Client                | ✓ |
| 天線對準 Antenna Alignment    | ✓ |
| 網路模式 Network Mode         | Bridge Mode |

### 應用環境 Application Environment

適用於 ISP 與企業在無 6 GHz 頻譜授權地區的點對點無線回傳。工作於 5 GHz 雙射頻，提供 5+ Gbps 吞吐量，距離最遠 100 km。適合戶外桿掛安裝，CE 認證確保歐洲及全球市場合規。由 UISP 平台統一管理。

────────────────────────────────────────────────────────────

## 3. UniFi Dream Router 7 `UDR7`

> **資料來源 Source:** https://techspecs.ui.com/unifi/cloud-gateways/udr7

────────────────────────────────────────────────────────────

### 產品特色 Features

- 整合式 WiFi 7 三頻閘道器，支援 2.4 / 5 / 6 GHz 全頻段
- IDS/IPS 吞吐量 2.3 Gbps，搭配 20,000+ CyberSecure 特徵碼
- 支援完整 UniFi 應用套件：Network / Protect / Access / Talk / Connect
- 內建 NVR 儲存（64 GB microSD），可擴充 microSD
- 最多管理 30+ UniFi 裝置、300+ 同時連線用戶
- 支援多 WAN（最多 4 路）、SD-WAN、OSPF 動態路由
- 具備 0.96" LCM 狀態顯示螢幕，藍牙初始設定

### 產品規格 Specifications

#### Overview

| 尺寸 Dimensions                  | Ø110 × 184.1 mm (Ø4.3 × 7.3") |
| 外形 Form Factor                 | Compact desktop |
| 重量 Weight                      | 1.1 kg (2.4 lb) |
| 覆蓋範圍 Coverage Area             | 160 m² (1,750 ft²) |
| 管理裝置數 Managed UniFi Devices    | 30+ |
| 同時連線用戶 Simultaneous Users      | 300+ |
| IDS/IPS 吞吐量                    | 2.3 Gbps |
| 最大 WAN 埠數 Max. WAN Port Count  | 4 |
| 預設 WAN 埠 Default WAN Ports     | (1) 10G SFP+ + (1) 2.5 GbE RJ45 |

#### Hardware

| 處理器 Processor                         | Quad-core ARM Cortex-A53 @ 1.5 GHz |
| 系統記憶體 System Memory                   | 3 GB |
| 外殼材質 Enclosure Material               | Polycarbonate |
| LAN 埠 Port Layout (2.5 GbE RJ45)      | 4 ports (1 PoE) — 2.5G/1G/100M/10M |
| LAN 埠 Port Layout (10G SFP+)          | 1 port — 10G/1G |
| PoE 功率預算 PoE Budget                   | 15.4W |
| 最大功耗 Max. Power Consumption           | 26W (不含 PoE 輸出) |
| 電源供應 Power Supply                     | Internal AC/DC, 50W, 100–240V AC |
| NVR 儲存 NVR Storage                    | 64 GB microSD 預裝，支援 microSD 擴充 |
| LCM 顯示 LCM Display                    | 0.96" 狀態顯示 |
| 管理介面 Management                       | Ethernet + Bluetooth |
| ESD/EMP 保護                            | Air: ±8kV, Contact: ±4kV |
| 環境操作溫度 Ambient Operating Temperature  | -10 to 40°C (14 to 104°F) |
| 操作濕度 Ambient Operating Humidity       | 5 to 95% noncondensing |
| NDAA 合規                               | ✓ |
| 認證 Certifications                     | CE, FCC, IC, Anatel |

#### Integrated WiFi

| WiFi 標準 WiFi Standard           | 802.11a/b/g/n/ac/ax/be (WiFi 6/6E, WiFi 7) |
| 吞吐量 Throughput (6 GHz)          | 5.7 Gbps |
| 吞吐量 Throughput (5 GHz)          | 4.3 Gbps |
| 吞吐量 Throughput (2.4 GHz)        | 688 Mbps |
| MIMO (6 GHz)                    | 2 × 2 (DL/UL MU-MIMO) |
| MIMO (5 GHz)                    | 2 × 2 (DL/UL MU-MIMO) |
| MIMO (2.4 GHz)                  | 2 × 2 (DL/UL MU-MIMO) |
| 天線增益 Antenna Gain (6 GHz)       | 6 dBi |
| 天線增益 Antenna Gain (5 GHz)       | 7 dBi |
| 天線增益 Antenna Gain (2.4 GHz)     | 5 dBi |
| 最大發射功率 Max. TX Power (6 GHz)    | 24 dBm |
| 最大發射功率 Max. TX Power (5 GHz)    | 26 dBm |
| 最大發射功率 Max. TX Power (2.4 GHz)  | 23 dBm |
| 無線安全 Wireless Security          | WPA-PSK, WPA-Enterprise (WPA/WPA2/WPA3/PPSK) |
| 最大 BSSID Max. BSSIDs            | 4 per Radio |

#### Security

| 狀態防火牆 Stateful Firewall                      | ✓ |
| L7 應用防火牆 Application-Aware Layer 7 Firewall  | ✓ |
| DPI 深度封包檢測                                   | ✓ |
| 區域防火牆過濾 Zone-Based Firewall                  | ✓ |
| 內容過濾 Content Filtering                       | ✓ |
| 入侵偵測/防護 IPS/IDS                              | ✓ |
| 廣告封鎖 Ad Blocking                             | ✓ |
| IDS/IPS 特徵碼                                  | 20,000+ with CyberSecure |

#### VPN & SD-WAN

| 無授權費 SD-WAN           | ✓ |
| Site Magic VPN        | ✓ |
| IPsec                 | ✓ |
| OpenVPN               | ✓ |
| WireGuard             | ✓ |
| L2TP                  | ✓ |

#### Networking

| 多 WAN 負載均衡 Multi-WAN Load Balancing  | ✓ |
| 動態路由 OSPF                            | ✓ |
| 進階 QoS Advanced QoS                  | ✓ |
| mDNS                                 | ✓ |
| 進階 NAT                               | ✓ |
| 整合 RADIUS 伺服器                        | ✓ |
| IPv6 支援                              | ✓ |
| MAC 位址表大小                            | 2,000 |

#### Software

| 最低軟體版本 Application Requirements  | UniFi Network v9.0.108 以上 |
| VLAN                             | 802.1Q |
| Guest Traffic Isolation          | ✓ |

### 應用環境 Application Environment

適用於中小型辦公室、零售業、餐飲業及家庭環境，需要將閘道器、WiFi 7 無線基地台、交換器與 NVR 整合於單一設備的場景。圓柱形桌面設計，可作為小型 UniFi 網路的核心設備，無需另購獨立 AP 或 NVR。

────────────────────────────────────────────────────────────

## 4. UniFi Cloud Gateway Fiber `UCG-Fiber`

> **資料來源 Source:** https://techspecs.ui.com/unifi/cloud-gateways/ucg-fiber

────────────────────────────────────────────────────────────

### 產品特色 Features

- 專為光纖 ISP 連線優化的緊湊型閘道器，配備雙 SFP+ + 10 GbE RJ45 WAN
- IDS/IPS 吞吐量 5 Gbps，搭配 55,000+ CyberSecure 特徵碼
- 支援選配 NVMe SSD 儲存（最高 2 TB），整合 UniFi Protect NVR
- 最多管理 50+ UniFi 裝置、500+ 同時連線用戶、50 個門禁集線器
- 支援最多 6 路 WAN 埠，多 WAN 負載均衡與備援
- 搭載 Cortex-A73 四核心處理器，效能優於前代
- 具備 0.96" LCM 狀態顯示螢幕，藍牙初始設定

### 產品規格 Specifications

#### Overview

| 尺寸 Dimensions                  | 212.8 × 127.6 × 30 mm (8.3 × 5 × 0.5") |
| 外形 Form Factor                 | Compact desktop |
| 重量 Weight                      | 不含 SSD：675 g / 含 SSD：734 g |
| 管理裝置數 Managed UniFi Devices    | 50+ |
| 管理門禁集線器 Managed Access Hubs    | 50 |
| 同時連線用戶 Simultaneous Users      | 500+ |
| IDS/IPS 吞吐量                    | 5 Gbps |
| 最大 WAN 埠數 Max. WAN Port Count  | 6 |
| 預設 WAN 埠 Default WAN Ports     | (1) 10G SFP+ + (1) 10 GbE RJ45 |

#### Hardware

| 處理器 Processor                         | Quad-core ARM Cortex-A73 @ 2.2 GHz |
| 系統記憶體 System Memory                   | 3 GB |
| 外殼材質 Enclosure Material               | Polycarbonate |
| LAN 埠 Port Layout (2.5 GbE RJ45)      | 4 ports — 2.5G/1G/100M/10M |
| LAN 埠 Port Layout (10 GbE RJ45)       | 1 port — 10G/2.5G/1G |
| LAN 埠 Port Layout (10G SFP+)          | 2 ports — 10G/1G |
| PoE 功率預算 PoE Budget                   | 30W |
| 最大功耗 Max. Power Consumption           | 29.4W (不含 PoE 輸出) |
| 供電方式 Power Method                     | DC jack (54V DC / 1.1A) |
| 電源供應 Power Supply                     | External adapter, 54V DC / 1.1A, 100–240V AC |
| NVR 儲存 NVR Storage                    | 可選配 NVMe SSD，最高 2 TB |
| LCM 顯示 LCM Display                    | 0.96" 狀態顯示 |
| 管理介面 Management                       | Ethernet + Bluetooth |
| ESD/EMP 保護                            | Air: ±8kV, Contact: ±4kV |
| 環境操作溫度 Ambient Operating Temperature  | 0 to 40°C (32 to 104°F) |
| 操作濕度 Ambient Operating Humidity       | 5 to 95% noncondensing |
| NDAA 合規                               | ✓ |
| 認證 Certifications                     | CE, FCC, IC, SRRC, Anatel |
| MAC 位址表大小                             | 4,000 |

#### Security

| 狀態防火牆 Stateful Firewall                      | ✓ |
| L7 應用防火牆 Application-Aware Layer 7 Firewall  | ✓ |
| DPI 深度封包檢測                                   | ✓ |
| 區域防火牆過濾 Zone-Based Firewall                  | ✓ |
| 內容過濾 Content Filtering                       | ✓ |
| 入侵偵測/防護 IPS/IDS                              | ✓ |
| 廣告封鎖 Ad Blocking                             | ✓ |
| IDS/IPS 特徵碼                                  | 55,000+ with CyberSecure |

#### VPN & SD-WAN

| 無授權費 SD-WAN           | ✓ |
| Site Magic VPN        | ✓ |
| IPsec                 | ✓ |
| OpenVPN               | ✓ |
| WireGuard             | ✓ |
| L2TP                  | ✓ |

#### Networking

| 多 WAN 負載均衡 Multi-WAN Load Balancing  | ✓ |
| 動態路由 OSPF                            | ✓ |
| 進階 QoS Advanced QoS                  | ✓ |
| mDNS                                 | ✓ |
| 整合 RADIUS 伺服器                        | ✓ |
| IPv6 支援                              | ✓ |

#### Software

| 最低軟體版本 Application Requirements  | UniFi Network（最新版） |

### 應用環境 Application Environment

適用於中大型辦公室、多租戶建築或光纖 ISP 接入環境，需要高吞吐量安全檢測、大量攝影機與門禁管理的場景。內建 NVMe SSD 儲存槽，無需外接 NVR 伺服器即可管理大量監控攝影機。

────────────────────────────────────────────────────────────

## 5. UniFi Flex Mini 2.5G `USW-Flex-2.5G-5`

> **資料來源 Source:** https://techspecs.ui.com/unifi/switching/usw-flex-2-5g-5

────────────────────────────────────────────────────────────

### 產品特色 Features

- 5 埠 2.5 GbE 二層管理型交換器，切換容量 25 Gbps
- 支援 USB-C（5V）或 PoE 輸入供電，無需額外電源線
- 超輕薄桌面設計（206 g），適合空間受限場景
- 支援 256 VLAN、4,000 MAC 位址表
- 完整 L2 功能：STP/RSTP、連接埠鏡像、風暴控制、流量控制
- 操作溫度範圍廣：-20 to 45°C，適合工業環境
- NDAA 合規，CE/FCC/IC/Anatel 認證

### 產品規格 Specifications

#### Overview

| 尺寸 Dimensions            | 117.1 × 90 × 21.2 mm (4.6 × 3.5 × 0.8") |
| 外形 Form Factor           | Compact desktop |
| 重量 Weight                | 206 g (7.3 oz) |
| 外殼材質 Enclosure Material  | Polycarbonate |

#### Performance

| 埠位 Port Layout                    | (5) 2.5 GbE RJ45 — 2.5G/1G/100M/10M |
| 切換容量 Switching Capacity           | 25 Gbps |
| 非阻塞吞吐量 Non-Blocking Throughput    | 12.5 Gbps |
| 轉發速率 Forwarding Rate              | 19 Mpps |
| 支援 VLAN 數量 Supported VLANs        | 256 |
| MAC 位址表大小 MAC Address Table Size  | 4,000 |

#### Hardware

| 最大功耗 Max. Power Consumption           | 5W (AC/DC) / 6.4W (PoE) |
| 供電方式 Power Method                     | (1) USB Type-C 5V 1A / (1) PoE (44–57V) |
| 電源供應 Power Supply                     | External AC/DC, 5W（隨附） |
| 環境操作溫度 Ambient Operating Temperature  | -20 to 45°C (-4 to 113°F) |
| 操作濕度 Ambient Operating Humidity       | 10 to 90% noncondensing |
| NDAA 合規                               | ✓ |
| 認證 Certifications                     | CE, FCC, IC, Anatel |

#### Features

| STP & RSTP                           | ✓ |
| Egress Rate Limit                    | ✓ |
| Flow Control                         | ✓ |
| Storm Control                        | ✓ |
| Multicast & Broadcast Rate Limiting  | ✓ |
| Port Isolation                       | ✓ |
| Port Mirroring                       | ✓ |
| Jumbo Frames                         | ✓ |
| Loop Protection                      | ✓ |

#### Software

| 最低軟體版本 Application Requirements  | UniFi Network v8.6.9 以上 |

### 應用環境 Application Environment

適用於家庭辦公室、小型辦公室、AV 工作站或任何需要 2.5 GbE 埠密度的環境。可作為 UniFi WiFi 7 基地台的下行交換器，或為 2.5 GbE 工作站擴充埠位，無需獨立電源供應即可透過 PoE 運作。

────────────────────────────────────────────────────────────

## 6. UniFi U7 Pro `U7-Pro`

> **資料來源 Source:** https://techspecs.ui.com/unifi/wifi/u7-pro

────────────────────────────────────────────────────────────

### 產品特色 Features

- WiFi 7 三頻無線基地台，支援 2.4 / 5 / 6 GHz，6 條空間串流
- 覆蓋面積 140 m²，最多 300+ 同時連線用戶
- 2.5 GbE 上行埠，PoE+ 供電
- 支援 802.11r 快速漫遊、PPSK、RADIUS/RadSec、Passpoint
- 支援 8 個 BSSID（每頻段），含訪客隔離與網路排程
- 隨附 Pro Mount，支援天花板與牆壁安裝
- NDAA 合規，CE/FCC/IC 認證

### 產品規格 Specifications

#### Overview

| 尺寸 Dimensions                | Ø206 × 46 mm (Ø8.1 × 1.8") |
| 重量 Weight                    | 680 g (1.5 lb) |
| 外殼材質 Enclosure Material      | Polycarbonate, metal |
| WiFi 標準 WiFi Standard        | WiFi 7 (802.11be/ax/ac/n) |
| 空間串流 Spatial Streams         | 6 (2+2+2) |
| 覆蓋範圍 Coverage Area           | 140 m² (1,500 ft²) |
| 最大用戶數 Max. Client Count      | 300+ |
| 上行埠 Uplink                   | 2.5 GbE RJ45 |
| 供電方式 Power Method            | PoE+ (44–57V DC) |
| 最大功耗 Max. Power Consumption  | 21W |
| 安裝方式 Mounting                | Ceiling, Wall（隨附 Pro Mount） |

#### Performance

| MIMO (6 GHz)                     | 2 × 2 (DL/UL MU-MIMO) |
| MIMO (5 GHz)                     | 2 × 2 (DL/UL MU-MIMO) |
| MIMO (2.4 GHz)                   | 2 × 2 (DL/UL MU-MIMO) |
| 最大資料速率 Max. Data Rate (6 GHz)    | 5.8 Gbps (BW320) |
| 最大資料速率 Max. Data Rate (5 GHz)    | 4.3 Gbps (BW240) |
| 最大資料速率 Max. Data Rate (2.4 GHz)  | 688 Mbps (BW40) |
| 天線增益 Antenna Gain (6 GHz)        | 5.8 dBi |
| 天線增益 Antenna Gain (5 GHz)        | 6 dBi |
| 天線增益 Antenna Gain (2.4 GHz)      | 4 dBi |
| 最大發射功率 Max. TX Power (6 GHz)     | 23 dBm |
| 最大發射功率 Max. TX Power (5 GHz)     | 26 dBm |
| 最大發射功率 Max. TX Power (2.4 GHz)   | 23 dBm |
| 最大 BSSID Max. BSSIDs             | 8 per Radio |

#### Features

| 無線 Mesh Wireless Meshing           | ✓ |
| 頻段引導 Band Steering                 | ✓ |
| 802.11v BSS Transition Management  | ✓ |
| 802.11r 快速漫遊 Fast Roaming          | ✓ |
| 802.11k Radio Resource Management  | ✓ |
| Passpoint (Hotspot 2.0)            | ✓ |
| PPSK                               | ✓ |
| RADIUS over TLS (RadSec)           | ✓ |
| Dynamic RADIUS-assigned VLAN       | ✓ |
| Guest Network Isolation            | ✓ |

#### Software

| 最低軟體版本 Application Requirements       | UniFi Network v8.0.28 以上 |
| 環境操作溫度 Ambient Operating Temperature  | -30 to 40°C (-22 to 104°F) |
| NDAA 合規                               | ✓ |
| 認證 Certifications                     | CE, FCC, IC, Anatel |

### 應用環境 Application Environment

適用於企業、教育機構、餐旅業及高密度辦公環境。適合大型會議室、開放式辦公區和中型場館，提供完整 WiFi 7 三頻效能與企業級安全功能（PPSK、802.11r、Passpoint）。

────────────────────────────────────────────────────────────

## 7. UniFi U7 Pro Max `U7-Pro-Max`

> **資料來源 Source:** https://techspecs.ui.com/unifi/wifi/u7-pro-max

────────────────────────────────────────────────────────────

### 產品特色 Features

- WiFi 7 三頻無線基地台，8 條空間串流（2+4+2），5 GHz 升級為 4×4 MU-MIMO
- 5 GHz 最高資料速率 8.6 Gbps，覆蓋面積 160 m²
- 最多 500+ 同時連線用戶，適合高密度環境
- 內建即時頻譜分析（Real-Time Spectral Analysis），主動偵測干擾
- 鋁合金外殼設計，散熱效能更佳
- 2.5 GbE 上行埠，PoE+ 供電
- NDAA 合規，CE/FCC/IC 認證

### 產品規格 Specifications

#### Overview

| 尺寸 Dimensions                | Ø206 × 46 mm (Ø8.1 × 1.8") |
| 重量 Weight                    | 680 g (1.5 lb) |
| 外殼材質 Enclosure Material      | Polycarbonate, aluminum |
| WiFi 標準 WiFi Standard        | WiFi 7 (802.11be) |
| 空間串流 Spatial Streams         | 8 (2+4+2) |
| 覆蓋範圍 Coverage Area           | 160 m² (1,750 ft²) |
| 最大用戶數 Max. Client Count      | 500+ |
| 上行埠 Uplink                   | 2.5 GbE RJ45 |
| 供電方式 Power Method            | PoE+ (44–57V DC) |
| 最大功耗 Max. Power Consumption  | 25W |
| 安裝方式 Mounting                | Ceiling, Wall（隨附 Pro Mount） |

#### Performance

| MIMO (6 GHz)                        | 2 × 2 (DL/UL MU-MIMO) |
| MIMO (5 GHz)                        | 4 × 4 (DL/UL MU-MIMO) |
| MIMO (2.4 GHz)                      | 2 × 2 (DL/UL MU-MIMO) |
| 最大資料速率 Max. Data Rate (6 GHz)       | 5.8 Gbps (BW320) |
| 最大資料速率 Max. Data Rate (5 GHz)       | 8.6 Gbps (BW240) |
| 最大資料速率 Max. Data Rate (2.4 GHz)     | 688 Mbps (BW40) |
| 天線增益 Antenna Gain (6 GHz)           | 5.9 dBi |
| 天線增益 Antenna Gain (5 GHz)           | 6 dBi |
| 天線增益 Antenna Gain (2.4 GHz)         | 4 dBi |
| 最大發射功率 Max. TX Power (6 GHz)        | 23 dBm |
| 最大發射功率 Max. TX Power (5 GHz)        | 29 dBm |
| 最大發射功率 Max. TX Power (2.4 GHz)      | 23 dBm |
| 最大 BSSID Max. BSSIDs                | 8 per Radio |
| 即時頻譜分析 Real-Time Spectral Analysis  | ✓ |

#### Features

| 無線 Mesh Wireless Meshing           | ✓ |
| 頻段引導 Band Steering                 | ✓ |
| 802.11r 快速漫遊 Fast Roaming          | ✓ |
| 802.11k Radio Resource Management  | ✓ |
| Passpoint (Hotspot 2.0)            | ✓ |
| PPSK                               | ✓ |
| RADIUS over TLS (RadSec)           | ✓ |
| Dynamic RADIUS-assigned VLAN       | ✓ |
| Guest Network Isolation            | ✓ |

#### Software

| 最低軟體版本 Application Requirements       | UniFi Network v8.2.93 以上 |
| 環境操作溫度 Ambient Operating Temperature  | -30 to 50°C (-22 to 122°F) |
| NDAA 合規                               | ✓ |
| 認證 Certifications                     | CE, FCC, IC, Anatel |

### 應用環境 Application Environment

適用於高密度大型場館，如會議中心、展覽館、大型企業樓層。5 GHz 採 4×4 MU-MIMO，適合預期每台 AP 連接 500+ 用戶、5 GHz 頻段壅塞嚴重的場景。即時頻譜分析功能可主動偵測並規避無線干擾。

────────────────────────────────────────────────────────────

## 8. UniFi U7 Pro XG `U7-Pro-XG`

> **資料來源 Source:** https://techspecs.ui.com/unifi/wifi/u7-pro-xg

────────────────────────────────────────────────────────────

### 產品特色 Features

- WiFi 7 三頻無線基地台，配備 10 GbE 上行埠，突破 2.5 GbE 瓶頸
- 超薄設計，厚度僅 32.5 mm，隨附 Lite Mount
- 6 條空間串流（2+2+2），覆蓋 140 m²
- 支援白色與黑色兩種機身
- PoE+ 供電（42.5–57V DC），最大功耗 22W
- 支援 8 個 BSSID（每頻段），企業級安全功能完整
- NDAA 合規，CE/FCC/IC 認證

### 產品規格 Specifications

#### Overview

| 尺寸 Dimensions                | Ø206 × 32.5 mm (Ø8.1 × 1.3") |
| 重量 Weight                    | 750 g (1.7 lb) |
| 外殼材質 Enclosure Material      | UV-stabilized polycarbonate, aluminum alloy |
| WiFi 標準 WiFi Standard        | WiFi 7 (802.11be) |
| 空間串流 Spatial Streams         | 6 (2+2+2) |
| 覆蓋範圍 Coverage Area           | 140 m² (1,500 ft²) |
| 最大用戶數 Max. Client Count      | 300+ |
| 上行埠 Uplink                   | 10 GbE RJ45 |
| 供電方式 Power Method            | PoE+ (42.5–57V DC) |
| 最大功耗 Max. Power Consumption  | 22W |
| 安裝方式 Mounting                | Ceiling, Wall（隨附 Lite Mount） |

#### Performance

| MIMO (6 GHz)                     | 2 × 2 (DL/UL MU-MIMO) |
| MIMO (5 GHz)                     | 2 × 2 (DL/UL MU-MIMO) |
| MIMO (2.4 GHz)                   | 2 × 2 (DL/UL MU-MIMO) |
| 最大資料速率 Max. Data Rate (6 GHz)    | 5.8 Gbps (BW320) |
| 最大資料速率 Max. Data Rate (5 GHz)    | 4.3 Gbps (BW240) |
| 最大資料速率 Max. Data Rate (2.4 GHz)  | 688 Mbps (BW40) |
| 天線增益 Antenna Gain (6 GHz)        | 6 dBi |
| 天線增益 Antenna Gain (5 GHz)        | 5 dBi |
| 天線增益 Antenna Gain (2.4 GHz)      | 4 dBi |
| 最大發射功率 Max. TX Power (6 GHz)     | 24 dBm |
| 最大發射功率 Max. TX Power (5 GHz)     | 26 dBm |
| 最大發射功率 Max. TX Power (2.4 GHz)   | 23 dBm |
| 最大 BSSID Max. BSSIDs             | 8 per Radio |

#### Features

| 無線 Mesh Wireless Meshing           | ✓ |
| 頻段引導 Band Steering                 | ✓ |
| 802.11r 快速漫遊 Fast Roaming          | ✓ |
| 802.11k Radio Resource Management  | ✓ |
| Passpoint (Hotspot 2.0)            | ✓ |
| PPSK                               | ✓ |
| RADIUS over TLS (RadSec)           | ✓ |
| Dynamic RADIUS-assigned VLAN       | ✓ |
| Guest Network Isolation            | ✓ |

#### Software

| 最低軟體版本 (白色) Application Requirements (White)  | UniFi Network v9.0.114 以上 |
| 最低軟體版本 (黑色) Application Requirements (Black)  | UniFi Network v9.1.120 以上 |
| 環境操作溫度 Ambient Operating Temperature          | -30 to 40°C (-22 to 104°F) |
| NDAA 合規                                       | ✓ |
| 認證 Certifications                             | CE, FCC, IC, Anatel |

### 應用環境 Application Environment

適用於已部署或正在建置 10 GbE 有線基礎設施的企業與商業環境。當多台 AP 密集部署於聚合交換器下方時，10 GbE 上行埠可有效解除 2.5 GbE 的頻寬瓶頸，實現更高總吞吐量。

────────────────────────────────────────────────────────────

## 9. UniFi U7 Pro XGS `U7-Pro-XGS`

> **資料來源 Source:** https://techspecs.ui.com/unifi/wifi/u7-pro-xgs

────────────────────────────────────────────────────────────

### 產品特色 Features

- UniFi 旗艦級 AP：10 GbE 上行埠 + PoE++ 供電 + 8 條空間串流（2+4+2）
- 同時具備 4×4 5 GHz MU-MIMO（8.6 Gbps）與 10 GbE 上行的頂規組合
- 支援 Zero-Wait DFS，消除 DFS 頻道切換延遲
- 內建即時頻譜分析（Real-Time Spectral Analysis）
- UV 穩定聚碳酸酯 + 鋁合金外殼，適合嚴苛部署環境
- 最多 500+ 同時連線用戶，覆蓋 160 m²
- NDAA 合規，CE/FCC/IC 認證

### 產品規格 Specifications

#### Overview

| 尺寸 Dimensions                | Ø215 × 32.5 mm (Ø8.5 × 1.3") |
| 重量 Weight                    | 800 g (1.8 lb) |
| 外殼材質 Enclosure Material      | UV-stabilized polycarbonate, aluminum alloy |
| WiFi 標準 WiFi Standard        | WiFi 7 (802.11be) |
| 空間串流 Spatial Streams         | 8 (2+4+2) |
| 覆蓋範圍 Coverage Area           | 160 m² (1,750 ft²) |
| 最大用戶數 Max. Client Count      | 500+ |
| 上行埠 Uplink                   | 10 GbE RJ45 |
| 供電方式 Power Method            | PoE++ (42.5–57V DC) |
| 最大功耗 Max. Power Consumption  | 29W |
| 安裝方式 Mounting                | Ceiling, Wall（隨附 Lite Mount） |

#### Performance

| MIMO (6 GHz)                        | 2 × 2 (DL/UL MU-MIMO) |
| MIMO (5 GHz)                        | 4 × 4 (DL/UL MU-MIMO) |
| MIMO (2.4 GHz)                      | 2 × 2 (DL/UL MU-MIMO) |
| 最大資料速率 Max. Data Rate (6 GHz)       | 5.8 Gbps (BW320) |
| 最大資料速率 Max. Data Rate (5 GHz)       | 8.6 Gbps (BW240) |
| 最大資料速率 Max. Data Rate (2.4 GHz)     | 688 Mbps (BW40) |
| 天線增益 Antenna Gain (6 GHz)           | 6 dBi |
| 天線增益 Antenna Gain (5 GHz)           | 6 dBi |
| 天線增益 Antenna Gain (2.4 GHz)         | 4 dBi |
| 最大發射功率 Max. TX Power (6 GHz)        | 24 dBm |
| 最大發射功率 Max. TX Power (5 GHz)        | 29 dBm |
| 最大發射功率 Max. TX Power (2.4 GHz)      | 23 dBm |
| 最大 BSSID Max. BSSIDs                | 8 per Radio |
| Zero-Wait DFS                       | ✓ |
| 即時頻譜分析 Real-Time Spectral Analysis  | ✓ |

#### Features

| 無線 Mesh Wireless Meshing           | ✓ |
| 頻段引導 Band Steering                 | ✓ |
| 802.11r 快速漫遊 Fast Roaming          | ✓ |
| 802.11k Radio Resource Management  | ✓ |
| Passpoint (Hotspot 2.0)            | ✓ |
| PPSK                               | ✓ |
| RADIUS over TLS (RadSec)           | ✓ |
| Dynamic RADIUS-assigned VLAN       | ✓ |
| Guest Network Isolation            | ✓ |

#### Software

| 最低軟體版本 (白色) Application Requirements (White)  | UniFi Network v9.0.114 以上 |
| 最低軟體版本 (黑色) Application Requirements (Black)  | UniFi Network v9.1.120 以上 |
| 環境操作溫度 Ambient Operating Temperature          | -30 to 40°C (-22 to 104°F) |
| NDAA 合規                                       | ✓ |
| 認證 Certifications                             | CE, FCC, IC, Anatel |

### 應用環境 Application Environment

適用於最高需求的超高密度企業場館，如體育館、大型展覽中心、大學校園及資料中心附近部署。需要 PoE++ 交換器支援。集 10 GbE 上行、PoE++、4×4 5 GHz、Zero-Wait DFS 與即時頻譜分析於一身，為 UniFi 無線產品線最高規格。

────────────────────────────────────────────────────────────

## 10. UniFi U7 Long-Range `U7-LR`

> **資料來源 Source:** https://techspecs.ui.com/unifi/wifi/u7-lr

────────────────────────────────────────────────────────────

### 產品特色 Features

- WiFi 7 雙頻（2.4 / 5 GHz）長距離無線基地台，5 條空間串流（3+2）
- 5 GHz 採 3×3 MU-MIMO，最大發射功率 27 dBm，長距覆蓋能力突出
- 覆蓋面積 160 m²，僅需標準 PoE 供電（無需 PoE+）
- 輕量化設計，直徑 175.7 mm / 重量 448 g
- 操作溫度範圍廣：-30 to 50°C
- 含隨附塑膠安裝板，支援天花板與牆壁安裝
- NDAA 合規，CE/FCC/IC/SRRC/Anatel 認證

### 產品規格 Specifications

#### Overview

| 尺寸 Dimensions                | Ø175.7 × 43 mm (Ø6.9 × 1.7") |
| 重量 Weight                    | 448 g (15.8 oz) |
| 外殼材質 Enclosure Material      | Polycarbonate, aluminum alloy |
| WiFi 標準 WiFi Standard        | WiFi 7 (802.11be) |
| 空間串流 Spatial Streams         | 5（3×3 + 2×2，不含 6 GHz） |
| 覆蓋範圍 Coverage Area           | 160 m² (1,750 ft²) |
| 最大用戶數 Max. Client Count      | 300+ |
| 上行埠 Uplink                   | 2.5 GbE RJ45 |
| 供電方式 Power Method            | PoE (42.5–57V DC) |
| 最大功耗 Max. Power Consumption  | 14W |
| 安裝方式 Mounting                | Ceiling, Wall（隨附塑膠安裝板） |

#### Performance

| MIMO (5 GHz)                     | 3 × 3 (DL/UL MU-MIMO) |
| MIMO (2.4 GHz)                   | 2 × 2 (DL/UL MU-MIMO) |
| 最大資料速率 Max. Data Rate (5 GHz)    | 4.3 Gbps (BW160) |
| 最大資料速率 Max. Data Rate (2.4 GHz)  | 688 Mbps (BW40) |
| 天線增益 Antenna Gain (5 GHz)        | 6 dBi |
| 天線增益 Antenna Gain (2.4 GHz)      | 4 dBi |
| 最大發射功率 Max. TX Power (5 GHz)     | 27 dBm |
| 最大發射功率 Max. TX Power (2.4 GHz)   | 26 dBm |

#### Features

| 無線 Mesh Wireless Meshing           | ✓ |
| 頻段引導 Band Steering                 | ✓ |
| 802.11r 快速漫遊 Fast Roaming          | ✓ |
| 802.11k Radio Resource Management  | ✓ |
| Passpoint (Hotspot 2.0)            | ✓ |
| PPSK                               | ✓ |
| RADIUS over TLS (RadSec)           | ✓ |
| Dynamic RADIUS-assigned VLAN       | ✓ |
| Guest Network Isolation            | ✓ |

#### Software

| 最低軟體版本 Application Requirements       | UniFi Network v9.1.120 以上 |
| 環境操作溫度 Ambient Operating Temperature  | -30 to 50°C (-22 to 122°F) |
| NDAA 合規                               | ✓ |
| 認證 Certifications                     | CE, FCC, IC, SRRC, Anatel |

### 應用環境 Application Environment

適用於倉庫、大型零售賣場、體育館、有頂戶外區域等需要長距離訊號傳播而非最大 6 GHz 容量的場景。預算考量的部署中仍可享有 WiFi 7 技術。適合現有標準 PoE 交換器環境，無需升級至 PoE+ 即可部署。

────────────────────────────────────────────────────────────
