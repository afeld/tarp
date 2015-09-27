require_relative 'tarp/version'
require_relative 'tarp/tracer'
require_relative 'tarp/trace_method'

module Tarp
  # TODO allow a block to be passed so it doesn't need to be evaluated if not in debug mode
  def self.log(msg)
    if ENV['DEBUG']
      require 'pp'
      if msg.is_a?(String)
        puts "DEBUG: #{msg}"
      else
        puts "DEBUG:"
        pp msg
      end
    end
  end
end
