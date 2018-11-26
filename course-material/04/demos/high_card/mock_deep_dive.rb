require 'rspec/mocks'

include ::RSpec::Mocks::ExampleMethods

# Mock setup
::RSpec::Mocks.setup

begin
  # Test
  obj = Object.new
  expect(obj).to receive(:hello)
  obj.hello

  # Mock verification
  ::RSpec::Mocks.verify
ensure
  # Mock teardown
  ::RSpec::Mocks.teardown
end

obj.hello
