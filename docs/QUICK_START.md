# 🚀 快速開始指南

在 5 分鐘內設定好 Claude Code Templates!

## 前置需求

### 必要
- ✅ Claude Code 已安裝
- ✅ Git
- ✅ Bash shell

### 建議 (會自動安裝)
- Node.js (用於 SDD 工具)
- Modern CLI 工具 (ripgrep, fd, bat 等)

## 步驟 1: 安裝現代化 CLI 工具 (2 分鐘)

### macOS
```bash
brew install ripgrep fd bat eza dust zoxide delta tokei lazygit
```

### Ubuntu/Debian
```bash
sudo apt update
sudo apt install ripgrep fd-find bat
cargo install eza dust
```

### 驗證安裝
```bash
rg --version
fd --version
bat --version
```

## 步驟 2: Clone 模板庫 (30 秒)

```bash
# Clone 到你喜歡的位置
git clone https://github.com/your-org/claude-code-templates.git ~/claude-code-templates

# 或使用 SSH
git clone git@github.com:your-org/claude-code-templates.git ~/claude-code-templates
```

## 步驟 3: 初始化你的專案 (1 分鐘)

```bash
# 進入你的專案目錄
cd /path/to/your/project

# 執行智慧初始化
bash ~/claude-code-templates/scripts/init-project.sh

# 腳本會自動:
# 1. 檢測專案語言
# 2. 創建 .claude/ 目錄
# 3. 安裝核心配置
# 4. 套用語言特定配置
# 5. 設定 hooks
```

### 你會看到:
```
🚀 Claude Code Smart Initialization

📊 Detection Results:
  Target directory: /path/to/your/project
  Detected language: typescript

📁 Creating .claude directory...
🔧 Installing core configuration...
🎯 Applying typescript-specific configuration...

✅ Configuration installed successfully!

📋 What's next:
  1. Review .claude/CLAUDE.md and customize for your project
  2. Install SDD tools: npx cc-sdd@latest
  3. Install modern CLI tools: bash setup-tool.sh
  4. Start Claude Code: claude
```

## 步驟 4: 安裝 SDD 工具 (30 秒)

```bash
# 在專案目錄中
npx cc-sdd@latest

# 這會安裝 Kiro SDD 工作流程指令:
# /kiro:spec-init
# /kiro:spec-requirements
# /kiro:spec-design
# /kiro:spec-tasks
# /kiro:spec-impl
```

## 步驟 5: 啟動 Claude Code (立即開始!)

```bash
claude

# 或在特定目錄
claude /path/to/your/project
```

## 驗證安裝

### 檢查配置
```bash
# 確認 .claude 目錄存在
ls -la .claude/

# 應該看到:
# .claude/
# ├── agents/
# ├── commands/
# ├── config.json
# ├── CLAUDE.md
# └── hooks/
```

### 測試指令

在 Claude Code 中:

```bash
# 查看可用指令
/help

# 測試分析指令
/analyze-deps

# 測試 SDD 工作流程
/kiro:spec-init "測試功能"
```

## 🎯 下一步

### 必做
1. ✅ 查看並自訂 `.claude/CLAUDE.md` (專案記憶)
2. ✅ 閱讀 [完整使用手冊](USER_GUIDE.md)
3. ✅ 了解 [SDD 工作流程](guides/sdd-workflow.md)

### 選做
- 設定 MCP servers - [MCP 指南](guides/mcp-guide.md)
- 自訂 hooks - [Hooks 指南](guides/hooks-guide.md)
- 建立自己的指令 - [自訂指令](guides/custom-commands.md)

## 🔧 疑難排除

### 問題: 語言檢測錯誤

**解決**: 手動指定語言
```bash
bash ~/claude-code-templates/scripts/init-project.sh
# 當提示時輸入: typescript, python, go, rust, java, elixir, erlang
```

### 問題: Hooks 沒有執行

**解決**: 確認執行權限
```bash
chmod +x .claude/hooks/*.sh
```

### 問題: 指令沒有出現

**解決**:
1. 確認檔案在 `.claude/commands/` 下
2. 重啟 Claude Code
3. 執行 `/help` 查看可用指令

## 💡 快速提示

### 常用指令
```bash
/lint-fix        # 修復 lint 錯誤
/test-all        # 執行所有測試
/analyze-deps    # 分析依賴
/gen-readme      # 生成 README
```

### SDD 工作流程
```bash
/kiro:spec-init "功能名稱"
/kiro:spec-requirements feature-id
/kiro:spec-design feature-id
/kiro:spec-tasks feature-id -y
/kiro:spec-impl feature-id 1.1,1.2
```

### Modern CLI 使用
```bash
# 搜尋程式碼
rg "pattern"

# 找檔案
fd "filename"

# 檢視檔案
bat file.ts

# 列出目錄
eza -la --icons --git
```

## 📚 學習資源

- [完整使用手冊](USER_GUIDE.md) - 詳細功能說明
- [語言專屬指南](language-specific/) - 針對你的語言優化
- [範例專案](../examples/) - 實際使用範例
- [最佳實踐](reference/best-practices.md) - 專家建議

---

**準備好了嗎?** 開始使用 `claude` 命令,體驗生產級 AI 輔助開發! 🚀
