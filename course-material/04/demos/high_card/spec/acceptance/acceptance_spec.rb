require 'spec_helper'
require 'pty'
require 'high_card'

BIN = File.expand_path("../../../bin/play", __FILE__)

describe 'acceptance', :acceptance do
  def run_app(seed = 1, &block)
    dir = Dir.tmpdir + '/highcard_test_state'
    `rm -Rf #{dir}`
    `mkdir -p #{dir}`
    ENV['HIGHCARD_DIR'] = dir
    PTY.spawn(BIN, seed.to_s, &block)
  end

  example 'it works' do
    run_app do |output, input, pid|
      sleep 1.5

      input.write("y\n")

      sleep 0.5

      buffer = output.read_nonblock(1024)
      expect(buffer).to include("You won").or include("You lost")
    end
  end
end
