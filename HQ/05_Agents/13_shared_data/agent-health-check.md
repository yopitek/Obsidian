# Agent 健康檢查機制

> 每日自動檢查所有 Agent 是否正常運作。
> 確保 API 連線、技能安裝、系統資源都處於正常狀態。

---

## 📊 健康檢查清單

### 檢查項目

| 檢查項目 | 描述 | 預期結果 |
|---------|------|---------|
| Agent 定義存在 | agent.md 文件存在且可讀 | ✅ |
| Skill 定義存在 | skill.md 文件存在且可讀 | ✅ |
| API 連線 | 主要 API 可訪問 | ✅ 可連線 |
| 技能安裝 | 必要技能已安裝 | ✅ 已安裝 |
| 寫入權限 | 可寫入 vault | ✅ 可寫入 |
| 日誌記錄 | 日誌目錄可寫入 | ✅ 可寫入 |

---

## 🤖 自動化健康檢查腳本

### Bash 檢查腳本

```bash
#!/bin/bash
# agent_health_check.sh

VAULT_PATH="$HOME/Downloads/n8n_project/obsidian/Obsidian/HQ"
LOG_DIR="$VAULT_PATH/05_Agents/13_shared_data/health_logs"
DATE=$(date +%Y-%m-%d)
LOG_FILE="$LOG_DIR/health_check_$DATE.txt"

# 確保日誌目錄存在
mkdir -p "$LOG_DIR"

# 開始檢查
echo "=== Agent 健康檢查 - $(date) ===" > "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 1. 檢查 Agent 定義文件
echo "📄 檢查 Agent 定義文件..." >> "$LOG_FILE"
for agent_dir in "$VAULT_PATH/05_Agents"/[0-9]*_*; do
    agent_name=$(basename "$agent_dir")
    agent_file="$agent_dir/agent.md"
    skill_file="$agent_dir/skill.md"
    
    if [ -f "$agent_file" ]; then
        echo "  ✅ $agent_name - agent.md 存在" >> "$LOG_FILE"
    else
        echo "  ❌ $agent_name - agent.md 缺失" >> "$LOG_FILE"
    fi
    
    if [ -f "$skill_file" ]; then
        echo "  ✅ $agent_name - skill.md 存在" >> "$LOG_FILE"
    else
        echo "  ⚠️ $agent_name - skill.md 缺失" >> "$LOG_FILE"
    fi
done
echo "" >> "$LOG_FILE"

# 2. 檢查 API 連線
echo "🔌 檢查 API 連線..." >> "$LOG_FILE"

# 檢查 Brave Search API (可選 - 需要 API Key)
if [ -f "$VAULT_PATH/05_Agents/env/.env" ]; then
    BRAVE_API=$(grep "BRAVE_API" "$VAULT_PATH/05_Agents/env/.env" | cut -d'=' -f2 | tr -d '"' | cut -c1-8)
    if [ -n "$BRAVE_API" ] && [ "$BRAVE_API" != "REDACTED" ]; then
        echo "  ✅ Brave API Key: $BRAVE_API..." >> "$LOG_FILE"
    else
        echo "  ⚠️ Brave API Key 未設定或已遮罩" >> "$LOG_FILE"
    fi
else
    echo "  ⚠️ .env 文件不存在" >> "$LOG_FILE"
fi
echo "" >> "$LOG_FILE"

# 3. 檢查 Vault 寫入權限
echo "💾 檢查 Vault 寫入權限..." >> "$LOG_FILE"
TEST_FILE="$LOG_DIR/.health_check_test_$$"
if touch "$TEST_FILE" 2>/dev/null; then
    echo "  ✅ Vault 寫入權限正常" >> "$LOG_FILE"
    rm -f "$TEST_FILE"
else
    echo "  ❌ Vault 寫入權限問題" >> "$LOG_FILE"
fi
echo "" >> "$LOG_FILE"

# 4. 檢查日誌目錄
echo "📝 檢查日誌目錄..." >> "$LOG_FILE"
for dir in "performance_logs" "health_logs" "qa_log"; do
    full_path="$VAULT_PATH/05_Agents/13_shared_data/$dir"
    if [ -d "$full_path" ]; then
        echo "  ✅ $dir 目錄存在" >> "$LOG_FILE"
    else
        echo "  ❌ $dir 目錄缺失" >> "$LOG_FILE"
    fi
done
echo "" >> "$LOG_FILE"

# 5. 檢查必要文件
echo "📋 檢查必要文件..." >> "$LOG_FILE"
for file in "routing.md" "skill-index.md" "high_priority_skills.md"; do
    if [ -f "$VAULT_PATH/05_Agents/13_shared_data/$file" ]; then
        echo "  ✅ $file 存在" >> "$LOG_FILE"
    else
        echo "  ❌ $file 缺失" >> "$LOG_FILE"
    fi
done
echo "" >> "$LOG_FILE"

# 總結
echo "=== 檢查總結 ===" >> "$LOG_FILE"
FAILED_COUNT=$(grep -c "❌" "$LOG_FILE")
WARNING_COUNT=$(grep -c "⚠️" "$LOG_FILE")
SUCCESS_COUNT=$(grep -c "✅" "$LOG_FILE")

echo "✅ 成功：$SUCCESS_COUNT" >> "$LOG_FILE"
echo "⚠️ 警告：$WARNING_COUNT" >> "$LOG_FILE"
echo "❌ 失敗：$FAILED_COUNT" >> "$LOG_FILE"

if [ $FAILED_COUNT -gt 0 ]; then
    echo "" >> "$LOG_FILE"
    echo "🚨 發現問題，需要立即處理！" >> "$LOG_FILE"
fi

echo "檢查完成！日誌：$LOG_FILE"
```

