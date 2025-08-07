require 'octokit'	

module Gitbby

  class Client
    
    def self.client
      @client ||= Octokit::Client.new(access_token: ENV.fetch('GITHUB_TOKEN'))
    end

  end

end
