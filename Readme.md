# 🌸 Gitbby - GitHub Webhook 消息监听器（Ruby + Sinatra）

> 轻量、模块化、高扩展性的 GitHub Webhook 事件处理器，专为 Pull Request 和 Issue 场景设计。

---

## 📌 项目简介

**Gitbby** 是一个用 Ruby 编写的 Webhook 接收处理器，基于 Sinatra 框架实现。它监听来自 GitHub 的事件（如新建 PR / Issue），并立即在本地输出消息，供你接入后续自动化逻辑。

典型用途包括：

- PR/Issue 创建时第一时间通知
- 自定义自动回复逻辑
- 接入本地 CI / 消息通知 / 数据分析流程

> 灵活性强、部署简单，是构建开发者工具链的绝佳基础设施组件。

---

## 🧱 项目结构

```bash
Gitbby/
├── app/
│   ├── handlers/              # 每类事件的独立处理器
│   │   ├── issue_handler.rb
│   │   └── pull_request_handler.rb
│   └── router.rb              # 路由层：按事件分发到处理器
├── main.rb                    # Sinatra 主程序
├── Gemfile                    # Ruby 依赖
└── .env                       # 本地配置（忽略版本控制）
````

---

## 🚀 快速开始

### 1️⃣ 克隆项目

```bash
git clone https://github.com/ctkqiang/Gitbby.git
cd Gitbby
```

### 2️⃣ 安装依赖

```bash
bundle install
```

### 3️⃣ 配置环境变量

创建 `.env` 文件并设置 GitHub Token：

```env
GITHUB_TOKEN=ghp_你的GitHub个人访问令牌
```

* Token 需要具备 `repo` 权限（用于未来调用 GitHub API）
* 建议使用 [dotenv](https://github.com/bkeepers/dotenv) 管理配置，避免硬编码

### 4️⃣ 启动本地服务

```bash
ruby gitbby.rb
```

默认监听地址为：`http://localhost:9292`

---

## 🌐 配置公网访问（Ngrok）

```bash
ngrok authtoken <你的Ngrok Token>
ngrok http 9292
```

将得到一个公网地址（如 `https://xxxxx.ngrok.io`），用于 GitHub Webhook。

---

## 🪝 GitHub Webhook 配置指南

1. 打开 GitHub 仓库 → Settings → Webhooks

2. 添加新的 Webhook

3. Payload URL 填写：

   ```
   https://<你的-ngrok-url>/githook
   ```

4. Content type 选择 `application/json`

5. 勾选事件：

   * Issues
   * Pull requests

6. 保存并测试触发 🎯

---

## 🛠️ 自定义事件逻辑

你可以在以下路径中添加或扩展业务逻辑：

* `app/handlers/issue_handler.rb`
* `app/handlers/pull_request_handler.rb`

它们将会根据事件被自动调用，例如：

```ruby
module Gitbby
  class IssueHandler
    def self.handle(payload)
      puts "[Issue] New: #{payload['issue']['title']}"
    end
  end
end
```

将来可添加逻辑如：

* 自动评论
* 打标签
* 分配 reviewer
* 数据存储等

---

## 🧩 架构原则（可拓展）

| 层级            | 说明                  |
| ------------- | ------------------- |
| Sinatra 控制器   | 接收并解析 Webhook 请求    |
| Router 分发器    | 根据事件类型进行 handler 分发 |
| Handlers      | 每类事件的业务处理逻辑         |
| GitHub Client | 可选，用于后续 API 操作（评论等） |

---

## 🧪 本地测试

1. 手动发起一个 PR 或 Issue
2. 查看终端输出是否正确触发对应事件
3. 后续可以 mock payload 调试各类逻辑

---

## ✅ 进阶功能建议（Todo）

* [ ] 支持更多 GitHub 事件类型（如 push、comments）
* [ ] 增加测试用例（RSpec or Minitest）
* [ ] GitHub Action 自动部署

---

