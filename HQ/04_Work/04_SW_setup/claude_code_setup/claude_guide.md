# Claude Code 標準設定 SOP — 兩台電腦同步部署指南

> **日期**:2026-05-01
> **適用對象**:Mac 1 + Mac 2(兩台都連到同一台 GX10 vLLM)
> **目標**:消除 context overflow,建立可重現的「Local Skill First」配置
> **預期執行時間**:每台約 30 分鐘

---

## 0. 先回答關鍵問題

### Q: 「把文件寫進 `~/.claude/skills/`,不用 plugin,就不會有 context 問題嗎?」

**答案:基本上是,但要滿足兩個條件**:

#### ✅ 條件 1:Skill 內容不會自動載入

Anthropic 官方文件明確說:
> "Skills only load their actual content when explicitly invoked. They don't auto-load just because they're installed."

所以你寫一個 5000 行的 SKILL.md,**只要沒被觸發,就 0 tokens 進入 context**。

#### ✅ 條件 2:但 Skill 的「metadata」會載入

每個 skill 啟動時會載入 `name + description`,約 100-200 tokens。

這意味著:
- ✅ 1 個 skill (5000 行內容) = ~150 tokens 常駐
- ✅ 100 個 skill (各 5000 行) = ~15,000 tokens 常駐
- ✅ 1000 個 skill = ~150,000 tokens 常駐 ❌ 會出問題

**所以不是「有 skill 就 0 成本」,而是「合理數量的 skill 幾乎 0 成本」**。

#### 實務原則
- 50 個 skill 以內 → 完全沒問題
- 50-100 個 skill → 還可以,注意 description 不要太長
- > 100 個 skill → 開始要考慮分組

對你目前需求(baoyu / NotebookLM / huahsu / Yupitek 業務 = 約 10-20 個 skill),**完全在安全區**。

---

## 1. 設定流程 SOP — Step by Step

每台 Mac **照同樣的順序執行**。下面用 `Mac-A` 與 `Mac-B` 區分,但流程一致。

### Phase 0:備份 (5 分鐘) — 兩台都做

```bash
# 1. 確認 Claude Code 版本
claude --version
# 應該看到 v2.x.x

# 2. 完全關閉所有 Claude Code session
# (Cmd+Q 退出,不只是關 tab)

# 3. 備份目前的設定
TIMESTAMP=$(date +%Y%m%d_%H%M)
mkdir -p ~/.claude/backups
cp ~/.claude/settings.json ~/.claude/backups/settings.json.${TIMESTAMP}
echo "✅ Backup saved to ~/.claude/backups/settings.json.${TIMESTAMP}"

# 4. 列出目前的 backup 確認
ls -lh ~/.claude/backups/
```

### Phase 1:設定環境變數(雙保險)— 兩台都做

#### Step 1.1:寫入 shell config

**Mac (預設 zsh)**:
```bash
# 檢查 shell
echo $SHELL
# /bin/zsh

# 加入到 ~/.zshrc 末尾
cat >> ~/.zshrc << 'EOF'

# ===== Claude Code Local vLLM Settings =====
# Added: 2026-05-01
# Purpose: Connect to GX10 vLLM, prevent context overflow

export ANTHROPIC_BASE_URL="http://100.73.84.27:8000"
export ANTHROPIC_AUTH_TOKEN="sk-dummy-local-key"
export ANTHROPIC_API_KEY="sk-dummy-local-key"
export ANTHROPIC_DEFAULT_OPUS_MODEL="claude-3-5-sonnet-20241022"
export ANTHROPIC_DEFAULT_SONNET_MODEL="claude-3-5-sonnet-20241022"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="claude-3-5-sonnet-20241022"
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=2048
export CLAUDE_CODE_ATTRIBUTION_HEADER=0
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
export MAX_THINKING_TOKENS=8000
export DISABLE_TELEMETRY=1
export DISABLE_AUTOUPDATER=1
# ===== End of Claude Code Settings =====
EOF

# 立即生效
source ~/.zshrc
```

#### Step 1.2:驗證環境變數

