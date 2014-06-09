require 'bundler'
Bundler.setup
require 'resque-assurances'
require 'resque_spec'
require_relative 'support/test_worker'
require_relative 'support/unique_worker'
require_relative 'support/another_unique_worker'
require_relative 'support/persisted_worker'

RSpec.configure do |config|
  config.before(:each) do
    ResqueSpec.reset!
    Resque::Assurances.reset!
  end
end
