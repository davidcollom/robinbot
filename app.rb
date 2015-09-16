require 'sinatra'
require 'securerandom'
require 'cowsay'
require './resources/bear.rb'

class RobinBotApp < Sinatra::Base
  get '/' do
    content_type 'text/plain;charset=utf8'
    Cowsay::Character::Bear.say $redis[$redis.randomkey]
  end
  
  post '/' do
    key = params[:key].nil? ? SecureRandom.uuid : params[:key]
    $redis[key] = params[:msg] if params[:msg]!=''
    key
  end
  
  delete '/' do
    $redis.delete[ params[:id] ]
  end
  get '/health' do
    "OK"
  end
end