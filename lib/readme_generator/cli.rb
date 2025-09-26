require 'thor'

module ReadmeGenerator
  class CLI < Thor
    include Thor::Actions

    def self.exit_on_failure?
      true
    end

    desc 'version', 'Show version information'
    def version
      puts "README Generator v#{ReadmeGenerator::VERSION}"
    end

    desc 'generate [PATH]', 'Generate README.md for the project'
    option :template, type: :string, aliases: '-t', desc: 'Template type (basic, nodejs, react, nextjs, vue, nuxtjs, python, flask, laravel)'
    def generate(path = Dir.pwd)
      project_path = File.expand_path(path)

      unless Dir.exist?(project_path)
        puts "Error: Directory '#{path}' does not exist."
        exit 1
      end

      readme_path = File.join(project_path, 'README.md')
      if File.exist?(readme_path)
        print "README.md already exists. Overwrite? (y/N): "
        return unless gets.chomp.downcase == 'y'
      end

      puts "Generating README.md..."
      
      begin
        generator = Generator.new(project_path, { template: options[:template] })
        output_path = generator.generate

        puts "✅ README.md generated successfully at: #{output_path}"
      rescue StandardError => e
        puts "❌ Error: #{e.message}"
        exit 1
      end
    end

    desc 'init', 'Create a basic README.md file'
    def init
      project_name = File.basename(Dir.pwd)
      
      puts "Creating README.md for: #{project_name}"
      
      readme_path = File.join(Dir.pwd, 'README.md')
      if File.exist?(readme_path)
        print "README.md already exists. Overwrite? (y/N): "
        return unless gets.chomp.downcase == 'y'
      end

      generator = Generator.new(Dir.pwd, { project_name: project_name })
      output_path = generator.generate

      puts "✅ README.md created at: #{output_path}"
    end

  end
end
