# JavaScript/Node.js 專案設定指南

## 快速開始

### 初始化 JavaScript 專案

```bash
# 在你的 JavaScript 專案目錄
cd your-javascript-project

# 執行智慧初始化
bash /path/to/claude-code-templates/scripts/init-project.sh

# 自動檢測結果:
# 📊 Detection Results:
#   Detected language: javascript
# 🎯 Applying javascript-specific configuration...
```

## 包含的配置

### 1. CLAUDE.md
包含 JavaScript/Node.js 最佳實踐:
- 開發指令 (npm start, test, lint)
- 程式碼風格指南 (ES6+, async/await)
- 常用模式 (error handling, async operations)
- Node.js 最佳實踐
- 安全建議
- 效能優化技巧

### 2. Custom Commands

#### `/lint-fix`
```bash
/lint-fix
# 執行: npm run lint -- --fix 或 eslint . --fix
```
自動修復 ESLint 問題。

#### `/test-all`
```bash
/test-all
# 執行: npm test -- --coverage 或 jest --coverage
```
執行所有測試並顯示覆蓋率報告。

#### `/format`
```bash
/format
# 執行: npm run format 或 prettier --write .
```
使用 Prettier 格式化所有程式碼。

### 3. Hooks

#### PreToolUse: 自動格式化
編輯 `.js`, `.jsx`, `.mjs`, `.cjs` 檔案前自動執行 Prettier。

```bash
# .claude/hooks/prettier-format.sh
# 自動格式化 JavaScript 檔案
```

#### PreToolUse: 安全檢查
防止修改敏感檔案 (`.env`, `credentials.json` 等)。

#### PostToolUse: ESLint 檢查
編輯後自動執行 ESLint 檢查。

```bash
# 如果有 lint 問題:
⚠️  ESLint issues found in src/app.js
Run /lint-fix to automatically fix issues
```

## 專案結構建議

### Express.js 專案
```
your-project/
├── src/
│   ├── routes/        # API 路由
│   ├── controllers/   # 控制器
│   ├── models/        # 資料模型
│   ├── middleware/    # 中介層
│   ├── config/        # 配置
│   └── app.js         # 主應用
├── test/              # 測試
├── .claude/           # Claude Code 配置
├── .env.example       # 環境變數範例
├── package.json
└── README.md
```

### CLI 工具
```
your-project/
├── src/
│   ├── commands/      # CLI 指令
│   ├── utils/         # 工具函數
│   └── index.js       # 入口點
├── bin/
│   └── cli.js         # CLI 執行檔
├── .claude/
├── package.json
└── README.md
```

## 開發工作流程

### 1. 新功能開發 (使用 SDD)

```bash
# 1. 初始化規格
/kiro:spec-init "用戶認證 API"

# 2. 生成需求
/kiro:spec-requirements user-auth

# 3. 生成設計
/kiro:spec-design user-auth

# 4. 拆解任務
/kiro:spec-tasks user-auth -y

# 5. 實作
/kiro:spec-impl user-auth 1.1,1.2
```

### 2. 程式碼審查

```bash
# 使用 code-reviewer agent
"請審查 src/routes/auth.js 的程式碼"

# 輸出會包含:
# - 程式碼品質問題
# - 安全性檢查
# - 最佳實踐建議
# - 效能優化建議
```

### 3. 測試開發

```bash
# 執行測試
/test-all

# 查看覆蓋率
# Coverage summary會顯示在輸出中
```

### 4. 程式碼格式化

```bash
# 手動格式化
/format

# 或讓 hook 自動處理
# 每次編輯時會自動格式化
```

## package.json 建議配置

### 基本腳本
```json
{
  "scripts": {
    "start": "node src/index.js",
    "dev": "node --watch src/index.js",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "lint": "eslint .",
    "lint:fix": "eslint . --fix",
    "format": "prettier --write .",
    "format:check": "prettier --check ."
  }
}
```

### 開發依賴建議
```json
{
  "devDependencies": {
    "eslint": "^8.56.0",
    "prettier": "^3.1.1",
    "jest": "^29.7.0",
    "nodemon": "^3.0.2"
  }
}
```

## ESLint 設定

### .eslintrc.js
```javascript
module.exports = {
  env: {
    node: true,
    es2021: true,
    jest: true
  },
  extends: [
    'eslint:recommended',
    'prettier'
  ],
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module'
  },
  rules: {
    'no-console': 'off', // 允許 console 在 Node.js
    'no-unused-vars': ['error', { argsIgnorePattern: '^_' }]
  }
};
```

## Prettier 設定

### .prettierrc
```json
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5",
  "printWidth": 80
}
```