有问题欢迎提 Issue，一起打造 Ruby 世界最甜 Webhook 核心 💘

---

## 🌟 开源项目赞助计划

### 用捐赠助力发展

感谢您使用本项目！您的支持是开源持续发展的核心动力。  
每一份捐赠都将直接用于：  
✅ 服务器与基础设施维护（魔法城堡的维修费哟~）  
✅ 新功能开发与版本迭代（魔法技能树要升级哒~）  
✅ 文档优化与社区建设（魔法图书馆要扩建呀~）

点滴支持皆能汇聚成海，让我们共同打造更强大的开源工具！  
（小仙子们在向你比心哟~）

---

### 🌐 全球捐赠通道

#### 国内用户

<div align="center" style="margin: 40px 0">

<div align="center">
<table>
<tr>
<td align="center" width="300">
<img src="https://github.com/ctkqiang/ctkqiang/blob/main/assets/IMG_9863.jpg?raw=true" width="200" />
<br />
<strong>🔵 支付宝</strong>（小企鹅在收金币哟~）
</td>
<td align="center" width="300">
<img src="https://github.com/ctkqiang/ctkqiang/blob/main/assets/IMG_9859.JPG?raw=true" width="200" />
<br />
<strong>🟢 微信支付</strong>（小绿龙在收金币哟~）
</td>
</tr>
</table>
</div>
</div>

#### 国际用户

<div align="center" style="margin: 40px 0">
  <a href="https://qr.alipay.com/fkx19369scgxdrkv8mxso92" target="_blank">
    <img src="https://img.shields.io/badge/Alipay-全球支付-00A1E9?style=flat-square&logo=alipay&logoColor=white&labelColor=008CD7">
  </a>
  
  <a href="https://ko-fi.com/F1F5VCZJU" target="_blank">
    <img src="https://img.shields.io/badge/Ko--fi-买杯咖啡-FF5E5B?style=flat-square&logo=ko-fi&logoColor=white">
  </a>
  
  <a href="https://www.paypal.com/paypalme/ctkqiang" target="_blank">
    <img src="https://img.shields.io/badge/PayPal-安全支付-00457C?style=flat-square&logo=paypal&logoColor=white">
  </a>
  
  <a href="https://donate.stripe.com/00gg2nefu6TK1LqeUY" target="_blank">
    <img src="https://img.shields.io/badge/Stripe-企业级支付-626CD9?style=flat-square&logo=stripe&logoColor=white">
  </a>
</div>

---

### 📌 开发者社交图谱

#### 技术交流

<div align="center" style="margin: 20px 0">
  <a href="https://github.com/ctkqiang" target="_blank">
    <img src="https://img.shields.io/badge/GitHub-开源仓库-181717?style=for-the-badge&logo=github">
  </a>
  
  <a href="https://stackoverflow.com/users/10758321/%e9%92%9f%e6%99%ba%e5%bc%ba" target="_blank">
    <img src="https://img.shields.io/badge/Stack_Overflow-技术问答-F58025?style=for-the-badge&logo=stackoverflow">
  </a>
  
  <a href="https://www.linkedin.com/in/ctkqiang/" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-职业网络-0A66C2?style=for-the-badge&logo=linkedin">
  </a>
</div>

#### 社交互动

<div align="center" style="margin: 20px 0">
  <a href="https://www.instagram.com/ctkqiang" target="_blank">
    <img src="https://img.shields.io/badge/Instagram-生活瞬间-E4405F?style=for-the-badge&logo=instagram">
  </a>
  
  <a href="https://twitch.tv/ctkqiang" target="_blank">
    <img src="https://img.shields.io/badge/Twitch-技术直播-9146FF?style=for-the-badge&logo=twitch">
  </a>
  
  <a href="https://github.com/ctkqiang/ctkqiang/blob/main/assets/IMG_9245.JPG?raw=true" target="_blank">
    <img src="https://img.shields.io/badge/微信公众号-钟智强-07C160?style=for-the-badge&logo=wechat">
  </a>
</div>