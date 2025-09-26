require_relative 'readme_generator/version'
require_relative 'readme_generator/cli'
require_relative 'readme_generator/scanner'
require_relative 'readme_generator/template_builder'
require_relative 'readme_generator/config_manager'

module ReadmeGenerator
  class Error < StandardError; end

  # Main entry point for the README Generator
  class Generator
    attr_reader :project_path, :options

    def initialize(project_path = Dir.pwd, options = {})
      @project_path = File.expand_path(project_path)
      @options = options
    end

    def generate(output_filename = 'README.md')
      scanner = Scanner.new(project_path)
      project_info = scanner.scan

      template_builder = TemplateBuilder.new(project_info, options)
      readme_content = template_builder.build

      output_path = File.join(project_path, output_filename)
      File.write(output_path, readme_content)

      output_path
    end
  end
end
