module Gitbby

  class Router

    def self.route(_event, _payload)

      case _event
      when 'issues'
        puts 'issues'
      when 'pull_request'
        puts 'pull_request'
      else
        puts 'else'
      end
    
    end

  end

end
