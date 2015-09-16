require 'sinatra'
require 'securerandom'
require 'cowsay'
require './resources/bear.rb'

class RobinBotApp < Sinatra::Base
  get '/' do
    content_type 'text/plain;charset=utf8'
    Cowsay::Character::Bear.say $redis[SecureRandom.uuid]
  end
  get '/:key' do
    content_type 'text/plain;charset=utf8'
    Cowsay::Character::Bear.say $redis[ params[:key] ]
  end
  
  post '/' do
    key = SecureRandom.uuid
    $redis[key] = params[:msg] if params[:msg]!=''
    key
  end
  
  delete '/' do
    $redis.delete[ params[:id] ]
  end
  delete '/:key' do
    $redis.delete[ params[:key] ]
  end
  get '/health' do
    "OK"
  end
end