require_relative 'tarp/version'
require_relative 'tarp/tracer'

module Tarp
  def self.log(msg)
    puts "DEBUG: #{msg}" if ENV['DEBUG']
  end
end
