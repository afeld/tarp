module Tarp
  module Tracer
    def self.called_directly_from_test?
      # puts caller_locations.inspect
      # TODO use the index of this file
      relevant_call = caller_locations[3]
      # puts relevant_call.inspect
      path = relevant_call.absolute_path
      path.match(%r{/(spec|test)/})
    end

    def self.public_method?(tp)
      tp.defined_class.public_method_defined?(tp.method_id)
    end

    def self.class_instance?(cls)
      !!cls.name
    end

    def self.on_method_call(tp)
      puts "---------------"
      if self.called_directly_from_test?
        puts "called from test"
      end
      # puts tp.class
      # puts tp.inspect
      # p [tp.lineno, tp.defined_class, tp.method_id, tp.event]
      if self.public_method?(tp)
        if self.class_instance?(tp.defined_class)
          puts "public instance method #{tp.defined_class}##{tp.method_id}"
        else
          # TODO fix output
          puts "public class method #{tp.defined_class}.#{tp.method_id}"
        end
      else
        puts "non-public method #{tp.defined_class}.#{tp.method_id}"
      end
    end

    def self.enable
      trace = TracePoint.new(:call) do |tp|
        self.on_method_call(tp)
      end
      trace.enable
    end
  end
end
