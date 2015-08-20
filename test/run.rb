require_relative '../lib/tarp'
require_relative '../fixtures/my_class'

Tarp::Tracer.enable

MyClass.public_class_method
my_instance = MyClass.new
my_instance.public_instance_method
