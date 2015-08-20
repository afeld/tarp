module TracerCaller
  def self.called_directly_from_test?
    Tarp::Tracer.called_directly_from_test?
  end
end
