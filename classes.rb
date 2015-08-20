classes_before = Module.constants

class Foo
end

at_exit do
  classes_after = Module.constants
  added_classes = classes_after - classes_before
end