### Python 進階檢查腳本

```python
#!/usr/bin/env python3
# agent_health_check_advanced.py

import os
import json
from datetime import datetime
from pathlib import Path

class AgentHealthChecker:
    def __init__(self, vault_path):
        self.vault_path = Path(vault_path)
        self.agents = []
        self.check_results = []
        
    def discover_agents(self):
        """自動發現所有 Agent"""
        agents_dir = self.vault_path / "05_Agents"
        for item in agents_dir.iterdir():
            if item.is_dir() and item.name not in ['13_shared_data', '14_Daily_work_log', '15_Weekly_work_log', 'env']:
                agent_file = item / "agent.md"
                if agent_file.exists():
                    self.agents.append({
                        'name': item.name,
                        'path': str(item),
                        'agent_file': str(agent_file)
                    })
    
    def check_agent_definition(self, agent):
        """檢查 Agent 定義完整性"""
        results = []
        agent_file = Path(agent['agent_file'])
        
        # 檢查 agent.md 存在
        if agent_file.exists():
            with open(agent_file, 'r', encoding='utf-8') as f:
                content = f.read()
                checks = {
                    'name_field': 'name:' in content,
                    'description': 'description:' in content,
                    'tools': 'tools:' in content,
                    'model': 'model:' in content,
                    'rules': '## 行為規則' in content or '## 行為準則' in content
                }
                results.append({
                    'agent': agent['name'],
                    'check': '定義完整性',
                    'passed': all(checks.values()),
                    'details': checks
                })
        else:
            results.append({
                'agent': agent['name'],
                'check': '定義完整性',
                'passed': False,
                'details': {'error': 'agent.md 不存在'}
            })
        
        return results
    
    def check_routing_rules(self):
        """檢查 Routing 規則完整性"""
        routing_file = self.vault_path / "05_Agents" / "13_shared_data" / "routing.md"
        results = []
        
        if routing_file.exists():
            with open(routing_file, 'r', encoding='utf-8') as f:
                content = f.read()
                # 檢查是否包含所有 agent
                agent_count = len([a for a in self.agents if any(a['name'].lower() in content.lower() for _ in range(1))])
                results.append({
                    'check': 'Routing 規則',
                    'passed': agent_count == len(self.agents),
                    'details': {
                        'expected_agents': len(self.agents),
                        'found_agents': agent_count,
                        'missing_agents': len(self.agents) - agent_count
                    }
                })
        else:
            results.append({
                'check': 'Routing 規則',
                'passed': False,
                'details': {'error': 'routing.md 不存在'}
            })
        
        return results
    
    def check_shared_data(self):
        """檢查 Shared Data 完整性"""
        shared_dir = self.vault_path / "05_Agents" / "13_shared_data"
        results = []
        
        required_files = ['routing.md', 'skill-index.md', 'high_priority_skills.md']
        for file in required_files:
            file_path = shared_dir / file
            results.append({
                'check': f'Shared Data: {file}',
                'passed': file_path.exists(),
                'details': {'path': str(file_path)}
            })
        
        return results
    
    def run_full_check(self):
        """執行完整健康檢查"""
        self.discover_agents()
        self.check_results = []
        
        # 檢查所有 Agent
        for agent in self.agents:
            self.check_results.extend(self.check_agent_definition(agent))
        
        # 檢查 Routing 規則
        self.check_results.extend(self.check_routing_rules())
        
        # 檢查 Shared Data
        self.check_results.extend(self.check_shared_data())
        
        return self.check_results
    
    def generate_report(self):
        """生成檢查報告"""
        passed = sum(1 for r in self.check_results if r['passed'])
        failed = sum(1 for r in self.check_results if not r['passed'])
        
        report = {
            'timestamp': datetime.now().isoformat(),
            'total_checks': len(self.check_results),
            'passed': passed,
            'failed': failed,
            'success_rate': f"{(passed/len(self.check_results)*100):.1f}%",
            'agents_found': len(self.agents),
            'details': self.check_results
        }
        
        return report
    
    def save_report(self, report):
        """保存檢查報告"""
        log_dir = self.vault_path / "05_Agents" / "13_shared_data" / "health_logs"
        log_dir.mkdir(exist_ok=True)
        
        # JSON 格式
        json_file = log_dir / f"health_report_{datetime.now().strftime('%Y-%m-%d')}.json"
        with open(json_file, 'w', encoding='utf-8') as f:
            json.dump(report, f, indent=2, ensure_ascii=False)
        
        # Markdown 格式
        md_file = log_dir / f"health_report_{datetime.now().strftime('%Y-%m-%d')}.md"
        with open(md_file, 'w', encoding='utf-8') as f:
            f.write(f"# Agent 健康檢查報告 - {datetime.now().strftime('%Y-%m-%d')}\n\n")
            f.write(f"## 總結\n")
            f.write(f"- 檢查總數：{report['total_checks']}\n")
            f.write(f"- 通過：{report['passed']}\n")
            f.write(f"- 失敗：{report['failed']}\n")
            f.write(f"- 成功率：{report['success_rate']}\n\n")
            
            f.write(f"## 詳細結果\n")
            for result in self.check_results:
                status = "✅" if result['passed'] else "❌"
                f.write(f"- {status} {result['check']}\n")
                if not result['passed']:
                    f.write(f"  - 問題：{result['details']}\n")
        
        return str(md_file)

# 執行檢查
if __name__ == "__main__":
    VAULT_PATH = "/Users/benny/Downloads/n8n_project/obsidian/Obsidian/HQ"
    checker = AgentHealthChecker(VAULT_PATH)
    results = checker.run_full_check()
    report = checker.generate_report()
    report_path = checker.save_report(report)
    
    print(f"健康檢查完成！報告：{report_path}")
    print(f"成功率：{report['success_rate']}")
    
    if report['failed'] > 0:
        print(f"⚠️ 發現 {report['failed']} 個問題，請檢查報告")
