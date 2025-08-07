# Gitbby - GitHub Webhook 处理器

## 这是什么？

Gitbby 是一个简单的 Ruby 应用程序，旨在作为 GitHub Webhook 的处理器。它能够监听 GitHub 仓库中的特定事件（例如，当一个新的 Issue 或 Pull Request 被打开时），并自动执行预定义的操作，例如在 Issue 或 Pull Request 上添加评论。

## 用法

### 1. 克隆仓库

首先，将此仓库克隆到您的本地机器：

```bash
git clone https://github.com/ctkqiang/Gitbby.git
cd Gitbby
```

### 2. 安装依赖

该项目使用 Bundler 管理 Ruby 依赖。请确保您已安装 Bundler，然后运行以下命令安装所需的 gem：

```bash
bundle install
```

### 3. 配置 GitHub Token

Gitbby 使用 GitHub Personal Access Token 来与 GitHub API 进行交互（例如，添加评论）。您需要创建一个具有适当权限（例如 `repo` 权限）的 GitHub Personal Access Token，并将其设置为名为 `GITHUB_TOKEN` 的环境变量。

**在 Windows 上设置环境变量：**

```bash
set GITHUB_TOKEN=您的GitHub个人访问令牌
```

**在 macOS/Linux 上设置环境变量：**

```bash
export GITHUB_TOKEN=您的GitHub个人访问令牌
```

或者，您可以在项目根目录下创建一个 `.env` 文件（已在 `.gitignore` 中忽略），并添加以下内容：

```
GITHUB_TOKEN=您的GitHub个人访问令牌
```

`dotenv` gem 会自动加载此文件中的环境变量。

### 4. 运行应用程序

Gitbby 应用程序通常会作为一个 Sinatra 应用程序运行，监听来自 GitHub 的 Webhook 请求。您可以使用 `rackup` 来启动它：

```bash
rackup
```

这将启动一个本地服务器（通常在 `http://localhost:9292`），等待 GitHub Webhook 的传入请求。

### 5. 配置 GitHub Webhook

最后一步是在您的 GitHub 仓库中配置 Webhook，使其指向您的 Gitbby 应用程序。

1.  导航到您的 GitHub 仓库设置。
2.  点击“Webhooks”选项卡。
3.  点击“Add webhook”。
4.  在“Payload URL”字段中，输入您的 Gitbby 应用程序的 URL。如果您在本地运行，并且可以通过公共 URL 访问（例如，使用 ngrok），则输入该 URL。例如：`http://your-public-url/webhook`。
5.  将“Content type”设置为 `application/json`。
6.  选择您希望 Gitbby 监听的事件。根据您当前的处理器，您可能需要选择“Issues”和“Pull requests”事件。
7.  点击“Add webhook”。

现在，当您配置的事件在您的 GitHub 仓库中发生时，GitHub 将向您的 Gitbby 应用程序发送一个 Webhook 请求，Gitbby 将处理它并执行相应的操作。
