require 'sinatra'
require 'json'
require 'dotenv/load'

set :port, ENV.fetch('PORT', 3000)

post '/githook' do
    request.body.rewind
    payload = JSON.parse(request.body.read)
    
    events = request.env['HTTP_X_GITHUB_EVENT']


    puts 'EVENTS: #{events}'

end