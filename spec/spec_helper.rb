# SimpleCov and https://coveralls.io
require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

# Include DCP library
require File.join(File.dirname(__FILE__), '../lib/dcp')

# Include factories and support
Dir.glob(File.join(File.dirname(__FILE__), 'support/**', '*.rb')) { |f| require f }
