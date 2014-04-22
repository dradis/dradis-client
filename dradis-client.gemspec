# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dradis/client/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'dradis-client'
  spec.version       = Dradis::Client::VERSION
  spec.authors       = ['Daniel Martin']
  spec.email         = ['<etd@nomejortu.com>']
  spec.description   = %q{A Ruby wrapper for the Dradis API.}
  spec.summary       = %q{Dradis API wrapper}
  spec.homepage      = 'http://dradisframework.org'
  spec.license       = 'GPL2'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # gem.add_runtime_dependency 'faraday', '~> 0.8'
  # see https://github.com/technoweenie/faraday/commit/b0d9a144596e96861a18d68f2418b7d74e7b791d
  spec.add_runtime_dependency 'faraday', '~> 0.8'

  # Rails 3 seems to depend on ~> 1.0 of multi_json
  spec.add_runtime_dependency 'multi_json', '~> 1.0'

  spec.add_development_dependency 'rake', '~> 0.8'
  spec.add_development_dependency 'rspec', '~> 2.8'
  spec.add_development_dependency 'webmock'
end
