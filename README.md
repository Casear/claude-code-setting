# Claude Code Templates - 多語言優化配置庫

> 🚀 一次設定,到處使用的 Claude Code 生產級配置模板

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🎯 特色功能

- ✅ **智慧語言檢測** - 自動識別專案類型並套用對應配置
- ✅ **8 種語言支援** - TypeScript, JavaScript, Python, Go, Rust, Java, Elixir, Erlang
- ✅ **SDD 工作流程** - 內建 Spec-Driven Development 最佳實踐
- ✅ **Modern CLI 工具** - 預設使用 ripgrep, fd, bat, eza, dust
- ✅ **Custom Hooks** - 自動格式化、Lint、安全檢查
- ✅ **Custom Subagents** - Code review, Security scan, Performance optimization
- ✅ **MCP 整合** - 預配置常用 MCP servers
- ✅ **團隊協作** - 統一的開發體驗和最佳實踐

## 🚀 快速開始

### 3 分鐘設定

```bash
# 1. Clone 本 repo
git clone https://github.com/your-org/claude-code-templates.git

# 2. 進入你的專案目錄
cd /path/to/your-project

# 3. 執行智慧初始化
bash /path/to/claude-code-templates/scripts/init-project.sh

# 完成! 🎉
```

### 安裝後

```bash
# 安裝現代 CLI 工具
bash /path/to/claude-code-templates/setup-tool.sh

# 安裝 SDD 工具
npx cc-sdd@latest

# 啟動 Claude Code
claude
```

## 📁 專案結構

```
claude-code-templates/
├── core/                   # 通用核心配置 (語言無關)
│   ├── agents/            # 4 個通用 subagents
│   ├── commands/          # 通用指令
│   ├── hooks/             # 通用 hooks
│   └── CLAUDE.md.template
├── languages/             # 7 種語言特定配置
│   ├── typescript/
│   ├── python/
│   ├── go/
│   ├── rust/
│   ├── java/
│   ├── elixir/
│   └── erlang/
├── scripts/               # 智慧初始化腳本
├── docs/                  # 完整文檔
└── examples/              # 範例專案
```

## 📚 文檔

### 快速入門
- [📖 快速開始指南](docs/QUICK_START.md) - 5 分鐘上手
- [💿 安裝指南](docs/INSTALLATION.md) - 詳細安裝步驟
- [📘 完整使用手冊](docs/USER_GUIDE.md) - 所有功能說明
- [❓ 常見問題 FAQ](docs/FAQ.md) - 疑難解答

### 進階指南
- [🎯 SDD 工作流程](docs/guides/sdd-workflow.md) - Spec-Driven Development
- [🪝 Hooks 完整教學](docs/guides/hooks-guide.md) - 自動化工作流程
- [🔌 MCP 設定指南](docs/guides/mcp-guide.md) - Model Context Protocol 完整教學
- [📋 MCP 推薦清單](docs/MCP_RECOMMENDATIONS.md) - 13+ 個推薦 MCP servers
- [🤖 Subagents 使用](docs/guides/subagents-guide.md) - 專業化 AI agents
- [📝 CLAUDE.md 最佳實踐](docs/guides/claude-memory.md) - 記憶管理

### 語言專屬指南
- [TypeScript](docs/language-specific/typescript.md)
- [JavaScript/Node.js](docs/language-specific/javascript.md)
- [Python](docs/language-specific/python.md)
- [Go](docs/language-specific/go.md)
- [Rust](docs/language-specific/rust.md)
- [Java](docs/language-specific/java.md)
- [Elixir](docs/language-specific/elixir.md)
- [Erlang](docs/language-specific/erlang.md)

## 🎓 功能介紹

### 1. 智慧語言檢測

腳本自動檢測專案類型:
- **TypeScript/JavaScript**: 檢測 `package.json`
- **Python**: 檢測 `pyproject.toml`, `requirements.txt`
- **Go**: 檢測 `go.mod`
- **Rust**: 檢測 `Cargo.toml`
- **Java**: 檢測 `pom.xml`, `build.gradle`
- **Elixir**: 檢測 `mix.exs`
- **Erlang**: 檢測 `rebar.config`

