module TracerCaller
  def self.direct
    Tarp::Tracer.called_directly_from_test?
  end

  def self.indirect
    self.direct
  end
end
