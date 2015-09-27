require 'set'

module Tarp
  module Tracer
    TEST_DIR_REGEX = %r{/(spec|test)/}
    DIRECTLY_CALLED_METHODS = Set.new

    def self.called_directly_from_test?
      # TODO ensure this works outside of rspec
      # TODO fix for older versions of ruby
      filtered_calls = caller_locations(0)
      # Tarp.log(filtered_calls)

      # get the call *before* we reached this file
      filtered_calls.reject! { |call| call.absolute_path == __FILE__ }
      relevant_call = filtered_calls[1]
      # Tarp.log(relevant_call)

      path = relevant_call.absolute_path
      !!path.match(TEST_DIR_REGEX)
    end

    def self.on_method_call(tp)
      Tarp.log([tp.lineno, tp.defined_class, tp.method_id, tp.event])
      if self.called_directly_from_test?
        tm = TraceMethod.new(tp.defined_class, tp.method_id)
        unless tm.class_name.start_with?('Tarp')
          Tarp.log("---------------\ncalled from test")
          if tm.public?
            Tarp.log("public method called: #{tm}")
            DIRECTLY_CALLED_METHODS << tm
          else
            Tarp.log("non-public method #{tm}")
          end

          DIRECTLY_CALLED_METHODS << tm
        end
      end
    end

    def self.enable
      @trace ||= TracePoint.new(:call) do |tp|
        self.on_method_call(tp)
      end
      @trace.enable
      Tarp.log("Tracer enabled")
    end

    def self.disable
      @trace.disable if @trace
      Tarp.log("Tracer disabled")
    end

    def self.reset
      DIRECTLY_CALLED_METHODS.clear
    end
  end
end