### 2. Custom Commands

每個專案包含實用指令:

```bash
# 開發工作流程
/lint-fix       # 自動修復 lint 錯誤
/test-all       # 執行所有測試
/build-check    # 檢查建置狀態

# 程式碼分析
/analyze-deps       # 分析依賴關係
/analyze-complexity # 檢查程式碼複雜度
/find-duplicates    # 找出重複程式碼

# 重構工具
/refactor-component # 重構元件
/extract-function   # 提取函數

# 文件生成
/gen-readme     # 生成 README
/gen-api-docs   # 生成 API 文檔

# SDD 工作流程
/kiro:spec-init        # 初始化規格
/kiro:spec-requirements # 生成需求
/kiro:spec-design      # 生成設計
/kiro:spec-tasks       # 拆解任務
/kiro:spec-impl        # 執行實作
```

### 3. Custom Subagents

專業化的 AI agents:

- **code-reviewer** - 程式碼審查,檢查品質和最佳實踐
- **security-scanner** - 掃描安全漏洞和敏感資訊
- **performance-optimizer** - 識別效能瓶頸
- **documentation-agent** - 生成和維護文檔

### 4. Hooks 自動化

配置的 hooks:

- **PreToolUse**: 編輯前自動格式化,安全檢查
- **PostToolUse**: 編輯後自動 lint
- **SessionStart**: 初始化環境,顯示專案資訊
- **UserPromptSubmit**: 注入上下文資訊

### 5. Modern CLI Tools

預設使用現代化工具:

| 功能 | 傳統工具 | 現代工具 | 速度提升 |
|------|---------|---------|---------|
| 搜尋 | grep | ripgrep (rg) | 10-100x |
| 找檔案 | find | fd | 10x |
| 檢視 | cat | bat | - |
| 列表 | ls | eza | - |
| 磁碟 | du | dust | - |

詳見 [steering.md](steering.md)

## 🔧 使用範例

### 範例 1: 新 TypeScript 專案

```bash
cd my-typescript-project
bash ~/claude-code-templates/scripts/init-project.sh

# 自動檢測: TypeScript
# 套用: 核心配置 + TypeScript 特定配置
# 包含: ESLint/Prettier hooks, TypeScript type checker agent
```

### 範例 2: Python 專案

```bash
cd my-python-project
bash ~/claude-code-templates/scripts/init-project.sh

# 自動檢測: Python
# 套用: 核心配置 + Python 特定配置
# 包含: Black/Ruff formatting, pytest commands
```

### 範例 3: 使用 SDD 開發新功能

```bash
claude  # 啟動 Claude Code

# 1. 初始化規格
/kiro:spec-init "用戶認證系統"

# 2. 生成需求 (審核後批准)
/kiro:spec-requirements auth-system

# 3. 生成設計
/kiro:spec-design auth-system

# 4. 拆解任務
/kiro:spec-tasks auth-system -y

# 5. 逐步實作
/kiro:spec-impl auth-system 1.1,1.2
```

## 🤝 貢獻

歡迎貢獻!請參考:

1. Fork 本 repo
2. 建立 feature branch (`git checkout -b feature/amazing-feature`)
3. Commit 變更 (`git commit -m 'Add amazing feature'`)
4. Push 到 branch (`git push origin feature/amazing-feature`)
5. 開啟 Pull Request

詳見 [貢獻指南](CONTRIBUTING.md)

## 📄 授權

MIT License - 詳見 [LICENSE](LICENSE)

## 🙏 致謝

- [Claude Code](https://claude.com/claude-code) by Anthropic
- [cc-sdd](https://github.com/gotalab/cc-sdd) for SDD workflow
- Modern CLI tools: ripgrep, fd, bat, eza, dust

## 📞 支援

- [GitHub Issues](https://github.com/your-org/claude-code-templates/issues) - 回報問題
- [Discussions](https://github.com/your-org/claude-code-templates/discussions) - 討論和問題
- [Wiki](https://github.com/your-org/claude-code-templates/wiki) - 社群文檔

---

Made with ❤️ for the Claude Code community
