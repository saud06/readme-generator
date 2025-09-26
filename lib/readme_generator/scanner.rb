module ReadmeGenerator
  class Scanner
    def initialize(project_path)
      @project_path = File.expand_path(project_path)
    end

    def scan
      {
        name: File.basename(@project_path),
        type: detect_simple_type,
        language: detect_simple_language,
        recommended_template: 'basic'
      }
    end

    private

    def detect_simple_type
      # Check for specific frameworks first
      return 'nextjs' if File.exist?(File.join(@project_path, 'next.config.js'))
      return 'nuxtjs' if File.exist?(File.join(@project_path, 'nuxt.config.js'))
      return 'laravel' if File.exist?(File.join(@project_path, 'artisan'))
      return 'flask' if File.exist?(File.join(@project_path, 'app.py'))
      
      # Check package.json for JS frameworks
      if File.exist?(File.join(@project_path, 'package.json'))
        package_content = File.read(File.join(@project_path, 'package.json'))
        return 'react' if package_content.include?('react') && !package_content.include?('next')
        return 'vue' if package_content.include?('vue') && !package_content.include?('nuxt')
        return 'nodejs'
      end
      
      # Check for Python
      return 'python' if File.exist?(File.join(@project_path, 'requirements.txt'))
      return 'ruby' if File.exist?(File.join(@project_path, 'Gemfile'))
      
      'basic'
    end

    def detect_simple_language
      return 'JavaScript' if File.exist?(File.join(@project_path, 'package.json'))
      return 'Python' if File.exist?(File.join(@project_path, 'requirements.txt'))
      return 'PHP' if File.exist?(File.join(@project_path, 'composer.json'))
      return 'Ruby' if File.exist?(File.join(@project_path, 'Gemfile'))
      'Unknown'
    end
  end
end
