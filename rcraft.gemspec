# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rcraft/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeff Casimir"]
  gem.email         = ["jeff@jumpstartlab.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rcraft"
  gem.require_paths = ["lib"]
  gem.version       = Rcraft::VERSION
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "ruby_gntp"
  gem.add_development_dependency "debugger"
end
