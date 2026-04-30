#!/bin/bash
# Agent 健康檢查腳本 - 每日自動執行

VAULT_PATH="$HOME/Downloads/n8n_project/obsidian/Obsidian/HQ"
LOG_DIR="$VAULT_PATH/05_Agents/13_shared_data/health_logs"
DATE=$(date +%Y-%m-%d)
LOG_FILE="$LOG_DIR/health_check_$DATE.txt"

mkdir -p "$LOG_DIR"

echo "=== Agent 健康檢查 - $(date) ===" > "$LOG_FILE"
echo "" >> "$LOG_FILE"

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

echo "🔌 檢查 API 設定..." >> "$LOG_FILE"
if [ -f "$VAULT_PATH/05_Agents/env/.env" ]; then
    echo "  ✅ .env 文件存在" >> "$LOG_FILE"
    for var in "BRAVE_API" "DEEPSEEK_API" "HF_API"; do
        if grep -q "^$var=" "$VAULT_PATH/05_Agents/env/.env"; then
            echo "  ✅ $var 已設定" >> "$LOG_FILE"
        else
            echo "  ⚠️ $var 未設定" >> "$LOG_FILE"
        fi
    done
else
    echo "  ❌ .env 文件不存在" >> "$LOG_FILE"
fi
echo "" >> "$LOG_FILE"

echo "💾 檢查 Vault 寫入權限..." >> "$LOG_FILE"
TEST_FILE="$LOG_DIR/.health_check_test_$$"
if touch "$TEST_FILE" 2>/dev/null; then
    echo "  ✅ Vault 寫入權限正常" >> "$LOG_FILE"
    rm -f "$TEST_FILE"
else
    echo "  ❌ Vault 寫入權限問題" >> "$LOG_FILE"
fi
echo "" >> "$LOG_FILE"

echo "📝 檢查日誌目錄..." >> "$LOG_FILE"
for dir in "performance_logs" "health_logs" "qa_log" "performance_summary"; do
    full_path="$VAULT_PATH/05_Agents/13_shared_data/$dir"
    if [ -d "$full_path" ]; then
        echo "  ✅ $dir 目錄存在" >> "$LOG_FILE"
    else
        echo "  ❌ $dir 目錄缺失" >> "$LOG_FILE"
    fi
done
echo "" >> "$LOG_FILE"

echo "📋 檢查必要文件..." >> "$LOG_FILE"
for file in "routing.md" "skill-index.md" "high_priority_skills.md" "error-handling-template.md" "performance-tracking.md" "ARCHITECTURE.md"; do
    if [ -f "$VAULT_PATH/05_Agents/$file" ] || [ -f "$VAULT_PATH/05_Agents/13_shared_data/$file" ]; then
        echo "  ✅ $file 存在" >> "$LOG_FILE"
    else
        echo "  ❌ $file 缺失" >> "$LOG_FILE"
    fi
done
echo "" >> "$LOG_FILE"

echo "🎯 檢查 Orchestrator..." >> "$LOG_FILE"
ORCH_FILE="$VAULT_PATH/05_Agents/01_orchestrator/agent.md"
if [ -f "$ORCH_FILE" ]; then
    AGENT_COUNT=$(grep -c "| [0-9]* |" "$ORCH_FILE" 2>/dev/null || echo "0")
    echo "  ✅ Orchestrator 定義存在" >> "$LOG_FILE"
    echo "  📊 管理的 Agent 數量：$AGENT_COUNT" >> "$LOG_FILE"
else
    echo "  ❌ Orchestrator 定義缺失" >> "$LOG_FILE"
fi
echo "" >> "$LOG_FILE"

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
    exit 1
else
    echo "" >> "$LOG_FILE"
    echo "✅ 所有檢查通過！系統運行正常。" >> "$LOG_FILE"
    exit 0
fi
