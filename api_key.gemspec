# -*- encoding: utf-8 -*-
require File.expand_path('../lib/api_key/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Aaron Kromer"]
  gem.description   = %q{Mix-in for providing general support for working with standard Web API Keys}
  gem.summary       = %q{Web API Key support mix-in}
  gem.homepage      = "https://github.com/cupakromer/api_key"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"

  gem.has_rdoc      = true
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "api_key"
  gem.require_paths = ["lib"]
  gem.version       = APIKey::VERSION
end
