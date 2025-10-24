# 貢獻指南

感謝你有興趣為 Claude Code Templates 做出貢獻!

## 如何貢獻

### 回報 Bug

1. 檢查 [Issues](https://github.com/your-org/claude-code-templates/issues) 確認問題尚未被回報
2. 開啟新 Issue,包含:
   - 清楚的標題
   - 詳細描述問題
   - 重現步驟
   - 預期行為 vs 實際行為
   - 環境資訊 (OS, Claude Code 版本等)

### 建議功能

1. 開啟 Issue 描述新功能
2. 說明:
   - 功能用途
   - 使用場景
   - 預期效益

### 提交 Pull Request

#### 開發流程

1. **Fork 本 repo**
```bash
# Fork 後 clone 你的 fork
git clone https://github.com/your-username/claude-code-templates.git
cd claude-code-templates
```

2. **建立 feature branch**
```bash
git checkout -b feature/amazing-feature
```

3. **進行變更**
   - 遵循現有程式碼風格
   - 更新相關文檔
   - 測試你的變更

4. **Commit 變更**
```bash
git add .
git commit -m "feat: add amazing feature"
```

使用 [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` 新功能
- `fix:` Bug 修復
- `docs:` 文檔變更
- `refactor:` 重構
- `test:` 測試相關

5. **Push 到你的 fork**
```bash
git push origin feature/amazing-feature
```

6. **開啟 Pull Request**
   - 清楚描述變更內容
   - 引用相關 Issues
   - 說明測試方式

## 開發指南

### 新增語言支援

建立新語言配置 (以 C++ 為例):

1. **建立目錄結構**
```bash
mkdir -p languages/cpp/{commands/dev,hooks,agents}
```

2. **建立 CLAUDE.md**
```bash
cp languages/typescript/CLAUDE.md languages/cpp/CLAUDE.md
# 編輯內容符合 C++ 慣例
```

3. **建立 commands**
```bash
# languages/cpp/commands/dev/build.md
---
description: Build C++ project with CMake
allowed-tools: Bash
---

!cmake --build build
```

4. **建立 hooks**
```bash
# languages/cpp/hooks/clang-format.sh
#!/bin/bash
set -euo pipefail
input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // ""')
if echo "$file_path" | grep -qE '\.(cpp|hpp|h|cc)$'; then
  clang-format -i "$file_path" 2>/dev/null || true
fi
exit 0
```

5. **更新檢測邏輯**
```bash
# 在 scripts/init-project.sh 的 detect_language() 中添加:
# C++
if [[ -f "$dir/CMakeLists.txt" ]]; then
  echo "cpp"
  return
fi
```

6. **建立文檔**
```bash
# docs/language-specific/cpp.md
```

7. **測試**
```bash
# 建立測試專案
mkdir test-cpp-project
cd test-cpp-project
touch CMakeLists.txt
bash /path/to/claude-code-templates/scripts/init-project.sh
# 驗證配置正確安裝
```

### 新增 Custom Command

1. **建立指令檔案**
```bash
# core/commands/analyze/security-scan.md
---
description: Run security vulnerability scan
argument-hint: [directory]
---

Scan for security vulnerabilities in $ARGUMENTS or entire project.

Use tools like npm audit, pip-audit, cargo audit based on language.
```

2. **測試指令**
```bash
claude
/security-scan
```

### 新增 Subagent

1. **建立 agent 檔案**
```bash
# core/agents/test-generator.md
---
name: test-generator
description: Generate comprehensive test cases for code
tools: Read, Grep, Write
model: inherit
---

# Test Generator Agent
...
```

2. **測試 agent**
在 Claude Code 中測試 agent 是否正確觸發

## 程式碼風格

### Bash 腳本
- 使用 `set -euo pipefail`
- 添加註解說明功能
- 使用有意義的變數名
- 檢查錯誤條件

### Markdown 文檔
- 使用清晰的標題層級
- 提供程式碼範例
- 包含實際使用案例
- 保持簡潔明瞭

### 配置檔案
- JSON: 使用 2 spaces 縮排
- YAML: 使用 2 spaces 縮排
- 保持一致的格式

## 測試

### 測試你的變更

1. **語言檢測**
```bash
# 建立測試專案
mkdir test-project
cd test-project
touch package.json  # 或其他語言的特徵檔案
bash /path/to/claude-code-templates/scripts/init-project.sh
```

2. **Hooks**
```bash
# 測試 hook 腳本
echo '{"tool_input":{"file_path":"test.ts"}}' | .claude/hooks/prettier-format.sh
echo $?  # 應該是 0
```

3. **Commands**
```bash
claude
/your-new-command
```

## 文檔

所有新功能都應該包含文檔:

- **README.md**: 如果是主要功能
- **docs/guides/**: 詳細使用指南
- **docs/language-specific/**: 語言專屬說明
- **範例**: 在 docs/examples/ 中提供實例

## Pull Request 檢查清單

提交 PR 前確認:

- [ ] 程式碼遵循專案風格
- [ ] 已測試變更 (手動測試即可)
- [ ] 更新相關文檔
- [ ] Commit 訊息清楚
- [ ] PR 描述完整
- [ ] 沒有無關變更
- [ ] 腳本有執行權限 (`chmod +x`)

## 需要幫助?

- [GitHub Discussions](https://github.com/your-org/claude-code-templates/discussions) - 提問和討論
- [Issues](https://github.com/your-org/claude-code-templates/issues) - 回報問題
- [Wiki](https://github.com/your-org/claude-code-templates/wiki) - 社群文檔

## 授權

提交 PR 即表示你同意你的貢獻使用 MIT License。

---

再次感謝你的貢獻! 🎉
