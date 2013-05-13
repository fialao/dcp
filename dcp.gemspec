# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dcp/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'dcp'
  gem.version       = Dcp::VERSION

  gem.authors       = ['Ondra Fiala']
  gem.email         = ['ondra.fiala@gmail.com']
  gem.description   = %q{Discovery and basic Configuration Protocol}
  gem.summary       = gem.description
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  # Gem dependencies
  gem.add_dependency 'packetfu'
  gem.add_dependency 'pcaprub'

  # CLI
  gem.add_dependency 'thor'

  # Behaviour Driven Development and Testing
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fuubar'

  # Documentation
  gem.add_development_dependency 'yard'  
end
