## Virtual Machine USB Passthrough

Running Kali Linux inside a VM on macOS or Windows? You need to pass the USB adapter through to the guest OS.

### VirtualBox

1. With the VM powered off, go to **Settings → USB**.
2. Enable **USB 3.0 (xHCI) Controller**.
3. Click the **+** icon to add a USB filter.
4. Select: **Realtek 802.11ac NIC [...]** (ID: 0bda:8812).
5. Start the VM — the adapter appears inside Kali.

Inside the VM, run `lsusb` to confirm `0bda:8812` appears, then follow the Kali Linux steps above.

### VMware Fusion (macOS) / VMware Workstation (Windows)

1. Start the VM.
2. In the menu: **Virtual Machine → USB & Bluetooth**.
3. Find **Realtek 802.11ac NIC** and click **Connect**.
4. The adapter disconnects from the host and appears inside the VM.

Run `lsusb` inside the VM to confirm, then follow the Kali Linux steps above.

### A Note on VIF (Virtual Interface)

The RTL8812AU chip in the AWUS036ACH has limited VIF support on Linux. You cannot reliably run managed mode and monitor mode (or AP mode) at the same time on the same adapter.

If your workflow needs VIF — for example, running fake APs while monitoring simultaneously — the AWUS036ACH is the wrong tool. Check the [AWUS036ACM install guide](/en/blog/awus036acm-china-install-guide/) instead. That adapter uses the MT7612U chip, which has full kernel-native VIF support and handles simultaneous virtual interfaces without patches.

---
