# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'slackr/version'

Gem::Specification.new do |spec|
  spec.name          = "slackr"
  spec.version       = Slackr::VERSION
  spec.authors       = ["Jason Perkins"]
  spec.email         = ["jperkins@me.com"]
  spec.description   = %q{Talk to slack.com chat platform from ruby}
  spec.summary       = %q{Send data into Slack in real-time, via the Incoming Webhooks API}
  spec.homepage      = "https://github.com/risk-io/slackr"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "webmock", "~> 1.18"
end
