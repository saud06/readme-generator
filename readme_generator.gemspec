require_relative 'lib/readme_generator/version'

Gem::Specification.new do |spec|
  spec.name = 'readme_generator'
  spec.version = ReadmeGenerator::VERSION
  spec.authors = ['Saud M.']
  spec.email = ['saud.mn6@gmail.com']

  spec.summary = 'A simple CLI tool to generate README.md files'
  spec.description = 'Generate README files for your projects with templates'
  spec.homepage = 'https://github.com/saud06/readme-generator'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.files = Dir['lib/**/*'] + Dir['exe/*'] + ['README.md', 'LICENSE']
  spec.bindir = 'exe'
  spec.executables = ['readme-gen']
  spec.require_paths = ['lib']

  spec.add_dependency 'thor', '~> 1.2'
end
