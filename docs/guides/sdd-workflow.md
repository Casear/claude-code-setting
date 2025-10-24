# 🎯 SDD (Spec-Driven Development) 工作流程指南

## 什麼是 SDD?

Spec-Driven Development 是一種結構化開發方法論,強調在寫程式碼之前先定義規格。

### 核心理念

**Requirements → Design → Tasks → Implementation**

1. **Requirements (需求)**: 定義要建立什麼以及為什麼
2. **Design (設計)**: 規劃如何實作,包括架構和技術細節
3. **Tasks (任務)**: 將設計拆解成可執行的小步驟
4. **Implementation (實作)**: 執行具體的編碼工作

## 為什麼需要 SDD?

### 傳統方式的問題
```
用戶: "幫我建立用戶認證功能"
AI: *直接開始寫程式碼*
結果: ❌ 架構不一致、缺少錯誤處理、沒有測試
```

### SDD 方式
```
用戶: /kiro:spec-init "用戶認證功能"
AI: *生成詳細規格,等待審核*
用戶: *審核並批准*
AI: *基於規格實作*
結果: ✅ 架構清晰、完整實作、有測試
```

## 安裝 SDD 工具

```bash
# 在專案目錄中
npx cc-sdd@latest

# 這會安裝 11 個 Kiro 指令到 .claude/commands/kiro/
```

## SDD 工作流程

### 完整流程範例

```bash
# 1. 初始化規格
/kiro:spec-init "用戶認證系統"

# 輸出: 建立規格文件 auth-system.md

# 2. 生成需求文檔
/kiro:spec-requirements auth-system

# 輸出:
# - 功能需求
# - 非功能需求
# - 驗收標準
# 👉 等待人工審核批准

# 3. 生成設計文檔
/kiro:spec-design auth-system

# 或自動批准: /kiro:spec-design auth-system -y

# 輸出:
# - 系統架構
# - 資料模型
# - API 設計
# - 安全考量
# 👉 等待人工審核批准

# 4. 拆解任務
/kiro:spec-tasks auth-system -y

# 輸出:
# 1.1 建立 User 模型
# 1.2 實作密碼雜湊
# 1.3 建立 login API
# 1.4 建立 register API
# 2.1 實作 JWT token 生成
# 2.2 實作 token 驗證中介層
# 3.1 撰寫單元測試
# 3.2 撰寫整合測試

# 5. 逐步實作
/kiro:spec-impl auth-system 1.1,1.2

# 實作指定的任務,完成後可繼續:
/kiro:spec-impl auth-system 1.3,1.4
/kiro:spec-impl auth-system 2.1,2.2
```

## 指令詳解

### /kiro:spec-init
**用途**: 開始新的功能規格

```bash
/kiro:spec-init "功能名稱"
/kiro:spec-init "用戶通知系統"
```

**產出**:
- 建立 `specs/feature-name.md`
- 初始化規格結構

---

### /kiro:spec-requirements
**用途**: 生成需求文檔

```bash
/kiro:spec-requirements feature-id
```

**產出**:
```markdown
## 功能需求
1. 用戶可以使用 email 和密碼註冊
2. 用戶可以登入並獲得 JWT token
3. 用戶可以登出

## 非功能需求
- 密碼必須安全儲存 (bcrypt)
- API 回應時間 < 200ms
- 支援 10,000 並發用戶

## 驗收標準
- [ ] 所有 API 有單元測試
- [ ] 整合測試覆蓋率 > 80%
- [ ] 符合 OWASP 安全標準
```

**👉 人工審核點**: 確認需求完整且正確

---

### /kiro:spec-design
**用途**: 生成設計文檔

```bash
/kiro:spec-design feature-id       # 需要審核
/kiro:spec-design feature-id -y   # 自動批准
```

**產出**:
```markdown
## 系統架構
- 三層架構: Controller → Service → Repository

## 資料模型
```typescript
interface User {
  id: string;
  email: string;
  passwordHash: string;
  createdAt: Date;
}
```

## API 端點
POST /api/auth/register
POST /api/auth/login
POST /api/auth/logout

## 安全考量
- 使用 bcrypt 雜湊密碼
- JWT token 有效期 24 小時
- 實作 rate limiting
```

**👉 人工審核點**: 確認設計符合架構標準

---

### /kiro:spec-tasks
**用途**: 拆解成可執行任務

```bash
/kiro:spec-tasks feature-id -y
```

**產出**: 帶編號的任務列表
```
1. Database Layer
   1.1 建立 User 模型
   1.2 建立 migrations
   1.3 建立 repository

2. Business Logic
   2.1 實作密碼雜湊服務
   2.2 實作 JWT 服務
   2.3 實作認證服務

3. API Layer
   3.1 建立 auth controller
   3.2 實作 register endpoint
   3.3 實作 login endpoint

4. Testing
   4.1 Unit tests
   4.2 Integration tests
```

---

### /kiro:spec-impl
**用途**: 實作指定任務

```bash
/kiro:spec-impl feature-id 1.1,1.2,1.3

# 或單個任務
/kiro:spec-impl feature-id 1.1
```

**流程**:
1. 讀取任務詳細內容
2. 參考設計文檔
3. 生成程式碼
4. 執行測試
5. 標記任務完成

---

### /kiro:steering
**用途**: 建立專案記憶 (學習 codebase)

```bash
/kiro:steering
```

**功能**:
- 分析專案結構
- 識別patterns和慣例
- 生成 CLAUDE.md
- 建立專案上下文

**使用時機**:
- 初次設定專案
- 專案架構變更後
- 新團隊成員加入時

