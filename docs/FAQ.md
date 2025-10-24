# ❓ 常見問題 FAQ

## 安裝相關

### Q: 如何更新現有專案的配置?

**A**: 使用更新腳本:
```bash
cd your-project
bash ~/claude-code-templates/scripts/init-project.sh
```
腳本會覆蓋舊配置,建議先備份自訂內容。

### Q: 支援 monorepo 嗎?

**A**: 是的! Monorepo 有兩種方式:

**方式 1: 每個子專案獨立配置**
```
monorepo/
├── frontend/
│   └── .claude/  # TypeScript 配置
├── backend/
│   └── .claude/  # Python 配置
└── mobile/
    └── .claude/  # TypeScript 配置
```

**方式 2: 共享根配置**
```
monorepo/
├── .claude/      # 共享配置
│   └── CLAUDE.md # 引用子專案特定設定
├── frontend/
├── backend/
└── mobile/
```

### Q: 可以混用多種語言嗎?

**A**: 可以! 如果一個專案包含多種語言:

```bash
# 先初始化主要語言
bash ~/claude-code-templates/scripts/init-project.sh

# 手動複製其他語言的配置
cp -r ~/claude-code-templates/languages/python/commands/dev .claude/commands/python-dev
```

### Q: 如何在團隊中共享配置?

**A**: 提交 `.claude/` 目錄到版本控制:

```bash
git add .claude/
git commit -m "Add Claude Code configuration"
git push
```

團隊成員 pull 後即可使用相同配置。

---

## 使用相關

### Q: Hooks 沒有執行怎麼辦?

**A**: 檢查以下項目:

1. **執行權限**
```bash
chmod +x .claude/hooks/*.sh
```

2. **腳本路徑** - 確認 `config.json` 中的路徑正確
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "command": ".claude/hooks/my-hook.sh"  # 相對路徑或絕對路徑
      }
    ]
  }
}
```

3. **腳本錯誤** - 測試腳本是否能單獨執行
```bash
echo '{}' | .claude/hooks/my-hook.sh
```

4. **查看 Claude Code 輸出** - 錯誤訊息會顯示在輸出中

### Q: 自訂指令沒有出現?

**A**: 確認以下事項:

1. **檔案位置** - 必須在 `.claude/commands/` 下
2. **檔案格式** - 必須是 `.md` 格式
3. **語法正確** - 檢查 frontmatter 格式

```markdown
---
description: My command description
---

Command content here
```

4. **重啟 Claude Code** - 有時需要重新載入
5. **執行 `/help`** - 查看是否出現在列表中

### Q: 如何停用某個 Hook?

**A**: 編輯 `.claude/config.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      // 方式 1: 註解掉 (JSON 不支援註解,需移除)
      // {
      //   "matcher": "Edit|Write",
      //   "command": ".claude/hooks/unwanted-hook.sh"
      // },

      // 方式 2: 直接刪除該項目
      {
        "matcher": "Edit|Write",
        "command": ".claude/hooks/wanted-hook.sh"
      }
    ]
  }
}
```

### Q: SDD 工作流程是必須的嗎?

**A**: 不是必須的,但強烈建議:

- **小專案/快速原型**: 可以不用 SDD,直接使用 Claude Code
- **大型專案/團隊協作**: 建議使用 SDD 確保架構一致性
- **生產級代碼**: SDD 幫助減少返工和架構漂移

可以隨時開始使用: `npx cc-sdd@latest`

---

## 語言相關

### Q: 我的語言不在 7 種支援列表中怎麼辦?

**A**: 仍然可以使用核心功能:

1. **使用通用配置**
```bash
bash ~/claude-code-templates/scripts/init-project.sh
# 選擇 "unknown" 或按 Ctrl+C 跳過檢測
```

2. **自訂 CLAUDE.md**
```markdown
# 在 .claude/CLAUDE.md 中添加你的語言設定
## Build Commands
- Build: your-build-command
- Test: your-test-command
```

3. **貢獻新語言支援** - 歡迎提交 PR 新增語言!

### Q: TypeScript 和 JavaScript 有什麼區別?

**A**:
- 如果 `package.json` 包含 `typescript` → 使用 TypeScript 配置
- 否則 → 使用 JavaScript 配置 (基本相同,但沒有 type checking)

手動指定:
```bash
# .claude/CLAUDE.md
## Type Checking
- Use TypeScript: Yes / No
```

---

## MCP 相關

### Q: MCP servers 是什麼?

**A**: Model Context Protocol servers 讓 Claude Code 連接外部工具:

- **Filesystem**: 安全的檔案系統訪問
- **Git**: Git 操作增強
- **Database**: 資料庫查詢和操作
- **Notion/Jira**: 專案管理整合

詳見 [MCP 指南](guides/mcp-guide.md)

### Q: MCP servers 是必須的嗎?

**A**: 不是必須的。核心 Claude Code 功能不需要 MCP。

建議安裝:
- **Filesystem server** - 更安全的檔案操作
- **Git server** - 增強的 Git 功能

### Q: 如何安裝 MCP server?

**A**:
```bash
# Filesystem
claude mcp add --transport stdio filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem .

