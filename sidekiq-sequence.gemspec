# frozen_string_literal: true

require_relative 'lib/sidekiq/sequence/version'

Gem::Specification.new do |spec|
  spec.name          = 'sidekiq-sequence'
  spec.version       = Sidekiq::Sequence::VERSION
  spec.authors       = ['Joel Moss']
  spec.email         = ['joel@developwithstyle.com']

  spec.summary       = 'Sequential Sidekiq jobs'
  spec.description   = 'Create and manage sequential jobs in Sidekiq'
  spec.homepage      = 'https://github.com/joelmoss/sidekiq-sequence'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 6'
  spec.add_dependency 'railties', '>= 6'
end
