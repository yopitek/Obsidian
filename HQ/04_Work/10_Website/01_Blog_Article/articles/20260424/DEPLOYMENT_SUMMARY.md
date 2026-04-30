# Deployment Summary - Alfa China Install Complete Guide

## Article Information

- **Title:** Complete Guide: Installing All Alfa USB WiFi Adapters on Linux in China - Kali, Ubuntu, Raspberry Pi
- **Slug:** alfa-china-install-complete-guide
- **Date:** 2026-04-24
- **Status:** Published (draft: false)
- **Word Count:** ~3,500 words (686 lines)

## Deployment Steps Completed

### 1. ✅ Article Creation
- Created comprehensive guide covering all Alfa USB WiFi adapters
- Targeted Chinese users with domestic mirror references
- Used superpower:brainstorming skill for structured approach

### 2. ✅ Repository Clone
- Cloned: https://github.com/yopitek/yupitek_official_web.git
- Location: `/Users/benny/Downloads/n8n_project/yupitek_web`

### 3. ✅ File Deployment
- Copied article to: `content/en/blog/alfa-china-install-complete-guide.md`
- Committed to main branch

### 4. ✅ Git Push
- Pushed changes to GitHub
- Commit hash: `fd50cb5`

## Next Steps (Manual)

### Cloudflare Cache Purge
To purge Cloudflare cache for the new blog post:

```bash
# Using Cloudflare API
curl -X POST "https://api.cloudflare.com/v4/zones/afd4b3d4520d0b8d33506916f9603170/purge_cache" \
  -H "X-Auth-User-Key: YOUR_API_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"files":["https://yupitek.com/en/blog/alfa-china-install-complete-guide/"]}'
```

**Note:** You'll need to set a Cloudflare API Token with Zone Purge permissions.

### Expected URL
The article will be available at:
`https://yupitek.com/en/blog/alfa-china-install-complete-guide/`

## Article Contents Summary

### Coverage
- **Operating Systems:** Kali Linux, Ubuntu 22.04/24.04, Debian 12, Raspberry Pi OS
- **Alfa Models:** AWUS036AX, AXM, AXML, AXER, ACH, ACM, ACS, EAC
- **Chipsets:** RTL8832BU (AX), RTL8812AU (ACH), RTL8811AU (ACS), MT7612U (ACM)

### Key Sections
1. Quick Model Reference (by chipset)
2. Before You Start (hardware requirements)
3. China Mirror Reference (all resources)
4. Kali Linux Installation
5. Ubuntu 22.04/24.04 Installation
6. Debian 12 Installation
7. Raspberry Pi OS Installation
8. Enable Monitor Mode
9. Test Packet Injection
10. Virtual Interface (VIF) Support
11. VM USB Passthrough
12. Troubleshooting Table
13. Complete Alfa Model List

### China-Accessible Resources Used
- Alfa official: files.alfa.com.tw
- Alfa docs: wiki.alfa.com.tw
- 清华大学镜像：mirrors.tuna.tsinghua.edu.cn
- 阿里云镜像：mirrors.aliyun.com
- 中科大镜像：mirrors.ustc.edu.cn
- 华为云镜像：repo.huaweicloud.com
- Gitee (GitHub alternative): gitee.com

## Related Articles
This article links to the existing model-specific guides:
- AWUS036ACH China Install Guide
- AWUS036ACM China Install Guide
- AWUS036ACS China Install Guide
- AWUS036AX China Install Guide
- AWUS036AXM China Install Guide
- AWUS036AXML China Install Guide
- AWUS036AXER China Install Guide
- AWUS036EAC China Install Guide

## Deployment Date
April 27, 2026

---
*Deployed using superpower:brainstorming skill workflow*
