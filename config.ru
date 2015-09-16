require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')

require 'connection_pool'
$redis = ConnectionPool::Wrapper.new(size: 15, timeout: 3) do |i|
  ::Redis::Store.new(url: ENV['REDIS_URL'])
end


require './app'
run RobinBotApp