# 🔌 MCP (Model Context Protocol) 完整指南

## 什麼是 MCP?

Model Context Protocol (MCP) 是一個開放標準,讓 Claude Code 能連接外部工具和服務。

### 核心概念

MCP Server = 連接 Claude 與外部系統的橋樑

```
Claude Code <---> MCP Server <---> External Service
               (GitHub, DB, APIs)
```

## 推薦的 MCP Servers

### 🎯 必裝 (Essential)

#### 1. Filesystem Server
**用途**: 安全的檔案系統訪問

**安裝**:
```bash
claude mcp add --transport stdio filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem /path/to/allowed/directory
```

**功能**:
- 讀取/寫入檔案 (在允許的目錄內)
- 列出目錄內容
- 搜尋檔案
- 創建/刪除檔案

**使用場景**:
- 大型專案檔案管理
- 批次檔案處理
- 安全的檔案訪問控制

---

#### 2. Git Server
**用途**: Git 操作增強

**安裝**:
```bash
claude mcp add --transport stdio git -- \
  npx -y @modelcontextprotocol/server-git
```

**功能**:
- 讀取 commit 歷史
- 檢查 diff
- 搜尋 Git 歷史
- 分析 repository

**使用場景**:
- 深入分析 Git 歷史
- Code review 輔助
- 找出程式碼變更原因

---

### 💾 資料庫工具

#### 3. PostgreSQL/Neon Server
**用途**: PostgreSQL 資料庫查詢和管理

**安裝**:
```bash
# Community PostgreSQL MCP
npm install -g @executeautomation/database-server

claude mcp add --transport stdio postgres -- \
  npx -y @executeautomation/database-server
```

**功能**:
- Schema 檢查
- SQL 查詢執行
- 資料庫分析
- Migration 輔助

**使用場景**:
- 資料庫 schema 設計
- 查詢優化
- 資料分析

**配置範例**:
```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@executeautomation/database-server"],
      "env": {
        "DATABASE_URL": "postgresql://user:pass@localhost:5432/db"
      }
    }
  }
}
```

---

#### 4. SQLite Server
**用途**: SQLite 資料庫操作

**安裝**:
```bash
claude mcp add --transport stdio sqlite -- \
  npx -y @modelcontextprotocol/server-sqlite --db-path /path/to/database.db
```

**功能**:
- 本地資料庫查詢
- Schema 管理
- 資料導入/導出

**使用場景**:
- 開發環境資料庫
- 測試資料管理
- 小型應用資料庫

---

### 🛠️ 開發工具

#### 5. GitHub Server (官方)
**用途**: GitHub 整合

**安裝**:
```bash
claude mcp add --transport stdio github -- \
  npx -y @modelcontextprotocol/server-github
```

**功能**:
- 讀取 repositories
- 管理 issues 和 PRs
- 搜尋程式碼
- 分析 commit 歷史

**使用場景**:
- PR 審查自動化
- Issue 管理
- Repository 分析
- 團隊協作

**需要**: GitHub Personal Access Token

---

#### 6. Playwright Server
**用途**: 瀏覽器自動化測試

**安裝**:
```bash
npm install -g @executeautomation/playwright-mcp

claude mcp add --transport stdio playwright -- \
  npx -y @executeautomation/playwright-mcp
```

**功能**:
- E2E 測試生成
- 網頁互動自動化
- 截圖和錄影
- 跨瀏覽器測試

**使用場景**:
- 自動化測試開發
- Web scraping
- UI 測試

---

#### 7. Semgrep Server
**用途**: 程式碼安全掃描

**安裝**:
```bash
claude mcp add --transport stdio semgrep -- \
  npx -y @semgrep/mcp-server
```

**功能**:
- 靜態程式碼分析
- 安全漏洞檢測
- 程式碼品質檢查
- 自訂規則

**使用場景**:
- 安全審查
- Code review
- CI/CD 整合

---

### 🌐 API 與資料

#### 8. Tavily Search Server
**用途**: AI 專用搜尋引擎

**安裝**:
```bash
npm install -g @tavily/mcp-server

claude mcp add --transport stdio tavily -- \
  npx -y @tavily/mcp-server
```