```bash
# 一次驗證所有關鍵環境變數
echo "=== Environment Variables Check ==="
echo "BASE_URL:        $ANTHROPIC_BASE_URL"
echo "MAX_OUTPUT:      $CLAUDE_CODE_MAX_OUTPUT_TOKENS"
echo "ATTRIBUTION:     $CLAUDE_CODE_ATTRIBUTION_HEADER"
echo "MAX_THINKING:    $MAX_THINKING_TOKENS"
echo "===================================="
```

**期待輸出**:
```
=== Environment Variables Check ===
BASE_URL:        http://100.73.84.27:8000
MAX_OUTPUT:      2048
ATTRIBUTION:     0
MAX_THINKING:    8000
====================================
```

如果有任何一個是空的,**停下來檢查 .zshrc 是否寫入成功**:
```bash
tail -25 ~/.zshrc
```

### Phase 2:建立 settings.json(配合環境變數)— 兩台都做

#### Step 2.1:寫入精簡的 settings.json

```bash
mkdir -p ~/.claude

cat > ~/.claude/settings.json << 'EOF'
{
  "env": {
    "ANTHROPIC_BASE_URL": "http://100.73.84.27:8000",
    "ANTHROPIC_AUTH_TOKEN": "sk-dummy-local-key",
    "ANTHROPIC_API_KEY": "sk-dummy-local-key",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "claude-3-5-sonnet-20241022",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "claude-3-5-sonnet-20241022",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "claude-3-5-sonnet-20241022",
    "CLAUDE_CODE_MAX_OUTPUT_TOKENS": "2048",
    "CLAUDE_CODE_ATTRIBUTION_HEADER": "0",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    "MAX_THINKING_TOKENS": "8000",
    "DISABLE_TELEMETRY": "1",
    "DISABLE_AUTOUPDATER": "1"
  },
  "enabledPlugins": {
    "context7@claude-plugins-official": true,
    "github@claude-plugins-official": true,
    "code-review@claude-plugins-official": true,
    "feature-dev@claude-plugins-official": true,
    "frontend-design@claude-plugins-official": true,
    "superpowers@claude-plugins-official": true,
    "commit-commands@claude-plugins-official": true,
    "document-skills@anthropic-agent-skills": true,
    "obsidian-visual-skills@axton-obsidian-visual-skills": true,
    "n8n-workflow-builder@awesome-claude-code-plugins": true,
    "python-expert@awesome-claude-code-plugins": true,
    "code-simplifier@claude-plugins-official": true
  },
  "extraKnownMarketplaces": {
    "axton-obsidian-visual-skills": {
      "source": {
        "source": "github",
        "repo": "axtonliu/axton-obsidian-visual-skills"
      }
    }
  },
  "skipDangerousModePermissionPrompt": true
}
EOF
```

#### Step 2.2:JSON 格式驗證

```bash
# 用 Python 驗證 JSON 格式正確
python3 -c "import json; json.load(open('$HOME/.claude/settings.json')); print('✅ Valid JSON')"

# 顯示內容確認
cat ~/.claude/settings.json | python3 -m json.tool | head -30
```

如果報錯,**馬上回退**:
```bash
# 找最新的 backup
ls -t ~/.claude/backups/ | head -1

# 回退
cp ~/.claude/backups/settings.json.<timestamp> ~/.claude/settings.json
```

### Phase 3:建立本地 Skill 庫 — 兩台都做

#### Step 3.1:建立 skill 目錄結構

```bash
mkdir -p ~/.claude/skills

# 為每個 skill 建立子目錄
mkdir -p ~/.claude/skills/baoyu-content-creation
mkdir -p ~/.claude/skills/notebooklm-research
mkdir -p ~/.claude/skills/huahsu-design
mkdir -p ~/.claude/skills/yupitek-products
mkdir -p ~/.claude/skills/obsidian-vault-mgmt

# 確認結構
tree ~/.claude/skills/ 2>/dev/null || ls -R ~/.claude/skills/
```

#### Step 3.2:寫第一個 Skill(以 baoyu 為例)

