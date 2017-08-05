# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sequence_diagram/version"

Gem::Specification.new do |spec|
  spec.name          = "sequence_diagram"
  spec.version       = SequenceDiagram::VERSION
  spec.authors       = ["John Sloan"]
  spec.email         = ["jwsloan@gmail.com"]

  spec.summary       = "Outputs markdown that can be used to generate sequence diagrams"
  spec.homepage      = "https://github.com/nash-rb/sequence-diagram-rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "rubocop", "~> 0.47.1"
end
