# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elastip/version'

Gem::Specification.new do |spec|
  spec.name          = "elastip"
  spec.version       = Elastip::VERSION
  spec.authors       = ["pcboy"]
  spec.email         = ["david.hagege@gmail.com"]

  spec.summary       = %q{Elastip helps you find the ip addresses of your elastic beanstalk instances easily}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/pcboy/elastip"
  spec.license       = "WTFPL"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "awesome_print", "~> 1.7"
  spec.add_development_dependency "mocha", "~> 1.2"

  spec.add_dependency "aws-sdk", "~> 2.7"
end
