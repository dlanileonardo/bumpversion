# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bumpversion/version'

Gem::Specification.new do |spec|
  spec.name          = 'bumpversion'
  spec.version       = Bumpversion::VERSION
  # spec.default_executable = "bumpversion"
  spec.authors       = ['Dlani Mendes']
  spec.email         = ['dlanileonardo@gmail.com']
  spec.date = `date +"%Y-%m-%d"`.strip!

  spec.summary       = 'Auto Bump Version to any project'
  spec.description   = 'Bump version by params or config file with Hooks! :).'
  spec.homepage      = 'https://github.com/dlanileonardo/bumpversion'
  spec.license       = 'MIT'

  spec.files         = Dir["{bin,lib,man,spec}/**/*", "Rakefile", "README.md"]
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency("optimist", ["~> 3.0"])
  spec.add_runtime_dependency("parseconfig", ["~> 1.0"])
  spec.add_runtime_dependency("colorize", ["~> 0.7"])
  spec.add_runtime_dependency("git", '>= 1.2.9', '< 3.0')
end
