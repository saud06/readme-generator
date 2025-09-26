# README Generator

An intelligent Ruby CLI tool that analyzes your projects and generates comprehensive README.md files automatically.

## Features

- **Smart Project Analysis**: Automatically detects project type (React, Next.js, Node.js, Python, etc.)
- **Package.json Parsing**: Extracts dependencies, scripts, author, and project metadata
- **Intelligent Template Selection**: Chooses optimal README template based on project structure
- **Multi-Framework Support**: Supports React, Next.js, Vue.js, Node.js, Python, Ruby, and more

## Technical Implementation

- **JSON Processing**: Advanced parsing with error handling and data validation
- **File System Operations**: Efficient file I/O and path manipulation
- **Data Structures**: Complex hash manipulation and merging strategies
- **Template Engine**: Dynamic content generation using ERB templating
- **Error Management**: Robust exception handling with graceful fallbacks

## Installation

### Clone and Build
```bash
git clone https://github.com/saud06/readme-generator.git
cd readme-generator
gem build readme_generator.gemspec
```

### macOS
```bash
gem install --user-install ./readme_generator-1.0.0.gem
```

### Linux
```bash
gem install --user-install ./readme_generator-1.0.0.gem
echo 'export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Windows
```bash
gem install --user-install ./readme_generator-1.0.0.gem
echo 'export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
```

## Usage

Generate a README for the current directory:
```bash
readme-gen
```

Generate a README for a specific project:
```bash
readme-gen /path/to/your/project
```

## License

MIT License