```bash
cat > ~/.claude/skills/baoyu-content-creation/SKILL.md << 'EOF'
---
name: baoyu-content-creation
description: 寶玉風格的繁體中文長文創作 skill。當用戶要求寫部落格文章、產品深度分析、技術說明文章、長篇文案時自動觸發。特別擅長技術產品的 B2B marketing 內容。
---

# Baoyu Content Creation Skill

## Purpose
Generate long-form content in 寶玉's signature style for Traditional Chinese audiences,
focused on technical B2B marketing.

## When to Activate
- 寫部落格文章 / blog post
- 產品深度分析
- 技術說明文章
- 長篇 marketing 文案

## Style Guidelines

### Voice & Tone
- 專業但平易近人
- 重視邏輯與資料佐證
- 段落分明,善用標題層級
- 繁體中文 (台灣慣用語)

### Structure
1. 引人入勝的 hook(問題、數據、場景)
2. 清晰的問題定義
3. 多角度分析(技術、商業、使用者)
4. 具體的解決方案
5. 行動呼籲(CTA)

### Common Phrases
[把寶玉風格的常用句型放這]

## Process
1. 確認主題與目標讀者
2. 列出 outline
3. 每段先寫重點,再展開
4. 收尾呼應 hook

## Examples
[放幾個 sample 段落]
EOF
```

**關鍵**:`description` 寫得越精準,Claude 自動觸發越準確。**用具體 keyword(如「ALFA」「Yupitek」「寶玉風格」)避免泛用詞**。

#### Step 3.3:Yupitek 業務 Skill(進階加值)

```bash
mkdir -p ~/.claude/skills/yupitek-products/alfa-network
mkdir -p ~/.claude/skills/yupitek-products/acs-card-readers
mkdir -p ~/.claude/skills/yupitek-products/sdrlab

cat > ~/.claude/skills/yupitek-products/SKILL.md << 'EOF'
---
name: yupitek-products
description: |
  Yupitek 代理品牌的產品知識庫。當用戶討論 ALFA Network Wi-Fi 卡、
  ACS NFC 讀卡機、SDRlab HackRF/PortaPack、Ubiquiti 網路設備的
  型號、規格、相容性、應用場景、marketing 內容時自動觸發。
---

# Yupitek Products Knowledge

This skill provides accurate technical knowledge about products distributed by Yupitek.

## Product Lines

### ALFA Network (Wi-Fi adapters)
詳細規格見 alfa-network/ 目錄:
- AWUS036AXER (Wi-Fi 6, USB 3.0)
- AWUS036ACH (Wi-Fi 5, RTL8812AU, Kali 友好)
- 其他...

### ACS Card Readers
- ACR1252U (NFC, macOS 相容)
- 其他...

### SDRlab
- H4M (HackRF One + PortaPack, Mayhem firmware)

### Ubiquiti
[相關產品]

## Usage Guidelines

When asked about a specific product:
1. Reference the detailed file (e.g., alfa-network/awus036axer.md)
2. Match the user's intent (marketing copy / technical doc / spec sheet)
3. Use Traditional Chinese for Taiwan B2B audience
EOF

# 為每個產品寫詳細檔
cat > ~/.claude/skills/yupitek-products/alfa-network/awus036axer.md << 'EOF'
# ALFA AWUS036AXER

## 規格
- Wi-Fi 6 (802.11ax)
- USB 3.0
- [其他規格...]

## 應用場景
- 高速無線連接
- 滲透測試 (部分 mode)
- ...

## macOS 相容性
- ❌ 不支援 (Wi-Fi 6 在 macOS 沒有官方驅動)

## Linux 相容性
- ✅ Kernel 5.x+
- ✅ Kali Linux
EOF
```

**這個 skill 的價值**:你以後做任何 ALFA 產品相關的工作(寫 marketing、回答客戶、出技術文件),Claude 會**自動懂規格、不會搞錯**。這才是把 5 天 vLLM 調校真正落地。

#### Step 3.4:.gitkeep 建立空骨架(其他 skill 之後再填)

```bash
# 為其他 skill 建立佔位
for skill in notebooklm-research huahsu-design obsidian-vault-mgmt; do
  cat > ~/.claude/skills/$skill/SKILL.md << EOF
---
name: $skill
description: TODO - 之後再寫,此 skill 暫時為佔位狀態
---

# $skill Skill

## Status
🚧 Under construction - description 還沒寫完,暫時不會被觸發

EOF
done

# 注意:description 寫 "TODO" 是故意讓 Claude 不會觸發,等你之後改完整再啟用
```

### Phase 4:建立全域 .claudeignore — 兩台都做