---

### /kiro:validate-gap
**用途**: 分析實作與需求的差距

```bash
/kiro:validate-gap
```

**用於**:
- Bug 修復流程
- 檢查實作完整性
- 技術債務識別

---

### /kiro:validate-design
**用途**: 驗證設計是否整合現有系統

```bash
/kiro:validate-design
```

**檢查**:
- 設計與現有架構相容性
- API 一致性
- 命名慣例

## 最佳實踐

### 1. 小步迭代

**好的方式**:
```bash
/kiro:spec-impl auth-system 1.1  # 一次一個任務
# 測試、審核、commit
/kiro:spec-impl auth-system 1.2  # 下一個任務
```

**避免**:
```bash
/kiro:spec-impl auth-system 1.1,1.2,1.3,2.1,2.2  # 太多任務
# 產生大量程式碼,難以審核
```

### 2. 每個階段都審核

```bash
# ✅ 好的流程
/kiro:spec-requirements feature
# 👉 仔細審核需求,確認完整
/kiro:spec-design feature
# 👉 審核設計,確認架構正確
/kiro:spec-tasks feature
# 👉 審核任務拆解,確認邏輯順序
```

### 3. 保持 Diff 小於 200 行

```bash
# 如果任務太大,拆分:
/kiro:spec-impl feature 1.1  # < 200 行
/kiro:spec-impl feature 1.2  # < 200 行

# 不要:
/kiro:spec-impl feature 1.1,1.2,1.3  # > 500 行
```

### 4. 文檔先於程式碼

```
順序: Requirements → Design → Tasks → Code
不要跳過前面的步驟直接寫程式碼!
```

### 5. 使用 steering 建立上下文

```bash
# 專案開始時
/kiro:steering

# 這會幫助 AI 理解:
# - 你的程式碼風格
# - 專案架構
# - 命名慣例
# - 常用patterns
```

## 實際範例

### 範例 1: 新增 API 端點

```bash
# 1. 初始化
/kiro:spec-init "User Profile API"

# 2. 定義需求
/kiro:spec-requirements user-profile
# 輸出:
# - GET /api/users/:id - 取得用戶資料
# - PUT /api/users/:id - 更新用戶資料
# - 需要認證
# - 驗證輸入

# 3. 設計
/kiro:spec-design user-profile -y
# 輸出:
# - Controller 層設計
# - Service 層邏輯
# - Validation 規則
# - Error handling

# 4. 任務
/kiro:spec-tasks user-profile -y
# 1.1 建立 profile controller
# 1.2 建立 profile service
# 1.3 建立 validation schemas
# 1.4 實作 GET endpoint
# 1.5 實作 PUT endpoint
# 2.1 單元測試
# 2.2 整合測試

# 5. 實作
/kiro:spec-impl user-profile 1.1,1.2,1.3
/kiro:spec-impl user-profile 1.4
/kiro:spec-impl user-profile 1.5
/kiro:spec-impl user-profile 2.1,2.2
```

### 範例 2: Bug 修復

```bash
# 1. 驗證問題
/kiro:validate-gap

# 分析: "密碼重設功能缺少 email 驗證"

# 2. 初始化修復規格
/kiro:spec-init "Fix: Password Reset Email Verification"

# 3. 定義需求
/kiro:spec-requirements password-reset-fix
# - 發送驗證碼到 email
# - 驗證碼有效期 10 分鐘
# - 限制重發次數

# 4. 設計
/kiro:spec-design password-reset-fix -y

# 5. 實作
/kiro:spec-tasks password-reset-fix -y
/kiro:spec-impl password-reset-fix 1.1,1.2
```

## 與傳統開發的比較

| 階段 | 傳統方式 | SDD 方式 |
|------|---------|---------|
| 需求 | 口頭溝通,模糊 | 文檔化,具體 |
| 設計 | 邊寫邊想 | 預先規劃,審核 |
| 實作 | 大塊程式碼 | 小任務,漸進 |
| 審核 | 最後審核 | 每階段審核 |
| 測試 | 事後補測試 | 規格包含測試 |
| 變更 | 重構困難 | 修改規格,重新生成 |

## 常見問題

### Q: SDD 會不會太慢?

**A**: 短期看似慢,長期更快:
- ✅ 減少返工
- ✅ 架構一致
- ✅ 易於維護
- ✅ 新人上手快

### Q: 小功能也要用 SDD 嗎?

**A**: 視情況:
- **簡單修改** (< 50 行): 不需要
- **新功能/重構**: 建議使用
- **核心邏輯變更**: 必須使用

### Q: 可以跳過某些階段嗎?

**A**: 不建議,但可以快速通過:
```bash
/kiro:spec-requirements feature
/kiro:spec-design feature -y  # 自動批准
/kiro:spec-tasks feature -y   # 自動批准
```

## 進階技巧

### 1. 規格文件版本控制

```bash
# 規格文件也要 commit
git add specs/
git commit -m "Add auth system specification"
```

### 2. 規格重用

```bash
# 複製類似功能的規格作為起點
cp specs/user-auth.md specs/admin-auth.md
# 修改後執行 /kiro:spec-design
```

### 3. 團隊協作

```markdown
# specs/feature.md 可以包含:
## 負責人
- 需求: @alice
- 設計: @bob
- 實作: @charlie

## 時程
- 需求完成: 2025-02-01
- 設計完成: 2025-02-05
- 實作完成: 2025-02-15
```

---

**下一步**: 嘗試使用 SDD 開發你的第一個功能!

開始: `/kiro:spec-init "你的功能名稱"`
