# 🔌 推薦的 MCP Servers 清單

## 快速選擇指南

根據你的需求選擇合適的 MCP servers:

### 🎯 基礎開發 (必裝)

| MCP Server | 用途 | 優先級 | 安裝命令 |
|-----------|------|--------|---------|
| **Filesystem** | 檔案系統訪問 | ⭐⭐⭐⭐⭐ | `claude mcp add --transport stdio filesystem -- npx -y @modelcontextprotocol/server-filesystem .` |
| **Git** | Git 操作增強 | ⭐⭐⭐⭐⭐ | `claude mcp add --transport stdio git -- npx -y @modelcontextprotocol/server-git` |

---

### 💾 資料庫工具

| MCP Server | 用途 | 適用場景 | 安裝命令 |
|-----------|------|---------|---------|
| **PostgreSQL** | PostgreSQL 管理 | 後端開發、資料分析 | `claude mcp add --transport stdio postgres -- npx -y @executeautomation/database-server` |
| **SQLite** | SQLite 管理 | 本地開發、小型應用 | `claude mcp add --transport stdio sqlite -- npx -y @modelcontextprotocol/server-sqlite` |
| **Neo4j** | 圖資料庫 | 關係分析、推薦系統 | 詳見 [neo4j-mcp](https://github.com/neo4j/mcp-neo4j) |

---

### 🛠️ 開發工具

| MCP Server | 用途 | 適用場景 | 優先級 |
|-----------|------|---------|--------|
| **GitHub** | GitHub 整合 | 團隊協作、PR 審查 | ⭐⭐⭐⭐⭐ |
| **Playwright** | 瀏覽器自動化 | E2E 測試、Web scraping | ⭐⭐⭐⭐ |
| **Semgrep** | 程式碼安全掃描 | 安全審查、Code review | ⭐⭐⭐⭐ |
| **JetBrains** | IDE 整合 | IntelliJ/PyCharm 用戶 | ⭐⭐⭐ |

---

### 🌐 API & 搜尋工具

| MCP Server | 用途 | 適用場景 | 需要 API Key |
|-----------|------|---------|-------------|
| **Tavily** | AI 搜尋引擎 | 研究、資訊查詢 | ✅ |
| **Perplexity** | Web 研究 | 深度研究、引用來源 | ✅ |
| **Exa** | 語義搜尋 | AI 優化搜尋 | ✅ |

---

### 📊 生產力工具

| MCP Server | 用途 | 適用場景 | 優先級 |
|-----------|------|---------|--------|
| **Notion** | Notion 整合 | 文檔管理、知識庫 | ⭐⭐⭐⭐ |
| **Slack** | Slack 整合 | 團隊通訊、通知 | ⭐⭐⭐ |
| **Linear** | 專案管理 | Issue tracking | ⭐⭐⭐ |

---

### 💼 企業/雲端工具

| MCP Server | 用途 | 適用場景 |
|-----------|------|---------|
| **AWS** | AWS 資源管理 | 雲端基礎設施 |
| **Azure** | Azure DevOps | 微軟生態系統 |
| **Stripe** | 支付處理 | 電商、訂閱服務 |
| **Salesforce** | CRM | 客戶關係管理 |

---

## 📋 推薦安裝組合

### 1️⃣ 基礎組合 (所有人)

```bash
# Filesystem - 檔案操作
claude mcp add --transport stdio filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem .

# Git - 版本控制
claude mcp add --transport stdio git -- \
  npx -y @modelcontextprotocol/server-git
```

**適用**: 所有開發者
**總計**: 2 個 servers

---

### 2️⃣ 前端開發組合

```bash
# 基礎組合 +

# Playwright - E2E 測試
claude mcp add --transport stdio playwright -- \
  npx -y @executeautomation/playwright-mcp

# GitHub - 協作
claude mcp add --transport stdio github -- \
  npx -y @modelcontextprotocol/server-github
```

**適用**: React/Vue/Angular 開發者
**總計**: 4 個 servers

---

### 3️⃣ 全端開發組合

```bash
# 基礎組合 + 前端組合 +

# PostgreSQL - 資料庫
claude mcp add --transport stdio postgres -- \
  npx -y @executeautomation/database-server

# Tavily - 研究工具
claude mcp add --transport stdio tavily -- \
  npx -y @tavily/mcp-server
```

**適用**: 全端開發者
**總計**: 6 個 servers
**需要**: DATABASE_URL, TAVILY_API_KEY

---

### 4️⃣ 企業開發組合

```bash
# 全端組合 +

# Semgrep - 安全掃描
claude mcp add --transport stdio semgrep -- \
  npx -y @semgrep/mcp-server

# Notion - 文檔管理
claude mcp add --transport http notion https://mcp.notion.com/mcp

# Slack - 團隊通訊
claude mcp add --transport stdio slack -- \
  npx -y @slack/mcp-server
```

**適用**: 企業團隊
**總計**: 9 個 servers
**需要**: NOTION_TOKEN, SLACK_TOKEN

---

### 5️⃣ DevOps 組合

```bash
# 基礎組合 +

# AWS - 雲端管理
claude mcp add --transport stdio aws-kb -- \
  npx -y @modelcontextprotocol/server-aws-kb

# GitHub - CI/CD
claude mcp add --transport stdio github -- \
  npx -y @modelcontextprotocol/server-github

# Playwright - 自動化測試
claude mcp add --transport stdio playwright -- \
  npx -y @executeautomation/playwright-mcp
```

**適用**: DevOps 工程師
**總計**: 5 個 servers

---

## 🎯 依語言選擇

### TypeScript/JavaScript 開發者
```
✅ Filesystem
✅ Git
✅ GitHub
✅ Playwright (前端測試)
✅ PostgreSQL/SQLite (如有後端)
```

### Python 開發者
```
✅ Filesystem
✅ Git
✅ GitHub
✅ PostgreSQL
✅ Tavily (資料科學/研究)
```

### Go 開發者
```
✅ Filesystem
✅ Git
✅ GitHub
✅ PostgreSQL
✅ AWS (微服務)
```

### Rust 開發者
```
✅ Filesystem
✅ Git
✅ GitHub
✅ SQLite (嵌入式)
```

### Java 開發者
```
✅ Filesystem
✅ Git
✅ GitHub
✅ PostgreSQL
✅ JetBrains (IntelliJ IDEA)
```

---

## 💡 選擇建議

### 新手 → 基礎組合
從 Filesystem + Git 開始,熟悉 MCP 運作方式。

### 中級 → 基礎 + 2-3 個專業工具
根據你的專案類型加入 Database 或 GitHub。

### 進階 → 完整組合
安裝完整工具鏈,最大化自動化效益。

### 企業 → 企業組合 + 自訂
加入公司專用的 MCP servers (Salesforce, Jira 等)。

---

## 📊 功能對照表

| 需求 | 推薦 MCP Server | 替代方案 |
|------|----------------|---------|
| 檔案操作 | Filesystem | - |
| Git 操作 | Git | GitHub (部分) |
| 資料庫查詢 | PostgreSQL/SQLite | Neo4j (圖資料庫) |
| Web 搜尋 | Tavily | Perplexity, Exa |
| 程式碼審查 | GitHub | Semgrep (安全面) |
| 自動化測試 | Playwright | Selenium |
| 文檔管理 | Notion | Confluence |
| 團隊溝通 | Slack | Discord, Teams |
| 支付處理 | Stripe | PayPal |
| 雲端管理 | AWS | Azure, GCP |

---

## 🔒 安全考量

### API Keys 管理

**必須保護的 Keys**:
- `GITHUB_TOKEN`
- `TAVILY_API_KEY`
- `PERPLEXITY_API_KEY`
- `NOTION_TOKEN`
- `SLACK_TOKEN`
- `STRIPE_KEY`
- `DATABASE_URL`

**最佳實踐**:
```bash
# 1. 使用 .env 文件
echo "GITHUB_TOKEN=ghp_xxxxx" >> .env.mcp

# 2. 加入 .gitignore
echo ".env.mcp" >> .gitignore

# 3. 在 MCP 配置中引用
{
  "env": {
    "GITHUB_TOKEN": "${GITHUB_TOKEN}"
  }
}
```

### 權限控制

```bash
# ✅ 好: 限制檔案系統訪問
claude mcp add --transport stdio filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem ./src

# ❌ 壞: 允許整個系統
claude mcp add --transport stdio filesystem -- \
  npx -y @modelcontextprotocol/server-filesystem /
```

---

## 💰 成本考量

### 免費 MCP Servers
- Filesystem ✅
- Git ✅
- GitHub ✅ (需 GitHub 帳號)
- SQLite ✅
- Semgrep ✅ (開源版)

### 需要 API Key (免費額度)
- Tavily (1000 requests/month)
- Perplexity (有限制)
- Notion (個人版免費)

### 付費服務
- AWS (按用量計費)
- Stripe (交易手續費)
- Salesforce (企業授權)

---

## 🚀 快速開始

### 步驟 1: 安裝基礎組合
```bash
bash setup-mcp-basic.sh
```

### 步驟 2: 配置環境變數
```bash
cp .env.mcp.example .env.mcp
# 編輯 .env.mcp 填入你的 API keys
```

### 步驟 3: 驗證安裝
```bash
claude
/mcp  # 查看已安裝的 MCP servers
```

### 步驟 4: 開始使用!
Claude Code 會自動在需要時使用 MCP servers。

---

## 📚 更多資源

- [完整 MCP 指南](guides/mcp-guide.md) - 詳細使用說明
- [Awesome MCP Servers](https://github.com/wong2/awesome-mcp-servers) - 社群列表
- [MCP 官方文檔](https://modelcontextprotocol.io/) - 開發文檔

---

**建議**: 先從基礎組合開始,根據實際需求逐步增加!
