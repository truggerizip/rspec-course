require 'tmpdir'
require 'high_card'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    # This option should be set when all dependencies are being loaded
    # before a spec run, as is the case in a typical spec helper. It will
    # cause any verifying double instantiation for a class that does not
    # exist to raise, protecting against incorrectly spelt names.
    mocks.verify_doubled_constant_names = true
  end
  config.warnings = true
  config.before(:example, acceptance: true) do
  end
end