```bash
# 建立通用範本
cat > ~/.claude/global-claudeignore-template << 'EOF'
# 構建產物
build/
dist/
target/
.next/
out/

# 文件輸出
*.pdf
*.epub
*.mobi
*.docx
*.xlsx

# 日誌與快取
*.log
logs/
.cache/
.tmp/

# 套件管理
node_modules/
.venv/
venv/
__pycache__/
.pytest_cache/

# AI 模型檔
*.safetensors
*.gguf
*.bin
*.pt
*.onnx

# IDE 與編輯器
.idea/
.vscode/.history/
.obsidian/
.trash/
attachments/

# 系統檔
.DS_Store
Thumbs.db
EOF

echo "✅ Template at ~/.claude/global-claudeignore-template"
echo "在每個專案根目錄執行: cp ~/.claude/global-claudeignore-template ./.claudeignore"
```

### Phase 5:啟動驗證 — 兩台都做

#### Step 5.1:第一次啟動測試

```bash
# 完全新的 terminal session(關閉舊的)
# 重新開一個 terminal

# 確認環境變數仍在
echo $CLAUDE_CODE_MAX_OUTPUT_TOKENS
# 必須是: 2048

# 啟動 Claude Code
claude
```

#### Step 5.2:在 Claude Code 內驗證

進入 Claude Code 後,**第一個指令永遠是**:
```
/clear
```

然後測試:
```
hi, what's my current configuration?
```

**期待行為**:
- ✅ Claude 應該立刻回應(沒有 context overflow)
- ✅ 回應簡短,不會長篇大論(因為 max_output=2048)

#### Step 5.3:測試 Skill 自動觸發

```
幫我寫一篇關於 ALFA AWUS036AXER 的部落格文章
```

**期待行為**:
- ✅ Claude 應該自動觸發 `yupitek-products` skill
- ✅ 應該知道 AWUS036AXER 是 Wi-Fi 6 USB adapter
- ✅ 可能也觸發 `baoyu-content-creation` skill 來寫文章

如果 skill 沒自動觸發,代表 **description 不夠精準**,需要改。

### Phase 6:最終健康檢查 — 兩台都做

建立一個健康檢查腳本,以後隨時可跑:

```bash
cat > ~/scripts/claude-health-check.sh << 'BASHEOF'
#!/bin/bash
# Claude Code Health Check
# Run this anytime you suspect configuration drift

set -e

echo "=========================================="
echo "  Claude Code Configuration Health Check"
echo "  $(date)"
echo "=========================================="

# 1. Claude Code 版本
echo
echo "--- 1. Claude Code Version ---"
claude --version 2>/dev/null || echo "❌ claude command not found"

# 2. 環境變數
echo
echo "--- 2. Environment Variables ---"
for var in ANTHROPIC_BASE_URL CLAUDE_CODE_MAX_OUTPUT_TOKENS \
           CLAUDE_CODE_ATTRIBUTION_HEADER MAX_THINKING_TOKENS; do
  val="${!var}"
  if [ -z "$val" ]; then
    echo "❌ $var is empty"
  else
    echo "✅ $var = $val"
  fi
done

# 3. settings.json 存在且為 valid JSON
echo
echo "--- 3. Settings JSON ---"
if [ -f ~/.claude/settings.json ]; then
  if python3 -c "import json; json.load(open('$HOME/.claude/settings.json'))" 2>/dev/null; then
    echo "✅ settings.json is valid"
    PLUGIN_COUNT=$(python3 -c "import json; d=json.load(open('$HOME/.claude/settings.json')); print(sum(1 for v in d.get('enabledPlugins',{}).values() if v))")
    echo "ℹ️  Enabled plugins: $PLUGIN_COUNT (建議 ≤ 15)"
    if [ "$PLUGIN_COUNT" -gt 20 ]; then
      echo "⚠️  Plugin 數量過多,可能影響 context"
    fi
  else
    echo "❌ settings.json has JSON errors"
  fi
else
  echo "❌ settings.json missing"
fi

# 4. Skill 庫
echo
echo "--- 4. Local Skills ---"
if [ -d ~/.claude/skills ]; then
  SKILL_COUNT=$(find ~/.claude/skills -name "SKILL.md" | wc -l | tr -d ' ')
  echo "ℹ️  Local skills found: $SKILL_COUNT"
  if [ "$SKILL_COUNT" -gt 0 ]; then
    echo "Skills:"
    find ~/.claude/skills -name "SKILL.md" | while read f; do
      DESC=$(grep -A1 "^description:" "$f" 2>/dev/null | tail -1 | head -c 60)
      DIR=$(basename $(dirname $f))
      echo "   - $DIR"
    done
  fi
else
  echo "ℹ️  No local skills directory"
fi

# 5. vLLM 連通性 (僅當在能連到 GX10 的網路時)
echo
echo "--- 5. vLLM Connectivity ---"
if [ -n "$ANTHROPIC_BASE_URL" ]; then
  if curl -s -m 3 "${ANTHROPIC_BASE_URL}/health" > /dev/null 2>&1; then
    echo "✅ vLLM reachable at $ANTHROPIC_BASE_URL"
  else
    echo "⚠️  vLLM not reachable (可能不在同一網路或 GX10 沒開機)"
  fi
fi

echo
echo "=========================================="
echo "Health check complete"
echo "=========================================="
BASHEOF

chmod +x ~/scripts/claude-health-check.sh
mkdir -p ~/scripts

# 立刻跑一次驗證
~/scripts/claude-health-check.sh
```

