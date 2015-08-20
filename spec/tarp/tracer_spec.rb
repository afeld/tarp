describe Tarp::Tracer do
  describe '.called_directly_from_test?' do
    it "returns true when called from this file" do
      expect(Tarp::Tracer.called_directly_from_test?).to eq(true)
    end
  end
end
