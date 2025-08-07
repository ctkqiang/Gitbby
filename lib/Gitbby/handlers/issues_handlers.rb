require 'gitbby/client'

module Gitbby
  
  module Handlers
    
    class IssuesHandlers
      
      def initialize(_payload)
        @payload = _payload
      end

      def call
        return unless @payload['action'] == 'opened'

        repository = @payload['repository']['full_name']
        issue_number = @payload['issue']['number']
        title = @payload['issue']['title']
        body = @payload['issue']['body']

        puts "仓库: #{repository}"
        puts "问题编号: #{issue_number}"
        puts "标题: #{title}"
        puts "内容: #{body}"	

        # @TODO 处理自定义逻辑和消息
        Gitbby::Client.instance.client.add_comment(repository, issue_number, "感谢您提交此问题！我正在查看中")

      end
    
    end

  end

end
