describe Tarp::Tracer do
  describe '.called_directly_from_test?' do
    it "returns true when called from this file" do
      expect(Tarp::Tracer.called_directly_from_test?).to eq(true)
    end

    it "returns false when the caller is a file between the test and the method" do
      expect(TracerCaller.called_directly_from_test?).to eq(false)
    end
  end
end
