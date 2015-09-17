require 'sinatra'
require 'securerandom'
require 'cowsay'
require './resources/bear.rb'

class RobinBotApp < Sinatra::Base
  
  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [ENV['ROBINBOT_USER'],ENV['ROBINBOT_PASSWD']]
  end

  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Oops... we need your login name & password\n"])
    end
  end
  
  get '/' do
    content_type 'text/plain;charset=utf8'
    key = $redis.randomkey
    response.headers['X-Robin-Bot-Key'] = key
    Cowsay::Character::Bear.say $redis[key]
  end
  get '/:key' do
    content_type 'text/plain;charset=utf8'
    halt(404) if $redis[ params[:key] ].nil?
    Cowsay::Character::Bear.say $redis[ params[:key] ]
  end
  get '/list' do
    content_type 'text/plain;charset=utf8'
    $redis.keys.map{|k| "#{k} => #{$redis[k]}" }.join("\n\n")
  end
  
  post '/' do
    protected!
    key = SecureRandom.uuid
    $redis[key] = params[:msg] if params[:msg]!=''
    key
  end
  
  delete '/' do
    protected!
    $redis.delete[ params[:id] ]
  end
  delete '/:key' do
    protected!
    $redis.del[ params[:key] ]
  end
  get '/health' do
    "OK"
  end
end