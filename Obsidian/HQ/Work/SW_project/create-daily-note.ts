#!/usr/bin/env bun
/**
 * create-daily-note.ts
 *
 * Creates today's Obsidian Daily Note if it doesn't already exist.
 * Uses today's actual date (not a hardcoded value) so it works every day.
 *
 * Usage:
 *   bun /path/to/create-daily-note.ts
 *
 * Vault root is resolved relative to this script's location:
 *   <vault-root>/Daily_note/YYYY-MM-DD.md
 */

import { join, dirname } from "path";

// ---------------------------------------------------------------------------
// Config — vault root is two levels up from this script's SW_project folder
// (HQ/Work/SW_project → HQ/Work → HQ)
// ---------------------------------------------------------------------------
const SCRIPT_DIR = dirname(import.meta.path);
const VAULT_ROOT = join(SCRIPT_DIR, "..", "..");          // HQ/
const DAILY_NOTE_DIR = join(VAULT_ROOT, "Daily_note");

// ---------------------------------------------------------------------------
// Date helpers
// ---------------------------------------------------------------------------
function getTodayDateString(): string {
  const now = new Date();
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, "0");
  const day = String(now.getDate()).padStart(2, "0");
  return `${year}-${month}-${day}`;
}

// ---------------------------------------------------------------------------
// Template builder
// ---------------------------------------------------------------------------
function buildDailyNoteContent(dateString: string): string {
  return `---
title: ${dateString} 工作日誌
tags:
  - daily
  - "#in-progress"
created: ${dateString}
type: fleeting
summary:
---

## 市場資訊 📡
_由 market-researcher agent 自動更新_

---

## 電商工作

### ACS
- [ ]

### ALFA
- [ ]

### Ubiquiti
- [ ]

### 其他電商任務
- [ ]

---

## 學習進度 📚

### 今日學習
<!-- 學了什麼、讀了什麼 -->

### 學習筆記連結
<!-- [[永久筆記連結]] -->

---

## 任務記錄
<!-- Commander 分派的所有任務 -->
| 時間 | 任務 | Agent | 狀態 |
|------|------|-------|------|
|  |  |  |  |

---

## 今日重點 🎯
<!-- 今天最重要的 1-3 件事，每天開始前手動填寫 -->
1.
2.
3.

---

## 明日待辦
<!-- 未完成或需要延續的事項 -->
- [ ]
`;
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------
async function createDailyNote(): Promise<void> {
  const dateString = getTodayDateString();
  const notePath = join(DAILY_NOTE_DIR, `${dateString}.md`);

  const noteFile = Bun.file(notePath);
  const alreadyExists = await noteFile.exists();

  if (alreadyExists) {
    console.log(`✓ Daily note already exists: ${notePath}`);
    return;
  }

  const content = buildDailyNoteContent(dateString);
  await Bun.write(notePath, content);

  console.log(`✓ Created daily note: ${notePath}`);
}

createDailyNote().catch((error: unknown) => {
  const message = error instanceof Error ? error.message : String(error);
  console.error(`✗ Failed to create daily note: ${message}`);
  process.exit(1);
});