**期待結果**:第 1-4 項全 ✅。第 5 項可能 ⚠️(如果你在外面、GX10 不在同個網路)。

---

## 2. 兩台電腦同步策略

### 2.1 設定同步(立即可做)

**方法 A:GitHub Gist(最簡單)**

```bash
# Mac-A 上把設定包成 gist
cd ~/.claude

# 包成可移植的 tar
tar czf claude-config-$(date +%Y%m%d).tar.gz \
  settings.json skills/

# 傳到 Mac-B (用 AirDrop / iCloud / scp)
# 在 Mac-B 上解壓:
# tar xzf claude-config-*.tar.gz -C ~/.claude/
```

**方法 B:GitHub Repo(推薦,可版本控制)**

```bash
# Mac-A 上建立 dotfiles repo
cd ~
mkdir -p dotfiles/claude
cp -r ~/.claude/settings.json dotfiles/claude/
cp -r ~/.claude/skills dotfiles/claude/

cd dotfiles
git init
git add .
git remote add origin git@github.com:benny-yupitek/dotfiles.git  # 換成你的 repo
git commit -m "Initial Claude Code config"
git push -u origin main

# Mac-B 上 clone
cd ~
git clone git@github.com:benny-yupitek/dotfiles.git
ln -sf ~/dotfiles/claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/claude/skills ~/.claude/skills
```

⚠️ **重要**:dotfiles repo **設成 private**(裡面有 vLLM IP 等內部資訊)

### 2.2 後續更新流程

```bash
# Mac-A 改了 skill 後
cd ~/dotfiles
git add . && git commit -m "Update yupitek-products skill" && git push

# Mac-B 同步
cd ~/dotfiles
git pull
# 如果用 symlink,自動生效
# 如果用 copy,需要 cp -r 一次

# 重啟 Claude Code 讓新 skill 載入
```

---

## 3. 關於「全部用 skill 不用 plugin」的深入討論

### 3.1 你的直覺基本正確,但有細節

你的想法:
> "若把文件都寫進 ~/.claude/skills,不要用 plugin 的方式載入,就不會有 context 的問題對嗎?"

**會避免大部分 context 問題,但不是 100%**。原因如下:

#### 為什麼會避免大部分問題

```
Plugin 帶來的常駐成本:
├─ Plugin manifest:        ~50 tokens
├─ Skills metadata:         ~100 × N tokens
├─ Slash commands:          ~100 × N tokens   ← Plugin 帶來的
├─ Agent system prompts:    ~500-2000 × N    ← Plugin 帶來的(大頭)
├─ MCP server tools:        ~200-500 × N    ← Plugin 帶來的(大頭)
└─ Hooks:                   ~50 × N tokens

Skill 帶來的常駐成本:
└─ Metadata (name + description): ~100-200 tokens 完畢
```

差距是 **10-50 倍**。所以「skill only」確實能大幅降低 context。

