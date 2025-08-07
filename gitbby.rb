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


      puts "\n=== 请求头 ==="
      request.env.each { |k,v| puts "#{k}: #{v}" if k.start_with?('HTTP_') }


      puts "\n=== 原始请求体 ==="
      puts raw[0..500]  # 打印前500字符


      secret = ENV['GITHUB_WEBHOOK_SECRET']
      sig_header = request.env['HTTP_X_HUB_SIGNATURE_256']
      computed = 'sha256=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret, raw)

      puts "\n=== 签名校验 ==="
      puts ".env 中的密钥: #{secret.inspect}"
      puts "签名头: #{sig_header.inspect}"
      puts "计算出的签名: #{computed.inspect}"

      unless sig_header && secret && Rack::Utils.secure_compare(computed, sig_header)
        puts ">>> 签名不匹配 — 返回 403 错误"
        halt 403, '无效签名'
      end


      event = request.env['HTTP_X_GITHUB_EVENT']
      puts "\n=== 事件 === #{event.inspect}"
      unless event
        halt 403, '缺少 X-GitHub-Event'
      end

      begin
        payload = JSON.parse(raw)
      rescue JSON::ParserError => e
        puts "JSON 解析错误: #{e.message}"
        halt 400, '无效 JSON'
      end


      if event == 'ping'
        puts "ping 事件已处理"
        return 200
      end

      Gitbby::Router.route(event, payload)
      status 200
    end
  end
end

Gitbby::App.run! host: '0.0.0.0', port: ENV.fetch("PORT", 3000).to_i if __FILE__ == $PROGRAM_NAME

