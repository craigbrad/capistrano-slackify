# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-slackify'
  spec.version       = '2.3.0'
  spec.authors       = ['seenmyfate']
  spec.email         = ['seenmyfate@gmail.com']
  spec.summary       = %q{Publish deployment notifications to Slack via the incoming webhooks integration}
  spec.description   = %q{Publish deployment notifications to Slack via the incoming webhooks integration}
  spec.homepage      = 'https://github.com/onthebeach/capistrano-slackify'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'capistrano', '>= 3.1.0'
  spec.add_runtime_dependency 'multi_json'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
