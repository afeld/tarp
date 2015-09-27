module Tarp
  class TraceMethod
    attr_reader :defined_class, :method_id

    # can't pass the TracePoint instance directly, because it gives a `RuntimeError: access from outside`
    def initialize(defined_class, method_id)
      @defined_class = defined_class
      @method_id = method_id
    end

    def public_method?
      self.defined_class.public_method_defined?(self.method_id)
    end

    def class_instance?
      !!self.defined_class.name
    end

    def class_name
      if self.class_instance?
        self.defined_class.name
      else
        # TODO make this work for modules
        # TODO do this without needing to parse (#<Class:MyClass>)
        self.defined_class.to_s.match(/\A#<Class:(.+)>\z/)[1]
      end
    end

    def method_name
      self.method_id
    end

    def to_s
      if self.class_instance?
        "#{self.class_name}##{self.method_name}"
      else
        "#{self.class_name}.#{self.method_name}"
      end
    end
  end
end
