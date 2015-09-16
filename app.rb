require 'sinatra'
require 'securerandom'

class RobinBotApp < Sinatra::Base
  get '/' do
    message = $redis.randomkey
    `cowsay -f #{Dir.pwd}.resources/bear.cow  "#{message}"`
  end
  
  post '/' do
    $redis[SecureRandom.uuid] = params[:msg]
  end
end