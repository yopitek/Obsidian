# HAK5 產品規格手冊

> 資料來源：[shop.hak5.org](https://shop.hak5.org/) 及 [docs.hak5.org](https://docs.hak5.org/)  
> 整理日期：2026-03-19

---

## 一、無線與網路測試設備

---

### 1. WiFi Pineapple Mark VII

**產品名稱：** WiFi Pineapple Mark VII（第七代 WiFi 鳳梨）

**產品特色：**
- 業界標準的 WiFi 滲透測試平台，搭載 Hak5 專利 PineAP Suite
- 三組專用角色無線電（管理 / 攻擊 / 監控），三根高增益天線
- 直覺式 Web UI，支援自動化 Campaigns 產生可操作情報報告
- 互動式 Recon 儀表板，即時掌握無線環境
- 支援 Cloud C² 遠端指揮與控制
- 可模擬開放式、WPA-PSK 與 Enterprise 偽 AP（Rogue AP）
- 支援 WPA-Enterprise 攻擊、自動握手擷取（Handshake Capture）
- 擴充模組生態系（Module ecosystem）
- 相容 MK7AC 802.11ac 5GHz 外接模組

**產品規格：**
- CPU：單核 MIPS 網路 SoC
- 無線：2.4 GHz 802.11 b/g/n；透過 MK7AC 模組支援 5 GHz 802.11ac
- 無線晶片組：MediaTek MT7601U + MT7610U
- 記憶體：256 MB RAM
- 儲存：2 GB eMMC
- 連接埠：USB-C（電源 / Ethernet）、USB 2.0 Host
- 指示燈：單顆 RGB LED
- 電源：USB-C（5V）
- 作業溫度：35°C ~ 45°C

**應用環境：**
- 企業無線網路安全稽核與弱點評估
- 紅隊（Red Team）外勤滲透測試
- 無線 MitM（Man-in-the-Middle）攻擊模擬
- 偽 AP / Karma 攻擊研究
- 情資收集與設備識別（OSINT）
- 資安培訓與教學展示

---

### 2. WiFi Pineapple Enterprise

**產品名稱：** WiFi Pineapple Enterprise（企業版 WiFi 鳳梨）

**產品特色：**
- 專為企業級、資安機構、長期部署設計的旗艦 WiFi 審計平台
- 四核 ARM CPU，五組雙頻 MIMO 無線電，覆蓋 2.4 GHz / 5 GHz
- 支援最多 100 個 DHCP 客戶端（vs Mark VII 的 5~10 個）
- 雙組 Gigabit Ethernet 實體網路介面，高吞吐量回傳
- 金屬機箱，1U 機架可安裝，支援 AC 100–240V 供電（50/60 Hz）
- 支援 MU-MIMO、TxBF、Qualcomm Wi-Fi SON
- 同樣搭載 PineAP Suite，支援自動化 Campaigns 與 Cloud C²
- 提供 Cobalt PtaaS（Pentest as a Service）聯合服務選項

**產品規格：**
- CPU：Qualcomm IPQ4019，4 核 ARM Cortex A7，主頻 717 MHz
- 無線 Radio 0/1：Qualcomm IPQ4019（2.4 GHz / 5 GHz），峰值 1.733 Gbps
- 無線 Radio 2/3/4：MediaTek MT7612U（2.4 & 5 GHz），峰值 866 Mbps
- 無線規格：802.11ac Wave 2 / a / b / g / n / ac / p，802.3ab
- MIMO 配置：2×2（2-stream）
- 頻道頻寬：20 / 40 / 80 MHz，5 / 10 / 20 / 40 MHz
- RJ45 Ethernet：2 × 1000BASE-T（GigE）
- USB Ethernet：USB-C 3.0 ASIX USB 3.0 介面
- USB：USB 3.0 Host Port
- 記憶體：1 GB DDR3L RAM
- 儲存：4 GB eMMC
- 指示燈：4 × RGB LED
- 電源：AC 100V–240V，50/60 Hz
- 尺寸：160 × 244 × 41 mm（1U）
- 作業溫度：-25°C ~ +50°C

**應用環境：**
- 大型企業或政府機構無線安全審計
- 長期現場部署（機房或辦公室機架安裝）
- 高密度無線環境測試（數千個 station 及 AP）
- 紅隊企業模擬演練
- Pentest as a Service（PtaaS）交付服務

---

### 3. WiFi Pineapple Pager

**產品名稱：** WiFi Pineapple Pager（WiFi 鳳梨呼叫器）

**產品特色：**
- Hak5 20 週年旗艦產品，第 8 代 PineAP 引擎（較前代快 100 倍以上）
- 完全無需外接電腦，獨立手持式 Linux 無線審計裝置
- 支援三頻 WiFi（2.4 GHz / 5 GHz / 6 GHz，802.11 a/b/g/n/ac/ax）及 Bluetooth 5.2 / BLE 4.2
- 以 DuckyScript™ + Bash + Python 驅動 Payload 系統
- 鮮豔彩色 Retina 顯示螢幕，室內外皆清晰可視
- 內建揚聲器（可程式化鈴聲）與震動馬達（靜默通知）
- 4 顆可程式化 RGB 按鈕（DPAD + A/B 控制）
- 即時 Alert Payload 系統：依偵測到的 WiFi 活動自動觸發
- USB-C 整合 Ethernet 介面，可 SSH 接入
- 全根權限 Linux 系統，支援自訂主題、硬體模組擴充（GPS、額外無線電等）

**產品規格：**
- CPU：580 MHz MIPS 24K 路由器晶片
- 無線：三頻 802.11 a/b/g/n/ac/ax（2.4 / 5 / 6 GHz），雙無線電陣列
- 藍牙：Bluetooth 5.2 + BLE 4.2
- 記憶體：256 MB DDR2 RAM + 128 MB SPI Flash
- 儲存：4 GB eMMC
- 電池：2000 mAh LiPo（含 BMS 及 LED 充電指示）
- 充電 / 資料：USB-C（整合 Ethernet 介面）
- 擴充：USB 2.0（用於硬體模組 Mod）
- 指示燈：4 × RGB LED
- 其他：PWM Buzzer、震動馬達、RTC（實時時鐘）
- 作業系統：OpenWrt-based Linux

**應用環境：**
- 外勤無附電腦的獨立無線滲透測試
- 紅隊行動（可夾於腰帶，全程無線操作）
- 三頻 WiFi 與藍牙並行稽核
- WPA3 Enterprise 攻擊測試
- 以 DuckyScript 驅動的自動化 Payload 任務
- 現場 OSINT、握手擷取、Deauth 攻擊

---

### 4. Shark Jack

**產品名稱：** Shark Jack（有線網路植入工具）

**產品特色：**
- 鑰匙圈大小，快速部署的有線網路攻擊工具
- 內建電池，插入 Ethernet 即可獨立執行 Payload
- 以 DuckyScript 撰寫 Payload，支援 NETMODE / LED / SWITCH / BATTERY 等命令
- 內建工具：nmap、curl、metasploit-framework 等
- 支援 Cloud C² 遠端管理
- 3 段開關（攻擊模式 / Arming 模式 / 關機）
- 機動適合機會性網路偵察與植入

**產品規格：**
- SoC：MediaTek MT7628DAN
- 介面：Ethernet（802.3）
- 尺寸：62 × 21 × 12 mm
- 電源：2.5W（USB 5V 0.5A）
- 電池：1S 401020 3.7V 50mAh 0.2Wh LiPo
- 作業溫度：35°C ~ 45°C
- 儲存溫度：-20°C ~ 50°C
- 相對濕度：0% ~ 90%（不凝露）

**應用環境：**
- 機會性有線網路快速偵察（Nmap 掃描、LLDP/CDP 資訊蒐集）
- 紅隊外勤短暫物理接觸場景
- 企業內網植入與後門建立
- 自動化有線網路弱點評估

---

### 5. Shark Jack Cable

**產品名稱：** Shark Jack Cable（線材形態 Shark Jack）

**產品特色：**
- 所有 Shark Jack 功能，融入 Ethernet 線材外型，更易隱蔽
- 新增 USB UART（CP2102）序列介面，可直連 root shell
- 適合長期植入或需要串列除錯的場景
- 支援 Android 序列設定（Android Serial Setup）
- Payload 開發與 Shark Jack 完全相容

**產品規格：**
- SoC：MediaTek MT7628DAN
- 介面：Ethernet（802.3）、USB UART（CP2102）
- 尺寸：62 × 21 × 12 mm
- 電源：2.5W（USB 5V 0.5A）
- 作業溫度：35°C ~ 45°C
- 儲存溫度：-20°C ~ 50°C
- 相對濕度：0% ~ 90%（不凝露）

**應用環境：**
- 偽裝成普通 Ethernet 連接線的長期網路植入
- 需要序列 console 存取的進階 Payload 開發
- 紅隊現場部署，難以被目視識別
- Android 設備配合使用的行動滲透測試

---

### 6. Packet Squirrel Mark II

**產品名稱：** Packet Squirrel Mark II（封包松鼠第二代）

**產品特色：**
- 口袋大小的 Ethernet 中間人多功能工具
- 支援 NAT、BRIDGE、TRANSPARENT、JAIL、ISOLATE 五種網路模式
- 同時支援 WireGuard 與 OpenVPN VPN 連線
- Web UI + SSH 存取（172.16.32.1:1471）
- 4 段模式切換開關，單顆按鈕可重新啟動 / 恢復出廠
- 支援 USB 儲存裝置擴充（USB-A 2.0）
- 可選加密 USB 儲存（LUKS 全磁碟加密）
- Payload 以 Bash / Python 撰寫，支援 DuckyScript
- 支援 Cloud C² 遠端管理
- 具備 SELFDESTRUCT payload 命令（安全自毀）

**產品規格：**
- 介面：Dual Ethernet（Target 及 Network 埠）、USB-C（電源）、USB-A 2.0（儲存）
- 網路標準：802.3
- 電源：USB-C（5V）
- 預設管理 IP：172.16.32.1
- 作業系統：Linux-based
- LED：多色狀態 LED

**應用環境：**
- 企業網路中間人（MitM）封包擷取與分析
- 隱蔽 VPN 通道建立（WireGuard / OpenVPN）
- 紅隊網路植入與遠端持久存取
- 流量操控、DNS 欺騙（SPOOFDNS）、封包注入
- 藍隊演練：隔離可疑設備（JAIL / ISOLATE 模式）
- 企業網路弱點評估自動化

---

## 二、USB 攻擊 / HID 注入工具

---

### 7. USB Rubber Ducky

**產品名稱：** USB Rubber Ducky（USB 橡皮鴨）

**產品特色：**
- 發明 Keystroke Injection 攻擊的始祖工具（2010 年問世），2022 年全面更新
- 外觀與普通 USB 隨身碟完全相同，電腦自動識別為受信任 HID 鍵盤
- 搭載 DuckyScript™ 3.0：支援變數、流程控制、邏輯判斷、OS 偵測、函數
- 被動式 OS 指紋識別（Passive OS Fingerprinting），1 秒內判別桌機/行動裝置
- 支援 Keystroke Reflection（回讀目標機狀態）
- 可動態切換 HID + Storage 攻擊模式（ATTACKMODE）
- 偽裝任意 USB 設備 VID / PID / 廠商 / 序號
- 暴力破解 PIN 碼、密碼、端點封鎖清單
- 相容 PayloadHub 社群數百個現成 Payload

**產品規格（Mark I 硬體參考）：**
- 微控制器：AT32UC3B1256，60 MHz，32-bit RISC
- Flash：256KB 板載 Flash
- USB：High Speed USB 2.0
- 介面：USB-A + USB-C 雙頭（Mark II 版本）
- 儲存：內建 Flash（無需 MicroSD）

**應用環境：**
- 實體存取攻擊：憑證竊取、後門植入、DNS 投毒
- 紅隊自動化社交工程模擬
- 繁複 IT 任務自動化（合法用途）
- 資安培訓教學與滲透測試課程

---

### 8. Bash Bunny Mark II

**產品名稱：** Bash Bunny Mark II（Bash 兔子第二代）

**產品特色：**
- 世界首款多向量 USB 攻擊平台，從插入到完成滲透僅需 7 秒
- 可同時模擬 HID 鍵盤 + USB Ethernet + 序列裝置 + USB 儲存
- 完整 Debian Linux 環境，內建 nmap / responder / impacket / metasploit
- 新增 Bluetooth LE：支援遠端觸發（Remote Triggers）與地理圍欄（Geofencing）
- 新增 MicroSD XC 支援（最高 2TB），大量資料外洩
- 四核 ARM CPU，8 GB 桌機級 SSD，RAM 較前代加倍
- 3 段開關 + RGB LED，快速切換 Payload
- 專用序列 Console，隨時存取 root shell
- 支援 Cloud C² 遠端管理

**產品規格：**
- CPU：四核 ARM Cortex A7，最高 1.3 GHz
- 儲存：8 GB NAND SSD
- 擴充：MicroSD XC（最高 2 TB）
- 無線：Bluetooth LE（遠端觸發 / 地理圍欄）
- 介面：USB-A（植入端）、序列 Console
- 指示燈：1 × RGB LED
- 開關：3 段模式切換開關
- 作業系統：Debian Linux

**應用環境：**
- 多向量 USB 聯合攻擊（HID + 網路 + 儲存）
- 大規模資料外洩（MicroSD 高容量）
- 地理圍欄控制的受限 Payload 執行
- 企業紅隊物理存取自動化演練
- 後滲透工具執行（Metasploit / Responder）

---

### 9. Key Croc

**產品名稱：** Key Croc（鍵盤鱷魚）

**產品特色：**
- 偽裝成鍵盤直通轉接器的硬體鍵盤側錄器（Keylogger）+ HID 注入平台
- 完整 Linux 電腦，可同時模擬 HID / Ethernet / 序列 / 儲存四種 USB 設備
- 側錄關鍵字觸發 Payload（Keyword Triggered Payloads）
- 四核 1.2 GHz ARM CPU，桌機級 SSD，工具豐富
- Cloud C² 整合：即時查看鍵盤輸入、遠端注入鍵盤 / 管理 Payload / root shell
- 自動錄製插入後的所有鍵盤輸入，無需設定
- 支援 DuckyScript™ + Bash Payload

**產品規格：**
- CPU：四核 ARM Cortex A7，1.2 GHz
- 儲存：8 GB 桌機級 SSD
- 介面：USB-A（連接主機端）、USB-A（連接鍵盤端）、序列 Console
- 作業系統：Linux
- Cloud C²：支援

**應用環境：**
- 企業入侵：植入於鍵盤與電腦之間進行長期側錄
- 紅隊演練中的憑證竊取
- 即時鍵盤監控與遠端 Payload 注入
- 實體存取後的後門持久化

---

## 三、O.MG 系列（隱蔽式 USB 攻擊工具）

---

### 10. O.MG Cable

**產品名稱：** O.MG Cable（O.MG 攻擊線）

**產品特色：**
- 手工製造的 USB 傳輸線，內部藏有完整 WiFi + HID 注入植入晶片
- 外觀、觸感與正常 USB 線完全相同（含各種線材顏色 / 材質 / 接頭組合）
- 無需連接電腦控制；透過 WiFi 使用任意瀏覽器（桌機/行動裝置）操作
- DuckyScript 1-click 一鍵部署，業界最快 890 keys/sec 注入速度
- 支援鍵盤側錄（Elite：最多 650,000 keystroke）
- 支援最多 300 個 Payload 槽位（Elite 版）
- 全球 192 種鍵盤布局支援
- Self-Destruct / Geo-Fencing / WiFi 觸發 / HIDX StealthLink
- 出廠預設為停用狀態，需使用 O.MG Programmer 啟動
- 長度：1 米（另有 2 米版），直徑 2.8 mm（TPE 版本）
- USB 2.0 規格 480 Mbps 資料傳輸（植入休眠時）

**產品規格：**
- 植入晶片：客製化 WiFi + HID 微控制器（O.MG 專有）
- USB 介面：USB 2.0（480 Mbps），5V max 充電
- WiFi：內建 802.11 b/g/n（控制介面）
- Payload 注入速度（Basic）：最高 120 keys/sec；（Elite）：最高 890 keys/sec
- Payload 槽：Basic 8 個，Elite 最多 300 個
- 鍵盤側錄（Elite）：最多 650,000 筆按鍵
- 接頭組合：USB-A to USB-C、USB-C to USB-C、A to Lightning 等多種
- 線長：1 米（標準）

**應用環境：**
- 模擬 NSA 等級的 USB 線材植入（類 COTTONMOUTH-I）
- 紅隊現場留置攻擊（Leave-behind attacks）
- 硬體側錄 + 遠端控制複合攻擊
- 偵測防禦團隊（Blue Team）訓練與測試
- 資安教育展示

---

### 11. O.MG Plug

**產品名稱：** O.MG Plug（O.MG 插頭）

**產品特色：**
- 鑰匙圈大小的 O.MG 系列成員，USB 插頭形態
- 所有 O.MG Cable 的核心功能：WiFi 控制、DuckyScript 注入、Self-Destruct、Geo-Fencing
- 不需要線材即可操作，直接插入 USB 埠
- 適合隨身攜帶，隨時備用（EDC 日常攜帶）
- Elite 版：支援 HIDX StealthLink、加密網路 C2、埠隱身（Port Stealthing）
- 出廠預設停用，需 O.MG Programmer 啟動

**產品規格：**
- 形態：USB-A 插頭（Keychain 形態）；另有 USB-C 版本
- 植入晶片：O.MG 客製 WiFi + HID 微控制器
- WiFi：內建（控制介面）
- 注入速度：Basic 120 keys/sec；Elite 890 keys/sec
- Payload 槽：Basic 8 個，Elite 最多 300 個
- 全球鍵盤布局：192 種

**應用環境：**
- 快速 HID 攻擊部署（無需線材）
- 社交工程中的日常攜帶工具
- 紅隊模擬短暫物理存取場景

---

### 12. O.MG Adapter

**產品名稱：** O.MG Adapter（O.MG 轉接器）

**產品特色：**
- 轉接器形態的 O.MG 植入裝置，可接合現有的 USB 線材使用
- 支援 USB-C → USB-A、USB-C → USB-C 等多種轉接方向
- Type-C 連接端為主動端（Payload 由此傳出）
- 靜止時作為正常 USB 2.0 資料直通轉接器，植入晶片完全隱形
- 支援 OTG 模式：可連接行動裝置
- 與 O.MG Cable 功能完全相同（需 O.MG Programmer 啟動）
- Elite 版：鍵盤側錄、HIDX StealthLink、加密 C2

**產品規格：**
- 形態：USB 轉接頭（小型實體）
- 主動端：USB-C
- USB 介面：USB 2.0 資料直通
- 注入速度：Basic 120 keys/sec；Elite 890 keys/sec
- Payload 槽：Basic 8 個，Elite 最多 300 個

**應用環境：**
- 偽裝成普通 USB 轉接頭的植入攻擊
- 與現有 USB 線材結合使用
- 行動裝置（OTG）滲透測試

---

### 13. O.MG Programmer

**產品名稱：** O.MG Programmer（O.MG 程式燒錄器）

**產品特色：**
- 所有 O.MG 裝置的通用啟動 / 韌體更新 / 救援工具
- 支援所有 O.MG 產品：Cable、Plug、Adapter、UnBlocker
- 3 步驟桌機瀏覽器（Chrome / Edge）操作界面（WebSerial API）
- 支援 Python 替代燒錄方式
- 功能：初始啟動、免費韌體更新、Self-Destruct 後救援、鑑識備份、批次燒錄

**產品規格：**
- 連接介面：USB-A + USB-C（雙頭版本）
- 相容設備：所有 O.MG 系列裝置
- 操作方式：WebSerial（Chrome / Edge 瀏覽器）或 Python
- 1 個 Programmer 可用於所有 O.MG 裝置

**應用環境：**
- O.MG 裝置初始化設定
- 定期韌體更新以取得新功能
- Self-Destruct 後的裝置救援與韌體恢復
- 企業批次部署多台 O.MG 裝置
- 鑑識備份 O.MG 裝置韌體

---

### 14. O.MG UnBlocker

**產品名稱：** O.MG UnBlocker（O.MG 解鎖器）

**產品特色：**
- 外觀與功能完全模擬合法的「USB Data Blocker（USB 保險套）」
- 內部藏有 Elite 等級 O.MG 無線植入晶片，完全休眠至 Payload 觸發
- Payload 由公頭（Male）端傳出（連接目標設備端）
- 母頭（Female）端通過 5V 電源至下游設備（外觀行為與真 Data Blocker 相同）
- 可選 3 種顏色，並可加貼自訂標籤 / LOGO
- 支援 Self-Destruct / Geo-Fencing / WiFi Trigger
- 需 O.MG Programmer 啟動

**產品規格：**
- 形態：USB Data Blocker 外型
- 植入：Elite 等級 O.MG 無線 HID 植入晶片
- 連接埠：USB-A 公頭（主動攻擊端）+ USB-A 母頭（電源直通端）
- 通過：5V 電源直通（無資料線路）
- 控制：WiFi WebUI

**應用環境：**
- 針對使用 Data Blocker 自保的目標進行攻擊模擬
- 測試企業 USB 安全政策的有效性
- 紅隊高度隱蔽的物理存取場景
- 供 Blue Team 學習識別偽裝 Data Blocker 的技能

---

## 四、網路監聽 / 攻擊設備

---

### 15. Plunder Bug LAN Tap

**產品名稱：** Plunder Bug LAN Tap（Plunder Bug 區域網路竊聽器）

**產品特色：**
- 口袋大小的乙太網路竊聽器（LAN Tap），USB-C 介面連接分析設備
- 主動模式：作為非受管交換機，注入分析設備進入網路
- 被動模式：靜默鏡像流量，防止分析設備向下游傳輸任何封包
- 支援 Wireshark 等開源封包分析工具
- 跨平台連線腳本（Windows / Mac / Linux）
- 支援 Android Root App 進行行動端封包擷取（pcap 格式）

**產品規格：**
- 網路介面：2 × 10/100BASE-T Fast Ethernet（自動協商）
- USB 介面：USB-C（Tap / 電源，5V，20–300 mA）
- USB Ethernet 晶片：ASIX AX88772C
- 網路最高速率：100 Mbps

**應用環境：**
- 企業內網被動流量監控與封包分析
- 滲透測試中的流量竊聽（Passive Sniffing）
- 注入分析設備進行主動網路掃描（Active Mode）
- 結合 Wireshark 進行協定逆向分析
- 行動端（Android）現場封包擷取

---

## 五、影像 / HDMI 工具

---

### 16. Screen Crab

**產品名稱：** Screen Crab（螢幕螃蟹，HDMI 中間人裝置）

**產品特色：**
- 世界首款滲透測試用 HDMI 中間人影像擷取裝置
- 透明 inline 安裝於 HDMI 訊號路徑，零延遲、零中斷
- 支援定時截圖（Screenshot）或全動態影片錄製（MPEG-4，2 / 4 / 16 Mbps）
- 開箱即用，截圖自動存至 MicroSD，無需設定
- 設定簡單：編輯 config.txt 即可控制所有功能
- 內建 WiFi，可串流截圖與 Cloud C² 遠端管理
- RGB LED 狀態指示（可關閉 LED 增強隱蔽性）
- 儲存循環錄製（最新檔案覆蓋最舊檔案）
- 支援 MicroSD SDXC 大容量記憶卡

**產品規格：**
- 介面：HDMI（IN / OUT）、USB（電源）、MicroSD
- 標準：HDMI 1.4 / DVI 1.0；802.11 b/g/n
- WiFi 頻段：2.4 GHz（2.412 ~ 2.4835 GHz）
- 支援解析度：多數 1920×1080 以下 16:9 格式；對高解析度設備提供降級相容
- 尺寸：105 × 51 × 21 mm
- 電源：5W（USB 5V 1A）
- 作業溫度：35°C ~ 45°C
- 儲存溫度：-20°C ~ 50°C
- 相對濕度：0% ~ 90%（不凝露）

**應用環境：**
- 隱蔽監控目標機器螢幕輸出（無需安裝任何軟體）
- 紅隊植入：長期記錄敏感資訊（密碼、文件、會議內容）
- 企業安全稽核：確認螢幕資訊是否被非法擷取
- 資安研究：HDMI 訊號安全性測試
- 現場取證：記錄操作人員螢幕活動

---

## 六、偵測與防護工具

---

### 17. Malicious Cable Detector

**產品名稱：** Malicious Cable Detector by O.MG（惡意線材偵測器）

**產品特色：**
- 全球唯一能偵測所有已知惡意 USB 線材（含 O.MG Cable）的專用工具
- 採用側通道電源分析（Side Channel Power Analysis），每秒分析 200,000 次
- 即使 O.MG Cable 的植入晶片完全休眠（資料線路無訊號），仍可被偵測
- 同時具備 USB Data Blocker 功能，可安全充電
- 使用簡單：將線材插入偵測器，再將偵測器接入電腦 USB 埠，LED 指示結果
- 覆蓋市面上所有已知惡意 USB 線材類型

**產品規格：**
- 偵測方式：側通道電源分析（Side Channel Power Analysis）
- 偵測速率：200,000 次/秒
- 介面：USB-A（連接電腦）+ USB-A（插入待測線材）
- 附加功能：USB Data Blocker（安全充電，阻隔資料傳輸）
- 指示：LED 活動燈

**應用環境：**
- 企業安全部門：入侵偵測與 USB 政策強化
- 個人防護：出差前檢測充電線安全性
- 藍隊（Blue Team）對抗 O.MG Cable 等隱蔽線材攻擊
- 資安意識教育：展示實體攻擊的偵測可能性
- 高安全需求場所（政府機構、金融機構）的 USB 線材稽核

---

*本手冊由自動化資料收集與整理生成，所有規格資料均來自 Hak5 官方網站。*  
*Official sources: [shop.hak5.org](https://shop.hak5.org/) | [docs.hak5.org](https://docs.hak5.org/)*
