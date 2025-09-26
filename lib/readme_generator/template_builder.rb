require 'erb'

module ReadmeGenerator
  class TemplateBuilder
    def initialize(project_info, options = {})
      @project_info = project_info
      @options = options
    end

    def build
      # Smart template selection: Choose template based on project type
      template_name = @options[:template] || @project_info[:type] || 'basic'
      template_path = File.join(templates_dir, "#{template_name}.erb")
      
      # Fall back to basic template if specified template doesn't exist
      unless File.exist?(template_path)
        template_path = File.join(templates_dir, 'basic.erb')
      end

      template_content = File.read(template_path)
      erb = ERB.new(template_content)
      
      # Simple binding with project name
      project_name = @options[:project_name] || @project_info[:name] || 'My Project'
      erb.result(binding)
    end

    private

    def templates_dir
      File.join(File.dirname(__FILE__), 'templates')
    end
  end
end
