# Agent 效能追蹤框架

> 統一記錄與分析各 Agent 的執行效能。
> 用於優化工作流、識別瓶頸、提升整體效率。

---

## 追蹤指標

### 核心指標

| 指標 | 描述 | 單位 | 目標值 |
|------|------|------|-------|
| Execution Time | 任務執行時間 | 秒/分鐘 | < 60s |
| Success Rate | 任務成功率 | % | > 95% |
| Retry Count | 平均重試次數 | 次 | < 0.5 |
| API Cost | API 使用成本 | USD | 依預算 |
| Quality Score | 內容品質評分 | 1-10 | > 8 |

### 進階指標

| 指標 | 描述 |
|------|------|
| Parallel Efficiency | 並行任務效率比 |
| Queue Wait Time | 任務排隊等待時間 |
| Resource Utilization | 資源使用率 |
| Error Rate by Type | 按類別分組的錯誤率 |

---

## 數據收集模板

### 每次任務記錄

建立 `HQ/05_Agents/13_shared_data/performance_logs/YYYY-MM-DD-HHMMSS.json`：

```json
{
  "task_id": "task_20260428_143015_001",
  "timestamp": "2026-04-28T14:30:15Z",
  "agent": "content-writer",
  "task_type": "xiaohongshu_post",
  "task_name": "ALFA AXM 種草文",
  
  "performance": {
    "execution_time_seconds": 45.2,
    "queue_wait_seconds": 3.1,
    "total_time_seconds": 48.3,
    "retries": 0,
    "api_calls": 3,
    "api_cost_usd": 0.025
  },
  
  "quality": {
    "qa_score": 9,
    "qa_check_passed": true,
    "brand_consistency": "✅",
    "format_compliance": "✅",
    "content_quality": "✅"
  },
  
  "status": "completed",
  "errors": [],
  "notes": "所有檢查通過，發布成功"
}
```

### 簡化 Markdown 記錄

建立 `HQ/05_Agents/13_shared_data/performance_logs/YYYY-MM-DD.md`：

```markdown
## 效能日誌 - YYYY-MM-DD

| 時間 | Agent | 任務 | 執行時間 | 重試 | 結果 | QA 分 |
|------|------|------|---------|-----|------|-----|
| 14:30 | content-writer | 小紅書種草文 | 45s | 0 | ✅ | 9 |
| 14:35 | art-expert | Instagram 海報 | 38s | 1 | ✅ | 8 |
| 14:40 | social-publisher | 發布到 IG | 12s | 0 | ✅ | - |
```

---

## 效能儀表板

### 每日摘要模板

建立 `HQ/05_Agents/13_shared_data/performance_summary/daily/YYYY-MM-DD.md`：

```markdown
## 每日效能摘要 - YYYY-MM-DD

### 總覽
- **總任務數：** [X]
- **成功任務：** [X] ([X]%)
- **失敗任務：** [X]
- **總執行時間：** [X] 分鐘
- **平均執行時間：** [X] 秒
- **總 API 成本：** $[X]

### Agent 效能排名

#### 最快 Agent
| 排名 | Agent | 平均時間 | 任務數 |
|------|------|---------|-------|
| 1 | social-publisher | 12s | 5 |
| 2 | obsidian-builder | 18s | 8 |
| 3 | market-researcher | 45s | 3 |

#### 最穩定 Agent（成功率）
| 排名 | Agent | 成功率 | 任務數 |
|------|------|-------|-------|
| 1 | obsidian-builder | 100% | 8 |
| 2 | social-publisher | 100% | 5 |
| 3 | quality-assurance | 95% | 20 |

### 瓶頸分析
- **最慢任務：** [任務名稱] ([X] 秒)
- **最常失敗 Agent：** [Agent 名稱] ([X] 次失敗)
- **最高成本任務：** [任務名稱] ($[X])

### 今日改善建議
1. [建議 1]
2. [建議 2]
```

### 每週彙總模板

建立 `HQ/05_Agents/13_shared_data/performance_summary/weekly/YYYY-WXX.md`：

```markdown
## 每週效能彙總 - YYYY 第 WW 週

### 關鍵指標
- **總任務數：** [X]
- **平均成功率：** [X]%
- **總執行時間：** [X] 小時
- **總 API 成本：** $[X]
- **平均 QA 分數：** [X]/10

### Agent 活動統計
| Agent | 任務數 | 平均時間 | 成功率 | 總成本 |
|------|-------|---------|-------|--------|
| orchestrator | X | Xs | X% | $X |
| content-writer | X | Xs | X% | $X |
| art-expert | X | Xs | X% | $X |
| ... | ... | ... | ... | ... |

### 趨勢分析
- **任務量變化：** ↑[X]% vs 上週
- **效率變化：** ↑[X]% vs 上週（時間減少）
- **成本變化：** ↓[X]% vs 上週

### 改善重點
1. [需要优化的 Agent/流程]
2. [可以自動化的任務]
3. [需要投資的工具]
```