#### 為什麼不是 100% 避免

仍然有一些常駐項目你無法避免:

| 來源 | 常駐 tokens | 可控嗎 |
|---|---|---|
| Claude Code 核心 system prompt | ~3,000 | ❌ 不可控 |
| 工具定義 (Read, Write, Bash...) | ~2,000 | ❌ 不可控 |
| 用戶設定的環境介紹 | ~500 | ✅ 可控 |
| **每個 skill 的 metadata** | **~150 × N** | **✅ 可控** |
| CLAUDE.md (如果有) | 視大小 | ✅ 可控 |
| 對話歷史 | 視長度 | ✅ 可控 (`/clear`) |

**baseline ≈ 5,500 tokens** 是你無論如何都要付的。如果你裝 50 個 skill,再加 7,500 tokens,合計 **13,000 tokens** 是 conservative 的常駐成本。

#### 真正的 context 風險點

即使你「全用 skill」,以下三個情況仍會踩雷:

1. **單次 prompt 載入太多檔案** — 例如 `@/` 整個 vault
2. **對話歷史累積** — 跑了 30 輪沒 `/clear`
3. **被觸發的 skill 內容很大** — Claude 一次載入 5000 行的 SKILL.md

### 3.2 推薦策略:**Plugin Lean + Skill Rich**

| 用什麼 | 適用 |
|---|---|
| **Plugin** (核心 12 個) | 提供 slash commands、agents、MCP 連接 (官方/工具類) |
| **Skill** (本地多個) | 個人化知識、業務 know-how、寫作風格 |
| **MCP Server** (謹慎) | 連接外部 API (notion, linear, 你已經有 figma 等) |

**判斷準則**:
- 「需要連外部 API」 → Plugin / MCP
- 「需要 slash command (/foo)」 → Plugin
- 「教 Claude 領域知識或寫作風格」 → **Skill**(優先選這個)

### 3.3 你的第二個 Yupitek 業務 Skill 範例

```bash
mkdir -p ~/.claude/skills/yupitek-marketing-style
cat > ~/.claude/skills/yupitek-marketing-style/SKILL.md << 'EOF'
---
name: yupitek-marketing-style
description: |
  Yupitek B2B marketing 的品牌風格指南。當撰寫 ALFA Network、ACS、
  SDRlab、Ubiquiti 產品的 marketing 內容(infographic、social post、
  technical blog、product launch)時自動觸發。
---

# Yupitek Marketing Style Guide

## Brand Voice
- 專業 + 親切 (不過度技術但不空泛)
- 強調實用性與相容性 (B2B 客戶最在意)
- 繁體中文 (台灣慣用語)

## Visual Conventions (for infographic skills)
- 主色: [你品牌色]
- 字體: [指定]
- 卡片尺寸: 2048×2048 (Instagram / 社群預設)

## Content Templates

### Product Launch Card
1. Hook: 一句話痛點
2. 主視覺: 產品圖(切記不要 AI 生成,用實拍)
3. 三個關鍵 spec
4. 適用場景
5. CTA: 詢價 / 了解更多

### Technical Blog Structure
1. 問題場景 (300-500 字)
2. 技術原理 (with 圖表)
3. 產品如何解決
4. 實戰案例
5. Spec 比較表

## Banned Words / Phrases
- 「最強」「無敵」(誇大不專業)
- 「絕對」「保證」(法律風險)

## Approval Workflow
完成後,提示用戶在 Obsidian 留 reference link
EOF
```

這份 skill 加上前面的 `yupitek-products`,**你以後做 marketing 工作就有了完整的「產品知識 + 風格指南」自動加持**。

---

## 4. 第一週使用紀律

設定完不代表結束。**這三條紀律才是長期不踩雷的關鍵**:

### 紀律 1:每個任務開始 `/clear`

```
工作流範例:
[早上 9:00] 開啟 Claude Code → /clear → 寫 ALFA blog
[早上 11:00] 切到新任務 → /clear → 整理 Obsidian
[下午 2:00] 又一個任務 → /clear → 修 Python script
```

### 紀律 2:每個專案根目錄都有 `.claudeignore`

