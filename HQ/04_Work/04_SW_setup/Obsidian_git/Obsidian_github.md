# Obsidian GitHub 備份與同步指南

> ⚠️ **安全規則（所有操作皆適用）：**  
> 絕對不要上傳 `.env` 檔案、`env/` 資料夾，或任何包含密碼/憑證的檔案到 GitHub。  
> 每次 commit 前，請確認 `.gitignore` 已存在且設定正確。

---

## 設備與帳號資訊

| 項目 | 說明 |
|---|---|
| 公司電腦 | Mac Mini |
| 家用電腦 | MacBook Air |
| GitHub Repo | `https://github.com/yopitek/Obsidian.git` |
| 公司本地路徑 | `/Users/benny/Downloads/n8n_project/obsidian/Obsidian/` |
| 家用本地路徑 | `/Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/` |

---

## 🏢 公司 Mac Mini

### ▶ 上傳（推送到 GitHub）

在 Terminal 執行以下指令：

```bash
cd /Users/benny/Downloads/n8n_project/obsidian/Obsidian/
```

**第一次使用（初始化設定）：**
```bash
# 若尚未初始化 Git，執行以下指令
git init
git remote add origin https://github.com/yopitek/Obsidian.git

# 建立 .gitignore（若不存在）
if [ ! -f .gitignore ]; then
  echo "env/" >> .gitignore
  echo "HQ/04_Work/env/" >> .gitignore
  echo ".env" >> .gitignore
  echo "*.env" >> .gitignore
fi

# 先 commit .gitignore
git add .gitignore
git commit -m "Add .gitignore to exclude env and credential folders"

# 若 env/ 資料夾之前已被 Git 追蹤，移除追蹤
git rm -r --cached env/ 2>/dev/null || true
git rm -r --cached HQ/04_Work/env/ 2>/dev/null || true
git commit -m "Remove env folders from Git tracking (credentials protection)"
```

**日常上傳（每次同步使用）：**
```bash
cd /Users/benny/Downloads/n8n_project/obsidian/Obsidian/

# 安全確認：確保 .gitignore 存在
if [ ! -f .gitignore ]; then
  echo "env/" >> .gitignore
  echo ".env" >> .gitignore
  git add .gitignore && git commit -m "Security: Exclude credentials"
fi

git add .
git commit -m "Sync Office - $(date '+%Y-%m-%d %H:%M')"
git push origin main
```

---

### ◀ 下載（從 GitHub 拉取）

```bash
cd /Users/benny/Downloads/n8n_project/obsidian/Obsidian/
git pull origin main
```

---

## 🏠 家用 MacBook Air

### ▶ 上傳（推送到 GitHub）

**第一次使用（初始化設定）：**
```bash
# 若資料夾不存在，先 clone
git clone https://github.com/yopitek/Obsidian.git \
  /Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian

cd /Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/

# 建立 .gitignore（若不存在）
if [ ! -f .gitignore ]; then
  echo "env/" >> .gitignore
  echo "HQ/04_Work/env/" >> .gitignore
  echo ".env" >> .gitignore
  echo "*.env" >> .gitignore
fi

git add .gitignore
git commit -m "Add .gitignore to exclude env and credential folders"
```

**日常上傳（每次同步使用）：**
```bash
cd /Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/

# 安全確認：確保 .gitignore 存在
if [ ! -f .gitignore ]; then
  echo "env/" >> .gitignore
  echo ".env" >> .gitignore
  git add .gitignore && git commit -m "Security: Exclude credentials"
fi

git add .
git commit -m "Sync Home - $(date '+%Y-%m-%d %H:%M')"
git push origin main
```

---

### ◀ 下載（從 GitHub 拉取）

**第一次使用（資料夾不存在）：**
```bash
git clone https://github.com/yopitek/Obsidian.git \
  /Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian
```

**日常下載（資料夾已存在）：**
```bash
cd /Users/goooolai/Downloads/n8n_project/25_Obsidian/Obsidian/
git pull origin main
```

> ℹ️ 下載操作請勿新增、修改或上傳任何檔案，保持單向同步。

---

## 🔧 常用查詢指令

| 用途 | 指令 |
|---|---|
| 查看目前狀態 | `git status` |
| 查看已追蹤的檔案 | `git ls-files` |
| 確認 `.gitignore` 是否生效 | `git check-ignore -v env/` |
| 強制移除已追蹤的資料夾 | `git rm -r --cached <folder>` |
| 查看 commit 紀錄 | `git log --oneline` |

---

## 📋 標準工作流程

```
公司編輯完成
     ↓
🏢 公司上傳（git push）
     ↓
GitHub 儲存最新版本
     ↓
🏠 家用下載（git pull）
     ↓
家用編輯完成
     ↓
🏠 家用上傳（git push）
     ↓
GitHub 儲存最新版本
     ↓
🏢 公司下載（git pull）
```
