describe Tarp::Tracer do
  describe '.called_directly_from_test?' do
    it "returns true when called from this file" do
      expect(TracerCaller.direct).to eq(true)
    end

    it "returns false when the caller is a file between the test and the method" do
      expect(TracerCaller.indirect).to eq(false)
    end
  end

  it "doesn't hit on_method_call without being enabled" do
    expect(Tarp::Tracer).to_not receive(:on_method_call)
    global_method
  end

  describe '.enable' do
    it "executes on method calls" do
      expect(Tarp::Tracer).to receive(:on_method_call).at_least(:once)
      Tarp::Tracer.enable
      global_method
    end

    it "keeps track of called methods" do
      Tarp::Tracer.enable
      global_method
      Tarp::Tracer.disable

      expect(Tarp::Tracer::DIRECTLY_CALLED_METHODS.size).to eq(1)
      tm = Tarp::Tracer::DIRECTLY_CALLED_METHODS.first
      expect(tm).to be_a(Tarp::TraceMethod)
      expect(tm.method_name).to eq(:global_method)
    end
  end
end
