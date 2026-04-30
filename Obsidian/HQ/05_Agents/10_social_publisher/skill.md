# Social Publisher — 跨平台內容發布技能

## When to use

當 art-expert、content-writer 或 video-director 完成產出，需要實際發布到社群平台時使用。也用於批量排程多平台內容發布任務。

## Workflow

1. **Receive brief** — 讀取任務：來源 agent、內容類型、目標平台清單
2. **Validate format** — 依平台規格表檢查尺寸/字數/標籤數是否符合
3. **Fix or reject** — 格式不符：退回來源 agent 修正；格式正確：繼續
4. **Check schedule** — 讀取 `10_social_publisher/schedule.md` 確認時段無衝突
5. **Add to schedule** — 將任務寫入排程表（待發布狀態）
6. **Publish** — 在排程時間呼叫 social-auto-upload 或平台 API 執行發布
7. **Verify** — 確認發布成功，取得貼文 URL/ID
8. **Retry if failed** — 失敗重試最多 3 次，3 次失敗後 Telegram 通知
9. **Log** — 呼叫 obsidian-builder 記錄發布結果到每日日誌

## 單平台快速發布（立即模式）

```bash
# 小紅書
python3 social-auto-upload/upload_xiaohongshu.py \
  --title "標題" \
  --content "內文" \
  --images "圖片路徑1,圖片路徑2" \
  --tags "標籤1,標籤2"

# Instagram（via social-auto-upload）
python3 social-auto-upload/upload_instagram.py \
  --caption "文案" \
  --media "圖片或影片路徑"

# 微信公眾號（via md2wechat）
# 先將 Markdown 轉為微信格式，再透過 API 推送
```

## Telegram 失敗通知格式

```
⚠️ 發布失敗通知
平台：[平台名稱]
內容：[標題/描述]
原因：[錯誤訊息]
重試次數：3/3
請手動處理：[內容路徑]
```

## Output format

```
## 發布報告
**任務：** [描述]
**執行時間：** YYYY-MM-DD HH:MM

| 平台 | 狀態 | URL/ID | 備註 |
|------|------|--------|------|
| 小紅書 | ✅ 成功 | https://... | |
| Instagram | ✅ 成功 | post_id_xxx | |
| Facebook | ❌ 失敗 | — | API 限流，已重試 3 次 |

**成功：** 2/3 平台
**Obsidian 記錄：** [[2026-04-18]] Agent 執行記錄
```

## APIs & Tools used

- Bash + social-auto-upload（多平台發布）
- Telegram Bot API（失敗通知）
- Read（讀取排程表與內容文件）
- Write / Edit（更新排程表狀態）
- obsidian-builder（記錄發布結果）
