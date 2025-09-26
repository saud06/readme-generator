require 'json'

module ReadmeGenerator
  class Scanner
    def initialize(project_path)
      @project_path = File.expand_path(project_path)
    end

    def scan
      base_info = {
        name: File.basename(@project_path),
        type: detect_project_type,
        language: detect_project_language,
        recommended_template: 'basic'
      }
      
      # Add enhanced package.json analysis for Node.js projects
      if File.exist?(File.join(@project_path, 'package.json'))
        package_info = analyze_package_json
        base_info.merge!(package_info)
      end
      
      base_info
    end

    private

    def detect_project_type
      # Use file-based detection first (highest priority)
      return 'nextjs' if File.exist?(File.join(@project_path, 'next.config.js'))
      return 'nuxtjs' if File.exist?(File.join(@project_path, 'nuxt.config.js'))
      return 'laravel' if File.exist?(File.join(@project_path, 'artisan'))
      return 'flask' if File.exist?(File.join(@project_path, 'app.py'))
      
      # For JavaScript projects, use smart dependency-based detection
      if File.exist?(File.join(@project_path, 'package.json'))
        return detect_js_framework_type
      end
      
      # Check for other languages
      return 'python' if File.exist?(File.join(@project_path, 'requirements.txt'))
      return 'ruby' if File.exist?(File.join(@project_path, 'Gemfile'))
      
      'basic'
    end

    # Smart JavaScript framework detection with priority system
    def detect_js_framework_type
      begin
        package_content = File.read(File.join(@project_path, 'package.json'))
        package_data = JSON.parse(package_content)
        deps = (package_data['dependencies'] || {}).merge(package_data['devDependencies'] || {})
        
        # Priority-based framework detection (most specific first)
        return 'nextjs' if deps.key?('next')
        return 'nuxtjs' if deps.key?('nuxt')
        
        # Check for full-stack patterns (React + Express = nodejs template)
        if deps.key?('react') && deps.key?('express')
          return 'nodejs'  # Full-stack app gets Node.js template
        end
        
        # Frontend frameworks
        return 'react' if deps.key?('react')
        return 'vue' if deps.key?('vue')
        
        # Check for Node.js server indicators
        if deps.key?('express') || deps.key?('koa') || deps.key?('fastify')
          return 'nodejs'
        end
        
        # Default to nodejs for any package.json project
        return 'nodejs'
        
      rescue JSON::ParserError => e
        puts "Warning: Could not parse package.json for framework detection - #{e.message}"
        return 'nodejs'  # Safe fallback
      end
    end

    def detect_project_language
      return 'JavaScript' if File.exist?(File.join(@project_path, 'package.json'))
      return 'Python' if File.exist?(File.join(@project_path, 'requirements.txt'))
      return 'PHP' if File.exist?(File.join(@project_path, 'composer.json'))
      return 'Ruby' if File.exist?(File.join(@project_path, 'Gemfile'))
      'Unknown'
    end

    # Enhanced package.json analysis
    def analyze_package_json
      package_path = File.join(@project_path, 'package.json')
      
      begin
        # Read and parse the JSON file
        package_content = File.read(package_path)
        package_data = JSON.parse(package_content)
        
        # Extract useful information using Ruby's safe navigation
        {
          description: package_data['description'] || 'A Node.js project',
          version: package_data['version'] || '1.0.0',
          author: extract_author_info(package_data['author']),
          dependencies: analyze_dependencies(package_data['dependencies'] || {}),
          scripts: extract_scripts(package_data['scripts'] || {}),
          main_file: package_data['main'] || 'index.js',
          keywords: package_data['keywords'] || []
        }
      rescue JSON::ParserError, Errno::ENOENT => e
        # If JSON is malformed or file doesn't exist, return defaults
        puts "Warning: Could not parse package.json - #{e.message}"
        {
          description: 'A Node.js project',
          version: '1.0.0',
          author: 'Unknown',
          dependencies: [],
          scripts: [],
          main_file: 'index.js',
          keywords: []
        }
      end
    end

    # Extract author information (can be string or object)
    def extract_author_info(author_data)
      case author_data
      when String
        author_data
      when Hash
        author_data['name'] || 'Unknown'
      else
        'Unknown'
      end
    end

    # Analyze dependencies to identify frameworks and tools
    def analyze_dependencies(deps)
      frameworks = []
      
      # Check for popular frameworks and libraries
      frameworks << 'React' if deps.key?('react')
      frameworks << 'Vue.js' if deps.key?('vue')
      frameworks << 'Angular' if deps.key?('@angular/core')
      frameworks << 'Express.js' if deps.key?('express')
      frameworks << 'Next.js' if deps.key?('next')
      frameworks << 'Nuxt.js' if deps.key?('nuxt')
      frameworks << 'TypeScript' if deps.key?('typescript')
      frameworks << 'Webpack' if deps.key?('webpack')
      frameworks << 'Vite' if deps.key?('vite')
      
      frameworks
    end

    # Extract and categorize npm scripts
    def extract_scripts(scripts)
      important_scripts = []
      
      # Look for common script patterns
      important_scripts << { name: 'start', command: scripts['start'] } if scripts['start']
      important_scripts << { name: 'dev', command: scripts['dev'] } if scripts['dev']
      important_scripts << { name: 'build', command: scripts['build'] } if scripts['build']
      important_scripts << { name: 'test', command: scripts['test'] } if scripts['test']
      important_scripts << { name: 'lint', command: scripts['lint'] } if scripts['lint']
      
      important_scripts
    end

  end
end
