# 📘 Claude Code Templates 完整使用手冊

## 目錄

1. [基本概念](#基本概念)
2. [安裝與設定](#安裝與設定)
3. [智慧語言檢測](#智慧語言檢測)
4. [Custom Commands](#custom-commands)
5. [Subagents](#subagents)
6. [Hooks](#hooks)
7. [SDD 工作流程](#sdd-工作流程)
8. [CLAUDE.md Memory](#claude-md-memory)
9. [MCP Servers](#mcp-servers)
10. [Modern CLI Tools](#modern-cli-tools)
11. [最佳實踐](#最佳實踐)
12. [疑難排除](#疑難排除)

---

## 基本概念

### 什麼是 Claude Code Templates?

這是一個**可重用的配置模板庫**,提供:
- **通用核心配置** - 適用所有語言
- **語言特定配置** - 針對 7 種語言優化
- **智慧檢測** - 自動識別並套用正確配置

### 專案結構

安裝後,你的專案會有:

```
your-project/
├── .claude/
│   ├── agents/         # Custom subagents
│   ├── commands/       # Custom slash commands
│   │   ├── analyze/   # 分析工具
│   │   ├── refactor/  # 重構工具
│   │   ├── docs/      # 文件生成
│   │   └── dev/       # 開發工具 (語言特定)
│   ├── hooks/         # Hook 腳本
│   ├── config.json    # Hooks 配置
│   └── CLAUDE.md      # 專案記憶
├── CLAUDE.local.md    # 個人偏好 (gitignore)
├── .claudeignore      # 排除文件
└── steering.md        # Modern CLI 工具指南
```

---

## 安裝與設定

### 前置需求

- ✅ Claude Code 已安裝
- ✅ Git
- ✅ Bash shell
- ✅ Node.js (用於 SDD 工具)

### 步驟 1: Clone 模板庫

```bash
git clone https://github.com/Casear/claude-code-setting.git ~/claude-templates
```

### 步驟 2: 初始化專案

```bash
# 進入你的專案目錄
cd /path/to/your/project

# 執行智慧初始化
bash ~/claude-templates/scripts/init-project.sh
```

**腳本會自動**:
1. 檢測專案語言 (TypeScript, Python, Go, Rust, Java, Elixir, Erlang)
2. 創建 `.claude/` 目錄
3. 安裝核心配置
4. 套用語言特定配置
5. 設定 hooks

### 步驟 3: 安裝工具

```bash
# 安裝 modern CLI 工具
bash ~/claude-templates/setup-tool.sh

# 安裝 SDD 工具
npx cc-sdd@latest
```

### 步驟 4: 驗證安裝

```bash
# 檢查配置
ls -la .claude/

# 啟動 Claude Code
claude

# 查看可用指令
/help
```

---

## 智慧語言檢測

### 支援的語言

| 語言 | 檢測依據 | 包含配置 |
|------|---------|---------|
| **TypeScript** | package.json + typescript | 完整配置 (agents, commands, hooks) |
| **JavaScript** | package.json | 基本配置 |
| **Python** | pyproject.toml, requirements.txt | CLAUDE.md + format command |
| **Go** | go.mod | CLAUDE.md + 開發指引 |
| **Rust** | Cargo.toml | CLAUDE.md + toolchain |
| **Java** | pom.xml, build.gradle | CLAUDE.md + build tools |
| **Elixir** | mix.exs | CLAUDE.md + mix |
| **Erlang** | rebar.config | CLAUDE.md + rebar |

### 檢測範例

```bash
# TypeScript 專案
$ ls
package.json  tsconfig.json  src/

$ bash ~/claude-templates/scripts/init-project.sh
📊 Detection Results:
  Detected language: typescript
🎯 Applying typescript-specific configuration...
✅ Configuration installed successfully!
```

### 手動指定語言

如果自動檢測錯誤:

```bash
bash ~/claude-templates/scripts/init-project.sh

# 當提示時,輸入:
Language: python
```

---

## Custom Commands

### 通用指令 (所有語言)

#### 分析工具

**`/analyze-deps [package-name]`**
- 分析專案依賴
- 檢查過期、安全漏洞、未使用的套件
- 如果指定套件名稱,深入分析該套件

```bash
/analyze-deps
# 分析所有依賴

/analyze-deps lodash
# 分析 lodash 的使用情況
```

**`/analyze-complexity [file-path]`**
- 分析程式碼複雜度
- 找出高複雜度函數
- 提供重構建議

```bash
/analyze-complexity
# 分析整個專案

/analyze-complexity src/utils/helper.ts
# 分析特定檔案
```

**`/find-duplicates`**
- 找出重複程式碼
- 建議提取共用函數
- 識別重複 patterns

```bash
/find-duplicates
# 掃描整個專案的重複程式碼
```

#### 重構工具

**`/extract-function <file:line-range>`**
- 提取程式碼為函數
- 自動命名和參數推斷
- 處理副作用

```bash
/extract-function src/app.ts:45-60
# 提取第 45-60 行為函數
```

#### 文件生成

**`/gen-readme`**
- 生成專案 README
- 包含安裝、使用、API 說明
- 基於實際程式碼分析

```bash
/gen-readme
# 生成 README.md
```

**`/gen-api-docs [directory]`**
- 生成 API 文檔
- 提取函數簽名和註解
- 生成使用範例

```bash
/gen-api-docs src/api
# 為 API 目錄生成文檔
```

---

### 語言特定指令

#### TypeScript/JavaScript

**`/lint-fix`**
```bash
/lint-fix
# 執行 ESLint 並自動修復
```

**`/test-all`**
```bash
/test-all
# 執行所有測試 + 覆蓋率報告
```

**`/build-check`**
```bash
/build-check
# TypeScript 型別檢查 + 建置
```

#### Python

**`/format`**
```bash
/format
# 執行 Black + Ruff 格式化
```

---

## Subagents

### 可用的 Subagents

#### 1. code-reviewer
**用途**: 程式碼審查

**自動觸發**: 當你要求審查程式碼時

**功能**:
- 檢查程式碼品質和最佳實踐
- 識別潛在 bugs 和邏輯錯誤
- 安全性檢查 (SQL injection, XSS 等)
- 效能問題識別
- 測試覆蓋率分析

**使用範例**:
```bash
# Claude 會自動使用 code-reviewer
"請審查 src/auth/login.ts 的程式碼"

# 輸出:
### Summary
Authentication logic is generally well-structured...

### Critical Issues
1. [SECURITY] Password not hashed before comparison (login.ts:45)
2. [BUG] Missing null check for user object (login.ts:52)

### Suggestions
1. Use bcrypt for password hashing
2. Add input validation
...
```

#### 2. security-scanner
**用途**: 安全漏洞掃描

**自動觸發**: 當涉及安全相關任務時

**功能**:
- SQL Injection 檢測
- XSS 漏洞識別
- 敏感資料洩露檢查
- 認證和授權問題
- 依賴漏洞掃描

**使用範例**:
```bash
"掃描專案的安全漏洞"

# 輸出:
### [HIGH] SQL Injection Risk
**Location**: src/db/query.ts:23
**Issue**: User input directly concatenated into SQL query
**Fix**: Use parameterized queries
...
```

#### 3. performance-optimizer
**用途**: 效能優化

**功能**:
- 識別效能瓶頸
- 演算法複雜度分析
- 資料庫查詢優化
- 記憶體洩漏檢測
- Bundle size 分析

**使用範例**:
```bash
"優化這個檔案的效能"

# 輸出:
### Optimization: Reduce Array Iterations
**Current**: O(n²) nested loops
**Issue**: Iterating twice over same data
**Recommendation**: Use Map for O(n) lookup
**Impact**: 100x faster for large datasets
...
```

#### 4. documentation-agent
**用途**: 文件生成和維護

**功能**:
- 生成 README, API 文檔
- 函數註解生成
- 架構文檔
- 使用範例

**使用範例**:
```bash
"為這個 API 生成文檔"

# 輸出:
## User Authentication API

### POST /api/auth/login
Authenticates user and returns JWT token

**Parameters**:
| Name | Type | Required | Description |
|------|------|----------|-------------|
| email | string | Yes | User email |
| password | string | Yes | User password |
...
```

---

## Hooks

### 已配置的 Hooks

#### PreToolUse Hooks

**1. 自動格式化** (TypeScript)
- **觸發**: 編輯 .ts, .tsx 檔案前
- **動作**: 執行 Prettier 格式化
- **腳本**: `.claude/hooks/prettier-format.sh`

**2. 安全檢查**
- **觸發**: 編輯任何檔案前
- **動作**: 阻止修改敏感文件 (.env, credentials.json 等)
- **腳本**: `.claude/hooks/security-check.sh`

```bash
# 範例輸出
❌ BLOCKED: Attempting to modify sensitive file: .env
This file contains sensitive information and should not be modified by AI.
```

#### PostToolUse Hooks

**3. 自動 Lint** (TypeScript)
- **觸發**: 編輯 .ts, .tsx 檔案後
- **動作**: 執行 ESLint 檢查
- **腳本**: `.claude/hooks/eslint-check.sh`

```bash
# 範例輸出
⚠️  ESLint issues found in src/app.ts
Run /lint-fix to automatically fix issues
```

#### SessionStart Hooks

**4. 環境初始化**
- **觸發**: Claude Code 啟動時
- **動作**: 顯示專案資訊、Git 狀態、語言版本
- **腳本**: `.claude/hooks/session-init.sh`

```bash
# 範例輸出
🚀 Starting Claude Code session
📁 Project: my-awesome-project
🌿 Branch: feature/new-feature
  - Node version: v20.10.0
✅ Claude Code configuration found
✨ Session ready!
```

### 自訂 Hooks

編輯 `.claude/config.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "command": ".claude/hooks/my-custom-hook.sh"
      }
    ]
  }
}
```

建立 hook 腳本:

```bash
#!/bin/bash
set -euo pipefail

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // ""')

# 你的邏輯
echo "Processing $file_path"

exit 0
```

---

## SDD 工作流程

### 完整流程

```bash
# 1. 初始化規格
/kiro:spec-init "用戶認證系統"

# 2. 生成需求文檔 (需要人工審核)
/kiro:spec-requirements auth-system

# 審核需求後批准

# 3. 生成設計文檔
/kiro:spec-design auth-system

# 或自動批准: /kiro:spec-design auth-system -y

# 4. 拆解任務
/kiro:spec-tasks auth-system -y

# 輸出:
# 1.1 建立 User 模型
# 1.2 實作密碼雜湊
# 1.3 建立 login API
# ...

# 5. 逐步實作
/kiro:spec-impl auth-system 1.1,1.2

# 完成後繼續
/kiro:spec-impl auth-system 1.3,1.4
```

### 最佳實踐

1. **小步迭代** - 每次實作 1-2 個任務
2. **每階段審核** - Requirements, Design, Tasks 都要審核
3. **保持 Diff < 200 行** - 易於審核和測試
4. **文檔先於程式碼** - 不要跳過前面的步驟

詳見 [SDD 工作流程指南](guides/sdd-workflow.md)

---

## CLAUDE.md Memory

### 階層結構

1. **企業級** (`~/.claude-org/CLAUDE.md`) - 組織通用規範
2. **用戶級** (`~/.claude/CLAUDE.md`) - 個人偏好
3. **專案級** (`.claude/CLAUDE.md`) - 專案特定規範 (團隊共享)
4. **本地級** (`CLAUDE.local.md`) - 個人專案偏好 (gitignore)

### 專案 CLAUDE.md 範例

```markdown
# 專案記憶

## 工具指令
- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint -- --fix`

## 程式碼風格
- 2 spaces 縮排
- 使用 async/await
- Prefer const over let

## 專案架構
- 狀態管理: Zustand (src/stores)
- API: src/api
- 元件: src/components

## SDD 工作流程
- 使用 /kiro:* 指令
- 小步迭代 (< 200 行 diff)
- 每個功能都要測試

## Modern CLI Tools
@steering.md
```

### 使用 Import

```markdown
# 引用其他檔案
@steering.md                           # 相對路徑
@~/.claude/my-preferences.md          # 用戶目錄
@../../docs/coding-standards.md       # 相對路徑
```

---

## MCP Servers

### 推薦安裝

#### 基礎組合

```bash
# Filesystem - 檔案系統訪問
claude mcp add --transport stdio filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem .

# Git - Git 操作增強
claude mcp add --transport stdio git -- \
  npx -y @modelcontextprotocol/server-git
```

#### 全端開發組合

```bash
# 基礎組合 +

# PostgreSQL - 資料庫
claude mcp add --transport stdio postgres -- \
  npx -y @executeautomation/database-server

# GitHub - 協作
claude mcp add --transport stdio github -- \
  npx -y @modelcontextprotocol/server-github
```

### 使用 MCP

MCP servers 會自動在需要時被 Claude 使用。

**範例**:
```bash
# Claude 會自動使用 Git MCP
"分析最近 10 個 commits 的變更模式"

# Claude 會自動使用 PostgreSQL MCP
"檢查資料庫 schema 並建議優化"

# Claude 會自動使用 GitHub MCP
"審查 PR #123 的程式碼變更"
```

詳見 [MCP 完整指南](guides/mcp-guide.md) 和 [MCP 推薦清單](MCP_RECOMMENDATIONS.md)

---

## Modern CLI Tools

### 工具對照表

| 功能 | 傳統工具 | Modern 工具 | 使用方式 |
|------|---------|------------|---------|
| 搜尋 | `grep` | `rg` (ripgrep) | `rg "pattern"` |
| 找檔案 | `find` | `fd` | `fd "filename"` |
| 檢視 | `cat` | `bat` | `bat file.ts` |
| 列表 | `ls` | `eza` | `eza -la --icons` |
| 磁碟 | `du` | `dust` | `dust` |

### 常用指令

```bash
# 搜尋程式碼
rg "useState" src/

# 找 TypeScript 檔案
fd -e ts -e tsx

# 檢視檔案 (有語法高亮)
bat src/app.ts

# 美觀的目錄列表
eza -la --icons --git

# 快速檢查磁碟用量
dust -d 2
```

詳見 [steering.md](../steering.md) 完整指南

---

## 最佳實踐

### 1. 使用 SDD 開發新功能

```bash
# ✅ 好的方式
/kiro:spec-init "新功能"
/kiro:spec-requirements feature-id
/kiro:spec-design feature-id
/kiro:spec-tasks feature-id -y
/kiro:spec-impl feature-id 1.1

# ❌ 避免
"幫我實作新功能" # 直接跳到實作
```

### 2. 定期更新 CLAUDE.md

```markdown
# 當專案架構變更時,更新 CLAUDE.md
## 新架構
- 改用 TanStack Query 取代 Redux
- API 路徑改為 /api/v2/
```

### 3. 善用 Subagents

```bash
# 讓專業的 agent 處理專業的事
"使用 code-reviewer 審查這段程式碼"
"使用 security-scanner 檢查漏洞"
"使用 performance-optimizer 優化效能"
```

### 4. 小步迭代

```bash
# ✅ 好的方式
/kiro:spec-impl feature 1.1  # 一次一個任務
# 測試、審核
/kiro:spec-impl feature 1.2  # 下一個

# ❌ 避免
/kiro:spec-impl feature 1.1,1.2,1.3,2.1,2.2  # 太多
```

### 5. 團隊共享配置

```bash
# 提交 .claude/ 到版本控制
git add .claude/
git commit -m "Add Claude Code configuration"
git push
```

---

## 疑難排除

### 問題 1: 語言檢測錯誤

**症狀**: 腳本檢測到錯誤的語言

**解決**:
```bash
bash ~/claude-templates/scripts/init-project.sh

# 當提示時手動輸入正確的語言
Language: python
```

### 問題 2: Hooks 沒有執行

**檢查清單**:

1. **執行權限**
```bash
chmod +x .claude/hooks/*.sh
```

2. **腳本語法**
```bash
# 測試 hook 腳本
echo '{"tool_input":{"file_path":"test.ts"}}' | .claude/hooks/prettier-format.sh
```

3. **路徑正確**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "command": ".claude/hooks/my-hook.sh"  // 確認路徑正確
      }
    ]
  }
}
```

### 問題 3: 指令沒有出現

**檢查清單**:

1. **檔案位置**
```bash
ls .claude/commands/
# 確認指令檔案存在
```

2. **檔案格式**
```bash
# 必須是 .md 檔案
# 必須有正確的 frontmatter
```

3. **重啟 Claude Code**
```bash
# 有時需要重新載入
exit  # 退出 Claude
claude  # 重新啟動
```

### 問題 4: MCP Server 連接失敗

**檢查清單**:

1. **MCP Server 已安裝**
```bash
npx -y @modelcontextprotocol/server-filesystem --version
```

2. **查看錯誤訊息**
```bash
# Claude Code 會顯示 MCP 錯誤
```

3. **檢查環境變數**
```bash
echo $GITHUB_TOKEN
echo $DATABASE_URL
```

### 問題 5: SDD 指令不存在

**解決**:
```bash
# 安裝 SDD 工具
npx cc-sdd@latest

# 驗證安裝
claude
/kiro:spec-init "test"
```

---

## 更多資源

### 官方文檔
- [Claude Code 文檔](https://docs.claude.com/en/docs/claude-code)
- [MCP 官方網站](https://modelcontextprotocol.io/)
- [cc-sdd GitHub](https://github.com/gotalab/cc-sdd)

### 本專案文檔
- [README.md](../README.md) - 專案首頁
- [QUICK_START.md](QUICK_START.md) - 快速開始
- [FAQ.md](FAQ.md) - 常見問題
- [SDD 工作流程](guides/sdd-workflow.md) - SDD 詳細教學
- [Hooks 指南](guides/hooks-guide.md) - Hooks 使用
- [MCP 指南](guides/mcp-guide.md) - MCP 完整教學
- [MCP 推薦](MCP_RECOMMENDATIONS.md) - MCP servers 選擇

### 社群資源
- [GitHub Issues](https://github.com/Casear/claude-code-setting/issues)
- [Discussions](https://github.com/Casear/claude-code-setting/discussions)
- [Awesome MCP Servers](https://github.com/wong2/awesome-mcp-servers)

---

## 支援

遇到問題?

1. 查看 [FAQ](FAQ.md)
2. 搜尋 [GitHub Issues](https://github.com/Casear/claude-code-setting/issues)
3. 開啟新 Issue
4. 在 [Discussions](https://github.com/Casear/claude-code-setting/discussions) 提問

---

**祝你使用愉快! 🚀**