---

## 性能分析工具

### Bash 效能檢查腳本

```bash
#!/bin/bash
# performance-check.sh

LOG_FILE="$HOME/Downloads/n8n_project/obsidian/Obsidian/HQ/05_Agents/13_shared_data/performance_logs/$(date +%Y-%m-%d).md"

echo "## 效能日誌 - $(date +%Y-%m-%d)" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
echo "| 時間 | Agent | 任務 | 執行時間 | 重試 | 結果 | QA 分 |" >> "$LOG_FILE"
echo "|------|------|------|---------|-----|------|-----|" >> "$LOG_FILE"

# 從執行日誌讀取數據並格式化
grep "TASK_COMPLETED" /path/to/execution_logs/*.log | while read line; do
  # 解析並添加到日誌
  echo "| $(parse_time $line) | $(parse_agent $line) | $(parse_task $line) | ..."
done >> "$LOG_FILE"
```

### Python 效能分析腳本

```python
#!/usr/bin/env python3
# performance_analyzer.py

import json
import pandas as pd
from datetime import datetime, timedelta

def analyze_daily_performance(date):
    """分析單日效能"""
    # 讀取当日 JSON 記錄
    files = glob.glob(f"performance_logs/{date}*.json")
    data = [json.load(open(f)) for f in files]
    
    df = pd.DataFrame(data)
    
    # 計算指標
    avg_time = df['performance.execution_time_seconds'].mean()
    success_rate = (df['status'] == 'completed').mean() * 100
    total_retries = df['performance.retries'].sum()
    
    print(f"Average execution time: {avg_time:.1f}s")
    print(f"Success rate: {success_rate:.1f}%")
    print(f"Total retries: {total_retries}")
    
    return df

def analyze_agent_performance(df):
    """分析各 Agent 效能"""
    agent_stats = df.groupby('agent').agg({
        'performance.execution_time_seconds': 'mean',
        'performance.retries': 'sum',
        'status': lambda x: (x == 'completed').mean() * 100
    }).rename(columns={
        'performance.execution_time_seconds': 'avg_time',
        'status': 'success_rate'
    })
    
    return agent_stats.sort_values('avg_time')
```

---

## 性能閾值與警報

### 標準閾值

| 指標 | 警告閾值 | 嚴重閾值 | 動作 |
|------|---------|---------|------|
| 執行時間 | > 120s | > 300s | 記錄/通知 |
| 失敗率 | > 5% | > 10% | 記錄/通知 |
| 平均重試 | > 1 | > 2 | 記錄/通知 |
| API 成本 | > $10/天 | > $50/天 | 記錄/通知 |

### 警報通知

```markdown
## ⚠️ 性能警報

**日期：** YYYY-MM-DD
**警報類型：** [執行時間/失敗率/成本]

### 詳細資訊
- [閾值資訊]
- [當前值]
- [影響範圍]

### 建議行動
- [建議 1]
- [建議 2]
```

---

## 優化建議生成

### 基於數據的建議

```python
def generate_optimization_recommendations(df):
    recommendations = []
    
    # 識別最慢的 Agent
    slowest_agent = df.groupby('agent')['execution_time'].mean().idxmax()
    recommendations.append(f"優化 {slowest_agent} 的執行時間")
    
    # 識別最高失敗率的 Agent
    fail_rate = df.groupby('agent').apply(lambda x: (x['status'] != 'completed').mean())
    highest_failure_agent = fail_rate.idxmax()
    recommendations.append(f"調查 {highest_failure_agent} 的失敗原因")
    
    # 識別可以並行的任務
    sequential_tasks = identify_sequential_tasks(df)
    recommendations.append(f"考慮將 {sequential_tasks} 改為並行執行")
    
    return recommendations
```

---

## 實作步驟

1. **建立日誌目錄**
   ```bash
   mkdir -p HQ/05_Agents/13_shared_data/performance_logs/YYYY-MM-DD/
   mkdir -p HQ/05_Agents/13_shared_data/performance_summary/daily/
   mkdir -p HQ/05_Agents/13_shared_data/performance_summary/weekly/
   ```

2. **在每个 Agent 中添加效能追蹤**
   ```python
   # 在任務開始時
   start_time = time.time()
   task_id = generate_task_id()
   
   # 在任務結束時
   execution_time = time.time() - start_time
   log_performance({
       'task_id': task_id,
       'agent': agent_name,
       'execution_time': execution_time,
       ...
   })
   ```

3. **建立自動化分析腳本**
   ```bash
   # 每日自動運行
   0 6 * * * /path/to/daily_performance_report.sh
   ```

4. **每週彙總**
   ```bash
   # 每週日自動運行
   0 7 * * 0 /path/to/weekly_performance_report.sh
   ```
