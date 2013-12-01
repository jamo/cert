# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cert_open_data_visualizer/version'

Gem::Specification.new do |spec|
  spec.name          = "cert_open_data_visualizer"
  spec.version       = CertOpenDataVisualizer::VERSION
  spec.authors       = ["Jarmo Isotalo"]
  spec.email         = ["jamo@isotalo.fi"]
  spec.description   = %q{Write a gem description}
  spec.summary       = %q{Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.12.0 "
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