**功能**:
- Web 搜尋
- 內容提取
- 即時資訊獲取

**使用場景**:
- 研究輔助
- 最新資訊查詢
- 文檔生成

**需要**: Tavily API Key

---

#### 9. Perplexity Server
**用途**: 即時 Web 研究

**安裝**:
```bash
npm install -g @perplexity/mcp-server

claude mcp add --transport stdio perplexity -- \
  npx -y @perplexity/mcp-server
```

**功能**:
- 深度網路搜尋
- 引用來源
- 即時資訊

**使用場景**:
- 技術研究
- 市場調查
- 競品分析

**需要**: Perplexity API Key

---

### 📊 生產力工具

#### 10. Notion Server (官方)
**用途**: Notion 工作區整合

**安裝**:
```bash
claude mcp add --transport http notion https://mcp.notion.com/mcp
```

**功能**:
- 讀取/寫入 Notion pages
- 資料庫查詢
- 內容管理
- 文檔生成

**使用場景**:
- 文檔自動化
- 知識庫管理
- 專案管理

**需要**: Notion Integration Token

---

#### 11. Slack Server
**用途**: Slack 整合

**安裝**:
```bash
npm install -g @slack/mcp-server

claude mcp add --transport stdio slack -- \
  npx -y @slack/mcp-server
```

**功能**:
- 發送訊息
- 讀取頻道
- 通知管理

**使用場景**:
- 團隊通知
- CI/CD 整合
- 警報系統

---

### 💼 企業工具

#### 12. AWS Services
**用途**: AWS 資源管理

**安裝**:
```bash
# AWS KB (Knowledge Base)
claude mcp add --transport stdio aws-kb -- \
  npx -y @modelcontextprotocol/server-aws-kb

# AWS Documentation
npm install -g @aws/mcp-server
```

**功能**:
- CloudFormation 管理
- Bedrock KB 查詢
- 成本分析
- 文檔查詢

**使用場景**:
- 基礎設施即程式碼
- 雲端資源管理
- 成本優化

---

#### 13. Stripe Server
**用途**: 支付處理

**安裝**:
```bash
npm install -g @stripe/mcp-server

claude mcp add --transport stdio stripe -- \
  npx -y @stripe/mcp-server
```

**功能**:
- 支付流程管理
- 訂閱管理
- 發票處理
- 財務報表

**使用場景**:
- 電商開發
- 訂閱服務
- 財務自動化

---

## 💡 推薦安裝組合

### 基礎開發組合
```bash
# 檔案系統
claude mcp add --transport stdio filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem .

# Git
claude mcp add --transport stdio git -- \
  npx -y @modelcontextprotocol/server-git
```

### 全端開發組合
```bash
# 基礎
filesystem + git

# 資料庫
claude mcp add --transport stdio postgres -- \
  npx -y @executeautomation/database-server

# GitHub
claude mcp add --transport stdio github -- \
  npx -y @modelcontextprotocol/server-github
```

### 企業開發組合
```bash
# 基礎 + 全端開發

# 測試
claude mcp add --transport stdio playwright -- \
  npx -y @executeautomation/playwright-mcp

# 安全
claude mcp add --transport stdio semgrep -- \
  npx -y @semgrep/mcp-server

# 協作
claude mcp add --transport http notion https://mcp.notion.com/mcp
```

---

## 📝 配置管理

### 查看已安裝的 MCP Servers

```bash
# 在 Claude Code 中
/mcp

# 或查看配置文件
cat ~/.claude/mcp-servers.json
```

### 專案級 MCP 配置

建立 `.mcp.json` 在專案根目錄:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "."],
      "disabled": false
    },
    "postgres": {
      "command": "npx",
      "args": ["-y", "@executeautomation/database-server"],
      "env": {
        "DATABASE_URL": "postgresql://localhost:5432/mydb"
      }
    }
  }
}
```

### 環境變數管理

建立 `.env.mcp` (不要 commit!):

```bash
# GitHub
GITHUB_TOKEN=ghp_xxxxx

# Database
DATABASE_URL=postgresql://user:pass@localhost:5432/db