## 常見開發場景

### 1. Express.js API 開發

```bash
# 讓 Claude 協助建立 REST API
"建立一個用戶註冊的 API endpoint,使用 Express.js"

# Claude 會:
# 1. 建立 route handler
# 2. 實作 validation
# 3. 加入 error handling
# 4. 生成測試
```

### 2. 資料庫整合

```bash
# 使用 MCP database server
"設計用戶資料表的 schema"

# Claude 會:
# 1. 分析需求
# 2. 設計 schema
# 3. 生成 migration
# 4. 建立 model
```

### 3. 錯誤處理

```bash
"實作全域錯誤處理中介層"

# Claude 會:
# 1. 建立 error middleware
# 2. 處理各種錯誤類型
# 3. 記錄錯誤
# 4. 返回適當的 response
```

### 4. 測試撰寫

```bash
"為 auth.js 生成 Jest 測試"

# Claude 會:
# 1. 分析函數
# 2. 生成測試 cases
# 3. 包含邊界情況
# 4. Mock 外部依賴
```

## 最佳實踐

### 1. 使用 async/await
```javascript
// ✅ 好
async function getData() {
  try {
    const data = await fetchData();
    return data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

// ❌ 避免 callback hell
function getData(callback) {
  fetchData((err, data) => {
    if (err) return callback(err);
    processData(data, (err, result) => {
      // ...
    });
  });
}
```

### 2. 環境變數管理
```javascript
// 使用 dotenv
require('dotenv').config();

const config = {
  port: process.env.PORT || 3000,
  dbUrl: process.env.DATABASE_URL,
  apiKey: process.env.API_KEY
};

// 永遠不要 commit .env
```

### 3. 錯誤處理
```javascript
// Express 全域錯誤處理
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(err.status || 500).json({
    error: process.env.NODE_ENV === 'production'
      ? 'Internal server error'
      : err.message
  });
});
```

### 4. 輸入驗證
```javascript
// 使用 validation 庫
const Joi = require('joi');

const userSchema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string().min(8).required()
});

const { error, value } = userSchema.validate(req.body);
if (error) {
  return res.status(400).json({ error: error.details[0].message });
}
```

## 疑難排除

### 問題 1: ESLint 沒有執行

**檢查**:
```bash
# 確認 ESLint 已安裝
npm list eslint

# 手動執行
npx eslint src/
```

### 問題 2: Prettier 格式化不一致

**解決**:
```bash
# 建立 .prettierrc
# 確保團隊使用相同配置

# 在 package.json 添加
"format": "prettier --write ."
```

### 問題 3: Hook 沒有觸發

**檢查**:
```bash
# 確認 hook 有執行權限
chmod +x .claude/hooks/*.sh

# 測試 hook
echo '{"tool_input":{"file_path":"test.js"}}' | .claude/hooks/prettier-format.sh
```

## 推薦套件

### Web 框架
- **Express** - 最流行的 web 框架
- **Fastify** - 高效能替代方案
- **Koa** - Express 團隊的現代化框架

### 資料庫
- **mongoose** - MongoDB ODM
- **pg** - PostgreSQL 客戶端
- **prisma** - 現代化 ORM

### 測試
- **Jest** - 全功能測試框架
- **Supertest** - HTTP 測試
- **Mocha** + **Chai** - 靈活的測試組合

### 工具
- **nodemon** - 自動重啟
- **dotenv** - 環境變數
- **axios** - HTTP 客戶端
- **lodash** - 工具函數庫

## 進階主題

### 1. TypeScript 遷移

如果想升級到 TypeScript:

```bash
# 安裝 TypeScript
npm install -D typescript @types/node

# 初始化 TypeScript
npx tsc --init

# 重新執行初始化 (會檢測到 TypeScript)
bash /path/to/claude-code-templates/scripts/init-project.sh
```

### 2. 效能監控

```javascript
// 使用內建的 performance API
const { performance } = require('perf_hooks');

const start = performance.now();
await heavyOperation();
const duration = performance.now() - start;
console.log(`Operation took ${duration}ms`);
```

### 3. 安全加固

- 使用 `helmet` 設定安全 headers
- 實作 rate limiting
- 輸入驗證和 sanitization
- SQL injection 防護
- XSS 防護

## 相關資源

- [Node.js 官方文檔](https://nodejs.org/docs)
- [Express.js 指南](https://expressjs.com/)
- [JavaScript.info](https://javascript.info/)
- [Node.js 最佳實踐](https://github.com/goldbergyoni/nodebestpractices)

---

**開始使用 JavaScript/Node.js 開發! 🚀**
