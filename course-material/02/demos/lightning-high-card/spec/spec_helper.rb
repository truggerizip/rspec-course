require 'tmpdir'

RSpec.configure do |config|
  config.warnings = true
  config.before(:example, acceptance: true) do
  end
end
