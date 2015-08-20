def called_directly_from_test?
  # TODO use the index of this file
  relevant_call = caller_locations[2]
  path = relevant_call.absolute_path
  path.match(%r{/(spec|test)/})
end

def public_method?(tp)
  tp.defined_class.public_method_defined?(tp.method_id)
end

def class_instance?(cls)
  !!cls.name
end

trace = TracePoint.new(:call) do |tp|
  puts "---------------"
  if called_directly_from_test?
    puts "called from test"
  end
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