# Git
claude mcp add --transport stdio git -- \
  npx -y @modelcontextprotocol/server-git
```

---

## 疑難排除

### Q: 語言檢測錯誤怎麼辦?

**A**: 手動指定語言:

```bash
bash ~/claude-code-templates/scripts/init-project.sh

# 當提示 "Could not auto-detect project language" 時
# 輸入: typescript, python, go, rust, java, elixir, erlang
```

或編輯腳本暫時強制檢測:
```bash
# 在 init-project.sh 中
DETECTED_LANG="python"  # 強制使用 Python
```

### Q: 如何完全移除配置?

**A**:
```bash
# 刪除 .claude 目錄
rm -rf .claude/

# 刪除 .claudeignore
rm .claudeignore

# 刪除 CLAUDE.local.md (如果有)
rm CLAUDE.local.md

# 刪除 steering.md (如果有)
rm steering.md
```

### Q: Hooks 執行太慢怎麼辦?

**A**: 優化 hook 腳本:

1. **減少操作** - 只處理必要的文件
```bash
# Bad: 處理所有文件
prettier --write "**/*.ts"

# Good: 只處理當前文件
prettier --write "$file_path"
```

2. **使用條件判斷** - 跳過不需要的情況
```bash
if echo "$file_path" | grep -qE '\.(ts|tsx)$'; then
  # 只處理 TS 文件
fi
```

3. **並行執行** - 使用 `&` 背景執行
```bash
my-slow-command &  # 不等待完成
```

### Q: 記憶體佔用太大?

**A**: 優化 `.claudeignore`:

```bash
# 排除大型目錄
node_modules/
dist/
build/
.git/

# 排除大型文件
*.log
*.db
*.sqlite
```

---

## 進階使用

### Q: 如何建立自己的 Subagent?

**A**:
1. 建立檔案 `.claude/agents/my-agent.md`
2. 使用 frontmatter 配置
3. 撰寫系統提示

範例見 [Subagents 指南](guides/subagents-guide.md)

### Q: 如何自訂 Hook 返回值?

**A**: 使用 exit code 控制行為:

```bash
# Exit 0: 成功,繼續執行
exit 0

# Exit 2: 阻止操作,錯誤訊息給 Claude
echo "Blocked!" >&2
exit 2

# 其他: 非阻止性錯誤,訊息給用戶
echo "Warning" >&2
exit 1
```

### Q: 可以整合 CI/CD 嗎?

**A**: 可以! 範例 GitHub Actions:

```yaml
# .github/workflows/claude-lint.yml
name: Claude Code Checks

on: [push, pull_request]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run Claude Code lint
        run: |
          # 使用 hooks 中的 lint 腳本
          bash .claude/hooks/eslint-check.sh
```

---

## 更多幫助

- [完整使用手冊](USER_GUIDE.md)
- [故障排除指南](TROUBLESHOOTING.md)
- [GitHub Issues](https://github.com/your-org/claude-code-templates/issues)
- [Discussions](https://github.com/your-org/claude-code-templates/discussions)
