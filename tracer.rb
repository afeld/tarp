require 'byebug'

def public_method?(tp)
  tp.defined_class.public_method_defined?(tp.method_id)
end

def class_instance?(cls)
  !!cls.name
end

trace = TracePoint.new(:call) do |tp|
  puts "---------------"
  # puts tp.class
  # puts tp.inspect
  # p [tp.lineno, tp.defined_class, tp.method_id, tp.event]
  if public_method?(tp)
    if class_instance?(tp.defined_class)
      puts "public instance method #{tp.defined_class}##{tp.method_id}"
    else
      # TODO fix output
      puts "public class method #{tp.defined_class}.#{tp.method_id}"
    end
  else
    puts "non-public method #{tp.defined_class}.#{tp.method_id}"
  end
end

trace.enable
