require_relative 'gitbby/client'

module Gitbby

  module Handlers

    class PullRequestHandlers
    
      def initialize(_payload)
        @payload = _payload
      end

      def call
        return unless @payload['action'] == 'opened'

        repository = @payload['repository']['full_name']
        pull_request_number = @payload['pull_request']['number']
        title = @payload['pull_request']['title']
        body = @payload['pull_request']['body']

        puts "仓库: #{repository}"
        puts "拉取请求编号: #{pull_request_number}"
        puts "标题: #{title}"
        puts "内容: #{body}"

        # @TODO 处理自定义逻辑和消息
        Gitbby::Client.instance.client.add_comment(repository, pull_request_number, "感谢您提交此拉取请求！我正在查看中")

      end
    
    end

  end

end