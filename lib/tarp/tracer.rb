module Tarp
  module Tracer
    TEST_REGEX = %r{/(spec|test)/}

    def self.called_directly_from_test?
      # puts caller_locations.inspect
      # TODO use the index of this file to make this dynamic
      # TODO ensure this works outside of rspec
      # TODO fix for older versions of ruby
      relevant_call = caller_locations(1, 1)[0]
      # puts relevant_call.inspect
      path = relevant_call.absolute_path
      !!path.match(TEST_REGEX)
    end

    def self.public_method?(tp)
      tp.defined_class.public_method_defined?(tp.method_id)
    end

    def self.class_instance?(cls)
      !!cls.name
    end

    def self.method_to_s(tp)
      if self.class_instance?(tp.defined_class)
        "#{tp.defined_class}##{tp.method_id}"
      else
        # TODO make this work for modules
        # TODO do this without needing to parse (#<Class:MyClass>)
        cls = tp.defined_class.to_s.match(/\A#<Class:(.+)>\z/)[1]
        "#{cls}.#{tp.method_id}"
      end
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
          puts "public instance method #{self.method_to_s(tp)}"
        else
          puts "public class method #{self.method_to_s(tp)}"
        end
      else
        puts "non-public method #{self.method_to_s(tp)}"
      end
    end

    def self.enable
      @trace ||= TracePoint.new(:call) do |tp|
        self.on_method_call(tp)
      end
      @trace.enable
    end

    def self.disable
      @trace.disable if @trace
    end
  end
end
