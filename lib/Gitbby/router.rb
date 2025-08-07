require_relative 'handlers/issues_handlers'
require_relative 'handlers/pull_request_handlers'

module Gitbby
  class Router
    HANDLER_MAP = {
      'issues'        => Handlers::IssuesHandlers,
      'pull_request'  => Handlers::PullRequestHandlers
    }.freeze

    def self.route(event, payload)
      handler_class = HANDLER_MAP[event]

      if handler_class
        handler_class.new(payload).call
      else
        warn "⚠️ 未知事件类型：#{event}，未分发处理"
      end
    end
  end
end
