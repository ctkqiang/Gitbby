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

        puts "Repository: #{repository}"
        puts "Pull Request Number: #{pull_request_number}"
        puts "Title: #{title}"
        puts "Body: #{body}"

        # @TODO Handle custom logic and message 
        Gitbby::Client.instance.client.add_comment(repository, pull_request_number, "Thanks for opening this pull request! I am Looking into it")

      end
    
    end

  end

end