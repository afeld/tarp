require_relative '../lib/tarp'

Dir.glob('./fixtures/*') { |f| require f }

RSpec.configure do |config|
  config.after(:each) do
    Tarp::Tracer.disable
    Tarp::Tracer.reset
  end
end
