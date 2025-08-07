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

        puts "Repository: #{repository}"
        puts "Issue Number: #{issue_number}"
        puts "Title: #{title}"
        puts "Body: #{body}"	

        # @TODO Handle custom logic and message 
        Gitbby::Client.instance.client.add_comment(repository, issue_number, "Thanks for opening this issue! I am Looking into it")

      end
    
    end

  end

end
