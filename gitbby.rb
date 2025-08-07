# gitbby.rb — 完整 debug 版本
require 'sinatra/base'
require 'json'
require 'dotenv/load'
require 'openssl'

module Gitbby
  class App < Sinatra::Base
    set :port, ENV.fetch('PORT', 3000)
    set :bind, '0.0.0.0'

    post '/githook' do
      request.body.rewind
      raw = request.body.read

      # 1. 打印所有 Request 头确认签名是否送达
      puts "\n=== HEADERS ==="
      request.env.each { |k,v| puts "#{k}: #{v}" if k.start_with?('HTTP_') }

      # 2. 打印 raw body
      puts "\n=== RAW BODY ==="
      puts raw[0..500]  # 打前500字符

      # 3. 签名校验
      secret = ENV['GITHUB_WEBHOOK_SECRET']
      sig_header = request.env['HTTP_X_HUB_SIGNATURE_256']
      computed = 'sha256=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret, raw)

      puts "\n=== SIGNATURE CHECK ==="
      puts "Secret from .env: #{secret.inspect}"
      puts "Signature header: #{sig_header.inspect}"
      puts "Computed sig   : #{computed.inspect}"

      unless sig_header && secret && Rack::Utils.secure_compare(computed, sig_header)
        puts ">>> Signature mismatch — halting with 403"
        halt 403, 'Invalid signature'
      end

      # 4. GitHub Event 验证
      event = request.env['HTTP_X_GITHUB_EVENT']
      puts "\n=== EVENT === #{event.inspect}"
      unless event
        halt 403, 'Missing X-GitHub-Event'
      end

      # 5. 解析 JSON Body
      begin
        payload = JSON.parse(raw)
      rescue JSON::ParserError => e
        puts "JSON parse error: #{e.message}"
        halt 400, 'Invalid JSON'
      end

      # 6. ping 或分发处理
      if event == 'ping'
        puts "ping event processed"
        return 200
      end

      Gitbby::Router.route(event, payload)
      status 200
    end
  end
end

Gitbby::App.run! if __FILE__ == $PROGRAM_NAME
