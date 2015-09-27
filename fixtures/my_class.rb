class MyClass
  def public_instance_method
    self.protected_instance_method
    Tarp.log("public_instance_method called")
  end

  def self.public_class_method
    Tarp.log("public_class_method called")
  end

  protected

  def protected_instance_method
    Tarp.log("protected_instance_method called")
  end
end
