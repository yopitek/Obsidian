# 標準化錯誤處理模板

> 所有 Agent 統一使用的錯誤處理規範。
> 確保錯誤資訊一致、重試機制明確、通知邏輯清晰。

---

## 錯誤等級分類

| 等級 | 名稱 | 描述 | 處理方式 |
|------|------|------|---------|
| E1 | Critical | 系統崩潰、API 不可用 | 立即通知使用者，停止執行 |
| E2 | Error | 任務失敗、資料錯誤 | 重試 3 次，仍失敗則通知 |
| E3 | Warning | 部分失敗、品質問題 | 記錄並繼續，報告時標註 |
| E4 | Info | 資訊性訊息 | 僅記錄，不影響流程 |

---

## 重試機制規範

### 標準重試次數

| 錯誤等級 | 重試次數 | 等待時間 | 最終處理 |
|---------|---------|---------|---------|
| E1 | 0 | - | 立即通知，停止 |
| E2 | 3 | 指數退避 (1s, 2s, 4s) | 通知使用者 |
| E3 | 2 | 立即重試 | 記錄並繼續 |
| E4 | 0 | - | 僅記錄 |

### 指數退避公式

```
等待時間 = 基礎時間 × 2^(失敗次數 - 1)
基礎時間 = 1 秒
```

範例：
- 第 1 次失敗：等待 1 秒
- 第 2 次失敗：等待 2 秒
- 第 3 次失敗：等待 4 秒

---

## 錯誤訊息格式

### 統一模板

```markdown
## ❌ [錯誤等級] [錯誤類型]

**任務：** [任務名稱]
**時間：** YYYY-MM-DD HH:MM:SS
**Agent：** [Agent 名稱]

### 錯誤訊息
[詳細錯誤訊息]

### 可能原因
1. [原因 1]
2. [原因 2]

### 已執行的操作
- [ ] 嘗試重試 [X] 次
- [ ] 檢查 [資源/API/連線]
- [ ] [其他操作]

### 建議修正
- [具體建議 1]
- [具體建議 2]

### 狀態
[失敗 / 重試中 / 已解決]
```

### 範例

```markdown
## ❌ E2 API 連接錯誤

**任務：** 小紅書發文
**時間：** 2026-04-28 14:30:15
**Agent：** content-writer

### 錯誤訊息
Connection timeout: Unable to reach Xiaohongshu API endpoint

### 可能原因
1. 網路連線不穩定
2. API 伺服器暫時不可用
3. API Key 過期

### 已執行的操作
- ✅ 嘗試重試 1/3 次（等待 1 秒）
- ✅ 嘗試重試 2/3 次（等待 2 秒）
- ❌ 嘗試重試 3/3 次（等待 4 秒）
- ✅ 檢查 API Key 有效性

### 建議修正
- 檢查網路連線狀態
- 確認 API Key 未過期
- 稍後再試

### 狀態
⏳ 需要人工介入
```

---

## Telegram 通知規範

### 通知觸發條件

| 情況 | 通知對象 | 通知時機 |
|------|---------|---------|
| E1 錯誤 | 使用者 | 立即 |
| E2 錯誤（3 次重試失敗） | 使用者 | 重試結束後 |
| 連續 3 次任務失敗 | 使用者 | 立即 |
| 系統恢復 | 使用者 | 恢復時 |

### 通知訊息格式

```markdown
🚨 [錯誤等級] [Agent 名稱] 錯誤

任務：[任務名稱]
時間：[YYYY-MM-DD HH:MM]
錯誤：[簡短描述]

[詳細連結或建議]
```

### 範例

```
🚨 E2 content-writer API 錯誤

任務：小紅書發文
時間：2026-04-28 14:30:15
錯誤：Xiaohongshu API connection timeout (3 retries failed)

建議：檢查 API Key 或稍後重試
```

---

## 各 Agent 特定錯誤處理

### Orchestrator

```python
# 任務派遣失敗
if agent_dispatch_failed:
    log_error("Agent dispatch failed", agent_name)
    retry_dispatch(max_retries=3)
    if all_failed:
        notify_user(f"Agent {agent_name} unavailable")
        fallback_to_default_agent()
```

### Obsidian Builder

```python
# 寫入失敗
try:
    write_to_obsidian(file_path, content)
except PermissionError:
    log_error("Permission denied", file_path)
    notify_user(f"Cannot write to {file_path}, check permissions")
except IOError:
    retry_write(max_retries=2)
```

### Art Expert

```python
# 圖像生成失敗
if image_generation_failed:
    fallback_to_default_prompt()
    retry_generation(max_retries=2)
    if still_failed:
        notify_user("Image generation failed, using placeholder")
        use_placeholder_image()
```

### Social Publisher

```python
# 發布失敗
if publish_failed:
    log_to_schedule(f"Failed to publish to {platform}", status="待重試")
    retry_publish(max_retries=3)
    if all_failed:
        notify_user(f"Failed to publish to {platform}")
        mark_as_manual_review()
```

### Market Researcher

```python
# API 搜尋失敗
if search_api_failed:
    log_warning("Search API timeout, using cached data")
    use_cached_data(freshness_check=True)
    notify_if_cache_stale(age_threshold_hours=24)
```

---

## 錯誤日誌記錄

### 日誌格式

建立 `HQ/05_Agents/13_shared_data/error_logs/YYYY-MM-DD.md`：

```markdown
## 錯誤日誌 - YYYY-MM-DD

| 時間 | 等級 | Agent | 任務 | 錯誤類型 | 狀態 |
|------|------|------|------|---------|------|
```

### 錯誤統計

每週彙總：

```markdown
## 本週錯誤統計

- **總錯誤數：** [X]
- **E1 嚴重錯誤：** [X]
- **E2 錯誤：** [X]
- **E3 警告：** [X]
- **解決率：** [X]%
- **最常失敗的 Agent：** [Agent 名稱]
```

---

## 恢復機制

### 自動恢復

1. **API 重試** — 自動重試失敗的 API 呼叫
2. **資料備份還原** — 從備份恢復未完成的資料
3. **隊列重放** — 從失敗點重新處理任務隊列

### 手動恢復

1. **使用者確認** — 通知使用者等待人工介入
2. **跳過錯誤** — 允許跳過非關鍵錯誤繼續執行
3. **手動重試** — 使用者手動觸發失敗任務重試

---

## 檢查清單

### 錯誤發生時

- [ ] 記錄錯誤等級
- [ ] 記錄錯誤訊息
- [ ] 執行重試機制
- [ ] 檢查是否需要通知使用者
- [ ] 記錄到錯誤日誌
- [ ] 更新任務狀態

### 錯誤解決後

- [ ] 記錄解決方式
- [ ] 更新日誌
- [ ] 通知相關人員（如適用）
- [ ] 分析根本原因
- [ ] 提出預防措施
