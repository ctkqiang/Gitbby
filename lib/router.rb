module Gitbby
  class Router
    def self.route(_event, _payload)
      case _event
      when 'issues'
        puts 'issues'
      end
    end
  end
end