# API Keys
TAVILY_API_KEY=tvly-xxxxx
PERPLEXITY_API_KEY=pplx-xxxxx
NOTION_TOKEN=secret_xxxxx
```

在 MCP 配置中引用:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

---

## 🎯 使用場景範例

### 場景 1: 資料庫 Schema 設計

```bash
# 安裝 PostgreSQL MCP
claude mcp add --transport stdio postgres -- \
  npx -y @executeautomation/database-server

# 在 Claude Code 中
"設計一個用戶認證系統的資料庫 schema"
# Claude 會:
# 1. 檢查現有 schema
# 2. 設計新 tables
# 3. 生成 migration SQL
# 4. 驗證 foreign keys
```

### 場景 2: GitHub PR 審查

```bash
# 安裝 GitHub MCP
claude mcp add --transport stdio github -- \
  npx -y @modelcontextprotocol/server-github

# 在 Claude Code 中
"審查 PR #123 的程式碼變更"
# Claude 會:
# 1. 讀取 PR diff
# 2. 分析程式碼品質
# 3. 檢查安全問題
# 4. 提供改進建議
```

### 場景 3: E2E 測試生成

```bash
# 安裝 Playwright MCP
claude mcp add --transport stdio playwright -- \
  npx -y @executeautomation/playwright-mcp

# 在 Claude Code 中
"生成登入流程的 E2E 測試"
# Claude 會:
# 1. 分析登入頁面
# 2. 生成測試腳本
# 3. 包含各種測試案例
# 4. 處理錯誤情況
```

---

## 🔒 安全最佳實踐

### 1. 最小權限原則

```bash
# ✅ 好: 只允許特定目錄
claude mcp add --transport stdio filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem ./src

# ❌ 壞: 允許整個系統
claude mcp add --transport stdio filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem /
```

### 2. 環境變數保護

```bash
# ✅ 使用環境變數
export GITHUB_TOKEN=ghp_xxxxx

# ❌ 不要硬編碼在配置中
# "env": { "GITHUB_TOKEN": "ghp_xxxxx" }  // 危險!
```

### 3. 只安裝必要的 MCP Servers

```bash
# 定期審查已安裝的 servers
/mcp

# 移除不需要的
claude mcp remove server-name
```

---

## 🐛 疑難排除

### MCP Server 無法啟動

**檢查 1**: 驗證安裝
```bash
npx -y @modelcontextprotocol/server-filesystem --version
```

**檢查 2**: 查看 logs
```bash
# Claude Code 會顯示錯誤訊息
```

**檢查 3**: 權限問題
```bash
# 確保有執行權限
chmod +x /path/to/mcp-server
```

### MCP Server 連接逾時

**解決**: 增加 timeout 設定
```json
{
  "mcpServers": {
    "myserver": {
      "timeout": 60000  // 60 秒
    }
  }
}
```

### API Key 錯誤

**檢查**:
```bash
# 驗證環境變數
echo $GITHUB_TOKEN
echo $TAVILY_API_KEY

# 確保在 MCP 配置中正確引用
```

---

## 📚 更多資源

### 官方資源
- [MCP 官方文檔](https://modelcontextprotocol.io/)
- [MCP GitHub](https://github.com/modelcontextprotocol/servers)
- [Claude Code MCP 指南](https://docs.claude.com/en/docs/claude-code/mcp)

### 社群資源
- [Awesome MCP Servers](https://github.com/wong2/awesome-mcp-servers)
- [MCP Servers 目錄](https://mcpservers.org/)
- [MCP Discord](https://discord.gg/mcp)

### 開發自己的 MCP Server
- [MCP SDK](https://github.com/modelcontextprotocol/sdk)
- [範例 Servers](https://github.com/modelcontextprotocol/servers/tree/main/src)

---

## 🎉 開始使用

1. **選擇適合你的 MCP Servers**
   - 基礎: filesystem + git
   - 開發: + database + github
   - 企業: + playwright + semgrep

2. **安裝並配置**
   ```bash
   claude mcp add ...
   ```

3. **測試運作**
   ```bash
   claude
   /mcp  # 查看已安裝的 servers
   ```

4. **開始使用!**
   Claude Code 會自動在需要時使用 MCP servers

---

**下一步**: 選擇 2-3 個與你工作最相關的 MCP servers 開始使用!
