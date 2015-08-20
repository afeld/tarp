def global_method
  puts "global_method called" if ENV['DEBUG']
end

global_method
