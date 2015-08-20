require 'pry-byebug'
require_relative '../tracer'
require_relative '../src'

Tracer.enable

MyClass.public_class_method
my_instance = MyClass.new
my_instance.public_instance_method