```bash
# 進入新專案
cd ~/Downloads/n8n_project/25_Obsidian/Obsidian/HQ

# 第一件事
cp ~/.claude/global-claudeignore-template ./.claudeignore

# 客製化:加入這個專案特有的排除
echo "vault-archive/" >> .claudeignore
```

### 紀律 3:每週看一次 health check

```bash
# 設成 alias
echo 'alias chc="~/scripts/claude-health-check.sh"' >> ~/.zshrc
source ~/.zshrc

# 每週一早上花 30 秒
chc
```

---

## 5. 故障排除速查

### 症狀 1:context overflow 又出現

#### 檢查順序
```bash
# 1. 環境變數還在嗎?
echo $CLAUDE_CODE_MAX_OUTPUT_TOKENS  # 應該 2048

# 2. settings.json 還對嗎?
cat ~/.claude/settings.json | python3 -m json.tool > /dev/null && echo "OK"

# 3. plugin 數量還是 12 嗎?
python3 -c "
import json
d = json.load(open('$HOME/.claude/settings.json'))
print(f'Enabled plugins: {sum(1 for v in d[\"enabledPlugins\"].values() if v)}')
"

# 4. 在 Claude Code 中跑
/clear
# 然後再試
```

如果以上都正常,問題可能是:
- 你 `@` 載入了太大的檔案 → 用更精準的 `@filename` 而非 `@directory`
- 對話歷史太長 → `/clear`
- 觸發的 skill 內容太大 → 拆分 skill

### 症狀 2:Skill 沒自動觸發

```bash
# 在 Claude Code 中
/skills

# 看是否有列出你的 skill
```

如果列出了但沒觸發:
- description 太抽象 → 加具體 keyword
- description 太短 → 補充觸發場景

如果沒列出:
- SKILL.md 格式有錯 → 檢查 YAML frontmatter
- 路徑錯了 → 必須在 `~/.claude/skills/skill-name/SKILL.md`

### 症狀 3:Mac-A 跟 Mac-B 行為不同

```bash
# 兩台都跑 health check
~/scripts/claude-health-check.sh

# 把輸出 diff 一下,通常會找出哪個設定不同
```

最常見原因:
- 一台改了 .zshrc 一台沒改
- skill 沒同步
- Claude Code 版本不同 (跑 `claude --version` 對比)

---

## 6. 給兩台 Mac 的快速部署 Checklist

複印這份 checklist,每台都打勾:

```
Mac-A 部署檢查表  (Date: ____________)
┌─────────────────────────────────────────┐
│ Phase 0 - 備份                          │
│   □ Claude Code 完全關閉                │
│   □ 備份 settings.json                  │
│   □ 確認 backup 存在                    │
│                                         │
│ Phase 1 - 環境變數                      │
│   □ 加入 .zshrc                         │
│   □ source ~/.zshrc                     │
│   □ echo $CLAUDE_CODE_MAX_OUTPUT_TOKENS │
│      → 顯示 2048 ✅                     │
│                                         │
│ Phase 2 - settings.json                 │
│   □ 寫入新版                            │
│   □ JSON 格式驗證通過                   │
│   □ Plugin 數量 = 12                    │
│                                         │
│ Phase 3 - 本地 Skill                    │
│   □ 建立 ~/.claude/skills/              │
│   □ 至少 1 個 skill 寫好 description    │
│                                         │
│ Phase 4 - .claudeignore                 │
│   □ Template 在 ~/.claude/              │
│                                         │
│ Phase 5 - 啟動驗證                      │
│   □ 新 terminal 開啟                    │
│   □ claude 啟動成功                     │
│   □ /clear 後 hi 沒報錯                 │
│   □ 測試 skill 自動觸發                 │
│                                         │
│ Phase 6 - Health Check                  │
│   □ ~/scripts/claude-health-check.sh    │
│   □ 1-4 項全 ✅                         │
│                                         │
│ 部署成功時間: ____________________      │
└─────────────────────────────────────────┘

Mac-B 部署檢查表  (Date: ____________)
[同上 Phase 0-6,完成才打勾]
```

---

## 7. 結論

### 7.1 對你關鍵問題的最終回答

> 「全部用 skill 不用 plugin,就不會有 context 問題嗎?」

