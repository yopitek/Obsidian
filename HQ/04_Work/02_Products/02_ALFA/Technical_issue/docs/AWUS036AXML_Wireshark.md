# Wireshark 抓包偵錯指南
**環境：Ubuntu 24.04 | Kernel 6.17.0 | ALFA AWUS036AXML (MT7921)**

---

## 🔍 Step 1：確認網卡識別與驅動狀態

```bash
# 確認 USB 網卡被識別
lsusb | grep -i "mediatek\|alfa\|mt79"

# 確認驅動載入狀態
lsmod | grep mt792

# 查看詳細驅動資訊
modinfo mt7921u

# 查看 dmesg 錯誤訊息
dmesg | grep -i "mt792\|mt7921\|usb" | tail -30
```

---

## 🔍 Step 2：確認介面狀態

```bash
# 列出所有網路介面
ip link show

# 確認無線介面名稱（通常是 wlan0 或 wlx...）
iwconfig 2>/dev/null | grep -v "no wireless"

# 查看介面詳細資訊
iw dev

# 確認介面支援的模式（必須要有 monitor mode）
iw phy | grep -A 10 "Supported interface modes"
```

---

## 🔍 Step 3：設定 Monitor Mode（最關鍵）

MT7921 抓包少的主因通常是**沒有啟用 monitor mode**

```bash
# 停止可能佔用介面的服務
sudo systemctl stop NetworkManager
sudo airmon-ng check kill   # 若有安裝 aircrack-ng

# 確認介面名稱（假設為 wlan0）
IFACE=wlan0

# 方法 A：使用 iw 設定 monitor mode
sudo ip link set $IFACE down
sudo iw dev $IFACE set type monitor
sudo ip link set $IFACE up

# 驗證是否切換成功
iw dev | grep type
# 應顯示：type monitor
```

---

## 🔍 Step 4：指定頻道（避免跳頻導致封包遺漏）

```bash
# 查看目標 AP 的頻道
sudo iwlist wlan0 scan | grep -E "ESSID|Channel|Frequency"

# 或使用 iw
sudo iw dev wlan0 scan | grep -E "SSID|freq|channel"

# 鎖定頻道（例如 CH6, 2.4GHz）
sudo iw dev wlan0 set channel 6

# 若是 5GHz（例如 CH36）
sudo iw dev wlan0 set channel 36

# 確認頻道設定
iw dev wlan0 info
```

---

## 🔍 Step 5：確認 Wireshark 權限

```bash
# 確認目前使用者是否在 wireshark 群組
groups $USER | grep wireshark

# 若不在，加入群組
sudo usermod -aG wireshark $USER
sudo dpkg-reconfigure wireshark-common  # 選 Yes 允許非 root 用戶抓包

# 確認 dumpcap 有正確能力
sudo getcap /usr/bin/dumpcap
# 應顯示：cap_net_admin,cap_net_raw=eip

# 若沒有，手動設定
sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap

# 重新登入後生效，或臨時用 sudo 執行
sudo wireshark
```

---

## 🔍 Step 6：使用命令列抓包驗證（排除 GUI 問題）

```bash
# 先用 tcpdump 確認封包數量
sudo tcpdump -i wlan0 -c 100 -v

# 或用 tshark（Wireshark CLI）
sudo tshark -i wlan0 -a duration:10

# 計算 10 秒內抓到幾個封包
sudo tshark -i wlan0 -a duration:10 2>/dev/null | wc -l
```

---

## 🔍 Step 7：MT7921 特定問題排查

```bash
# 確認 firmware 載入正常
ls /lib/firmware/mediatek/ | grep mt7921
# 應有：mt7921_rom_patch.bin, mt7921_fw.bin 等

# 若缺少 firmware，安裝
sudo apt update
sudo apt install firmware-mediatek   # Debian/Ubuntu non-free
# 或
sudo apt install linux-firmware

# 查看 firmware 載入狀態
dmesg | grep -i "firmware\|mt7921" | head -20

# 檢查是否有封包被丟棄（RX drop）
ip -s link show wlan0 | grep -A2 "RX:"
```

---

## 🔍 Step 8：完整 Monitor Mode 抓包流程

```bash
# === 完整啟動腳本 ===

IFACE=wlan0
CHANNEL=6   # 改成你的目標頻道

# 1. 關閉 NetworkManager
sudo systemctl stop NetworkManager

# 2. 關閉介面
sudo ip link set $IFACE down

# 3. 切換 monitor mode
sudo iw dev $IFACE set type monitor

# 4. 啟動介面
sudo ip link set $IFACE up

# 5. 鎖定頻道
sudo iw dev $IFACE set channel $CHANNEL

# 6. 確認狀態
iw dev $IFACE info

# 7. 開始抓包
sudo tshark -i $IFACE -w /tmp/capture.pcap
# 或開 Wireshark
sudo wireshark -i $IFACE -k
```

---

## 🔍 Step 9：常見問題對照表

| 症狀 | 原因 | 解法 |
|------|------|------|
| 只有 Beacon frame | 沒有 monitor mode | Step 3 |
| 封包量忽多忽少 | 頻道跳動 | Step 4 鎖頻道 |
| Permission denied | 權限問題 | Step 5 |
| 介面不存在 | 驅動未載入 | Step 1/7 |
| 只看到自己的封包 | managed mode | 改 monitor mode |

---

## 🔍 Step 10：回報偵錯資訊

執行以下指令，把輸出貼給我，可以進一步分析：

```bash
echo "=== USB ===" && lsusb | grep -i "mediatek\|alfa"
echo "=== MODULES ===" && lsmod | grep mt79
echo "=== IW DEV ===" && iw dev
echo "=== IW PHY ===" && iw phy | grep -A 15 "Supported interface modes"
echo "=== DMESG ===" && dmesg | grep -i mt792 | tail -20
echo "=== FIRMWARE ===" && ls /lib/firmware/mediatek/ 2>/dev/null | grep mt7921
```

---

請先從 **Step 1 → Step 3 → Step 4** 依序執行，80% 的「封包太少」問題都是因為沒開 monitor mode 或沒鎖頻道造成的。把每個步驟的輸出貼給我，我可以幫你進一步診斷！
