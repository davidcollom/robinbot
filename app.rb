require 'sinatra'
require 'securerandom'
require 'cowsay'
require './resources/bear.rb'

class RobinBotApp < Sinatra::Base
  get '/' do
    content_type 'text/plain;charset=utf8'
    Cowsay::Character::Bear.say $redis.randomkey
  end
  
  post '/' do
    $redis[SecureRandom.uuid] = params[:msg]
  end
end