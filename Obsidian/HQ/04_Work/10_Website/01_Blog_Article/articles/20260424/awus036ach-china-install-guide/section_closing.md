## Troubleshooting

| Problem | Likely Cause | Fix |
|---------|-------------|-----|
| `lsusb` doesn't show 0bda:8812 | Adapter not powered or bad cable | Try a different USB port. Use a powered hub on Raspberry Pi. |
| `make` fails with header errors | Kernel headers missing or version mismatch | Run `sudo apt install linux-headers-$(uname -r)` |
| `modprobe 88XXau` fails | Secure Boot blocking unsigned modules | Disable Secure Boot in BIOS, or sign the module |
| Driver disappears after kernel update | Driver not registered with DKMS | Re-run `sudo dkms install rtl8812au/$(cat VERSION)` from the source directory |
| `airmon-ng start wlan0` fails | NetworkManager still running | Run `sudo airmon-ng check kill` first |
| Monitor mode starts but captures no traffic | Wrong channel or wrong interface name | Check interface with `iwconfig`. Set channel: `iwconfig wlan0mon channel 6` |
| Injection test says "No Answer" | AP too far away, or using wrong interface | Move closer to the AP. Use `wlan0mon` not `wlan0` |

## China Mirror Reference

All resources used in this guide — no GitHub required:

| Resource | URL | Use for |
|----------|-----|---------|
| Alfa official drivers | [files.alfa.com.tw](https://files.alfa.com.tw) | Driver packages, firmware |
| Alfa documentation | [wiki.alfa.com.tw](https://wiki.alfa.com.tw) | Product manuals |
| 清华大学镜像 | [mirrors.tuna.tsinghua.edu.cn](https://mirrors.tuna.tsinghua.edu.cn) | Kali / Debian / Ubuntu |
| 阿里云镜像 | [mirrors.aliyun.com](https://mirrors.aliyun.com) | Ubuntu (recommended) |
| 中科大镜像 | [mirrors.ustc.edu.cn](https://mirrors.ustc.edu.cn) | Kali (recommended) |
| 华为云镜像 | [repo.huaweicloud.com](https://repo.huaweicloud.com) | Kali ARM images (backup) |
| RTL8812AU driver (Gitee) | [gitee.com/mirrors/rtl8812au](https://gitee.com/mirrors/rtl8812au) | Manual compile fallback |

## More Alfa Adapter Guides for China

This is part of the **Alfa China Install Guide** series. Each article covers one adapter model:

- AWUS036ACH ← you are here
- [AWUS036ACM China Install Guide](/en/blog/awus036acm-china-install-guide/) — MT7612U, best VIF support
- [AWUS036ACS China Install Guide](/en/blog/awus036acs-china-install-guide/)
- [AWUS036AX China Install Guide](/en/blog/awus036ax-china-install-guide/)
- [AWUS036AXER China Install Guide](/en/blog/awus036axer-china-install-guide/)
- [AWUS036AXM China Install Guide](/en/blog/awus036axm-china-install-guide/)
- [AWUS036AXML China Install Guide](/en/blog/awus036axml-china-install-guide/)
- [AWUS036EAC China Install Guide](/en/blog/awus036eacs-china-install-guide/)

Questions? Leave a comment below or contact us at [yupitek.com](https://yupitek.com/en/contact/).
