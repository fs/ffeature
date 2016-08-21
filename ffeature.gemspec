lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "ffeature/version"

Gem::Specification.new do |s|
  s.name        = "ffeature"
  s.version     = FFeature::VERSION
  s.authors     = ["Timur Vafin"]
  s.email       = ["timur.vafin@flatstack.com"]
  s.homepage    = "https://github.com/fs/flipper-helper"
  s.summary     = "Flipper Helper"
  s.description = "Flipper Helper"
  s.license     = "MIT"

  s.files = Dir["lib/**/*", "README.md"]

  s.add_dependency "activesupport"
  s.add_dependency "flipper"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "bundler-audit"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "rubocop-rspec"
end
