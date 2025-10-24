# 🪝 Hooks 完整指南

## 什麼是 Hooks?

Hooks 是在特定事件發生時自動執行的腳本,讓你能夠自動化重複性工作。

## 可用的 Hook 事件

### 1. PreToolUse
**觸發時機**: Claude 準備使用工具之前

**用途**:
- 自動格式化程式碼
- 驗證操作安全性
- 檢查權限

**範例: 自動格式化**
```bash
#!/bin/bash
# .claude/hooks/auto-format.sh
set -euo pipefail

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // ""')

# 對 TypeScript 檔案執行 Prettier
if echo "$file_path" | grep -qE '\.(ts|tsx)$'; then
  prettier --write "$file_path" 2>/dev/null || true
fi

exit 0
```

**配置**:
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "command": ".claude/hooks/auto-format.sh"
      }
    ]
  }
}
```

### 2. PostToolUse
**觸發時機**: 工具執行成功後

**用途**:
- 執行 lint 檢查
- 運行測試
- Git add 變更

**範例: Lint 檢查**
```bash
#!/bin/bash
# .claude/hooks/lint-check.sh
set -euo pipefail

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // ""')

if echo "$file_path" | grep -qE '\.(ts|tsx)$'; then
  if ! eslint "$file_path" 2>&1; then
    echo "⚠️  Lint issues found. Run /lint-fix" >&2
  fi
fi

exit 0
```

### 3. SessionStart
**觸發時機**: Claude Code 啟動或恢復時

**用途**:
- 顯示專案資訊
- 載入環境變數
- 檢查依賴

**範例: 顯示專案資訊**
```bash
#!/bin/bash
# .claude/hooks/session-init.sh
set -euo pipefail

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')

echo "🚀 Starting Claude Code session"
echo "📁 Project: $(basename "$cwd")"

if [ -d "$cwd/.git" ]; then
  echo "🌿 Branch: $(git -C "$cwd" branch --show-current)"
fi

exit 0
```

### 4. UserPromptSubmit
**觸發時機**: 用戶提交 prompt 之前

**用途**:
- 注入上下文資訊
- 驗證輸入
- 記錄 prompts

### 5. Notification
**觸發時機**: Claude Code 發送通知時

**用途**:
- 系統通知
- 記錄權限請求
- 觸發外部系統

### 6. Stop
**觸發時機**: Agent 完成回應時

**用途**:
- 檢查工作完整性
- 提示後續步驟

### 7. SessionEnd
**觸發時機**: Session 結束時

**用途**:
- 清理臨時文件
- 保存工作狀態

### 8. PreCompact
**觸發時機**: 上下文壓縮之前

**用途**:
- 保存重要資訊

## Exit Code 的意義

```bash
# Exit 0: 成功,繼續執行
exit 0

# Exit 2: 阻止操作,錯誤訊息給 Claude
echo "Operation blocked!" >&2
exit 2

# 其他: 非阻止性錯誤,訊息給用戶
echo "Warning" >&2
exit 1
```

## 實用 Hooks 範例

### 安全檢查 Hook
```bash
#!/bin/bash
# 防止修改敏感文件
set -euo pipefail

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // ""')

SENSITIVE_PATTERNS=(
  "\.env$"
  "credentials\.json"
  "\.pem$"
  "\.key$"
)

for pattern in "${SENSITIVE_PATTERNS[@]}"; do
  if echo "$file_path" | grep -qE "$pattern"; then
    echo "❌ BLOCKED: Cannot modify sensitive file: $file_path" >&2
    exit 2
  fi
done

exit 0
```

### 自動測試 Hook
```bash
#!/bin/bash
# 修改後自動執行相關測試
set -euo pipefail

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // ""')

# 找到對應的測試文件
test_file="${file_path/.ts/.test.ts}"

if [ -f "$test_file" ]; then
  echo "🧪 Running tests for $file_path"
  npm test -- "$test_file" || true
fi

exit 0
```

## 最佳實踐

1. **快速執行**: Hooks 應該快速完成,避免阻塞
2. **錯誤處理**: 使用 `|| true` 避免 hook 失敗中斷工作流程
3. **清楚輸出**: 使用 emoji 和清楚的訊息
4. **條件執行**: 只在必要時執行操作

## 常見問題

**Q: Hook 沒有執行?**
```bash
# 檢查權限
chmod +x .claude/hooks/*.sh

# 測試 hook
echo '{"tool_input":{"file_path":"test.ts"}}' | .claude/hooks/my-hook.sh
```

**Q: 如何停用 Hook?**
編輯 `.claude/config.json`,移除或註解該 hook 配置。

詳見 [FAQ](../FAQ.md)
