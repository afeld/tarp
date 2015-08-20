class MyClass
  def public_instance_method
    self.protected_instance_method
    puts "public_instance_method called" if ENV['DEBUG']
  end

  def self.public_class_method
    puts "public_class_method called" if ENV['DEBUG']
  end

  protected

  def protected_instance_method
    puts "protected_instance_method called" if ENV['DEBUG']
  end
end

MyClass.public_class_method
my_instance = MyClass.new
my_instance.public_instance_method