**答案**:
- ✅ **大幅降低**(可能省 80% 以上的 plugin 常駐成本)
- ⚠️ **不是 0**(每個 skill 的 metadata 仍佔 ~150 tokens)
- ❌ **不能解決所有 context 問題**(`/clear`、`.claudeignore`、不要過度載檔仍是必要紀律)

**實務建議**:
- Plugin 維持精簡(你目前 12 個剛好)
- 個人化 / 業務知識 → 全部走 skill
- 雙管齊下 + 三條使用紀律 = 不再有 context overflow

### 7.2 標準部署流程總結

```
每台電腦 30 分鐘搞定:
  Phase 0 (5 min):  備份
  Phase 1 (5 min):  環境變數
  Phase 2 (3 min):  settings.json
  Phase 3 (10 min): 建立 skill 庫
  Phase 4 (2 min):  .claudeignore template
  Phase 5 (5 min):  驗證
  Phase 6 (任何時候):health check
```

### 7.3 從工程到使用的轉換

從昨天的 vLLM Golden Recipe,到今天的 Claude Code Lean Setup,**infrastructure 已完整**。剩下的時間,把它**用起來**:
- 把 Yupitek 產品知識變成 skill (建議優先)
- 把寫作風格、設計風格變成 skill
- 兩台 Mac 同步,雙裝置工作流暢
- 每週 health check,確保不漂移

**下一步應該是**:寫第一篇 Yupitek 產品 marketing,實際驗證整個工作流。

---

## 附錄 A:常用指令速查卡

```bash
# 環境變數驗證
echo $CLAUDE_CODE_MAX_OUTPUT_TOKENS

# settings.json 驗證
python3 -m json.tool < ~/.claude/settings.json | head -30

# Plugin 計數
python3 -c "import json;d=json.load(open('$HOME/.claude/settings.json'));print(sum(1 for v in d['enabledPlugins'].values() if v))"

# Skill 列表
find ~/.claude/skills -name "SKILL.md" | head

# 一鍵 health check
~/scripts/claude-health-check.sh

# Claude Code 內常用
/clear           # 清對話歷史
/skills          # 列出可用 skill
/plugin list     # 列出已裝 plugin
/help            # 列出所有 slash commands
```

## 附錄 B:回退指令(萬一出問題)

```bash
# 完全回退到 73 plugin 版本
cp ~/.claude/backups/settings.json.<timestamp> ~/.claude/settings.json

# 移除環境變數(暫時)
unset CLAUDE_CODE_MAX_OUTPUT_TOKENS
unset ANTHROPIC_BASE_URL
# ... 其他

# 從 .zshrc 移除 (永久)
# 開啟 ~/.zshrc,刪除 # ===== Claude Code Local vLLM Settings ===== 那段
```

## 附錄 C:Q&A

**Q1**:兩台電腦的環境變數一定要一樣嗎?
A:基本一致,但 `ANTHROPIC_BASE_URL` 可能要看網路。如果 Mac-B 在公司外、無法連 Tailscale 也無法 VPN 到 GX10,可能需要備案(例如改用 Anthropic 雲端 API key)。

**Q2**:寫到 `~/.claude/skills/` 的 skill,會被 git 追蹤嗎?
A:不會。`~/.claude/` 預設不在 git 內。要追蹤要走 dotfiles repo 路線(本報告 2.1 節方法 B)。

**Q3**:如果一個 skill 的 SKILL.md 寫到 10000 行,會卡嗎?
A:**不會在 startup 時卡**(metadata 才 ~150 tokens)。但**被觸發後會吃 ~25k tokens** 進入 context。建議單一 SKILL.md 控制在 500-2000 行,超過就拆 sub-files (用 reference 連結)。

**Q4**:可以兩台同時用同一個 vLLM 嗎?
A:可以。你的 Golden Recipe 設了 `max-num-seqs 2`,正好支援雙人並發。但兩人同時送大 prompt 時會排隊,這是正常的。

**Q5**:每台電腦的 `~/.claude/skills/` 都要寫一遍嗎?
A:不用。**用 dotfiles repo (本報告 2.1 節方法 B)**,寫一次兩邊同步。

---

**報告結束**。

從「裝越多越好」到「精選 + 本地化」,你已經走完了一條成熟的路。**接下來只剩一件事:把這個工作流真正用起來,讓 Yupitek 業務跑得更快**。
