# readme-gen

A simple CLI tool to generate README.md files for your projects.

## Installation

First, clone and build:
```bash
git clone https://github.com/saud06/readme-generator.git
cd readme-generator
gem build readme_generator.gemspec
```

### 🍎 **macOS Users**

**Recommended: System-wide install**
```bash
sudo gem install ./readme_generator-1.0.0.gem --verbose
```

**Alternative: User install (no password)**
```bash
gem install --user-install ./readme_generator-1.0.0.gem --verbose
echo 'export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 🐧 **Linux Users**

**Recommended: User install**
```bash
gem install --user-install ./readme_generator-1.0.0.gem --verbose
echo 'export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**Alternative: System-wide install**
```bash
sudo gem install ./readme_generator-1.0.0.gem --verbose
```

### 🪟 **Windows Users**

**Recommended: User install**
```bash
gem install --user-install ./readme_generator-1.0.0.gem --verbose
echo 'export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
```

**Alternative: Using bundler**
```bash
echo "gem 'readme_generator', path: '.'" > Gemfile.local
bundle install --gemfile=Gemfile.local
# Use with: bundle exec readme-gen
```

**Test the installation:**
```bash
readme-gen version
# Should output: README Generator v1.0.0

readme-gen help
# Should show available commands
```

## Troubleshooting

### 🍎 **macOS Issues**

❌ **"You don't have write permissions"**
```bash
# Use the alternative user install method above
```

❌ **"command not found: readme-gen"**
```bash
# Add to PATH and restart terminal:
echo 'export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 🐧 **Linux Issues**

❌ **"command not found: readme-gen"**
```bash
# Add to PATH:
echo 'export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

❌ **Permission denied**
```bash
# Use user install method above (recommended for Linux)
```

### 🪟 **Windows Issues**

❌ **"command not found: readme-gen"**
```bash
# Add to PATH:
echo 'export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
# Then restart Git Bash/terminal
```

❌ **Ruby/Gem not found**
```bash
# Install Ruby first: https://rubyinstaller.org/
# Then follow Windows installation steps above
```

### 🔧 **Universal Solutions**

❌ **Still having issues?**
```bash
# Run without installing (works on all platforms):
ruby exe/readme-gen version
ruby exe/readme-gen help
```

❌ **"No such file or directory"**
```bash
# Make sure you built the gem first:
gem build readme_generator.gemspec
ls *.gem  # Should show readme_generator-1.0.0.gem
```

### Option 2: Run Locally (Without Installing)

```bash
# Clone the repository
git clone https://github.com/saud06/readme-generator.git
cd readme-generator

# Run commands directly
ruby exe/readme-gen version
ruby exe/readme-gen help
```

## Usage

### Create a Basic README

Navigate to your project directory and run:

```bash
# If installed as gem
readme-gen init

# If running locally
ruby /path/to/readme-generator/exe/readme-gen init
```

This creates a simple README.md with basic sections.

### Generate README with Templates

```bash
# Generate with automatic template detection
readme-gen generate

# Use specific template
readme-gen generate --template basic
```

### Available Commands

- `readme-gen version` - Show version information
- `readme-gen help` - Show all available commands
- `readme-gen init` - Create a basic README.md file
- `readme-gen generate [--template TEMPLATE]` - Generate README with templates

### Available Templates

- **`basic`** - Simple README template for any project
- **`nodejs`** - Template for Node.js projects
- **`react`** - Template for React applications
- **`nextjs`** - Template for Next.js applications
- **`vue`** - Template for Vue.js applications
- **`nuxtjs`** - Template for Nuxt.js applications
- **`python`** - Template for Python projects
- **`flask`** - Template for Flask applications
- **`laravel`** - Template for Laravel applications

### Examples

```bash
# Create a basic README
mkdir my-project && cd my-project
readme-gen init

# React application
readme-gen generate --template react

# Next.js application  
readme-gen generate --template nextjs

# Python project
readme-gen generate --template python

# Flask application
readme-gen generate --template flask

# Laravel application
readme-gen generate --template laravel

# Auto-detect project type
readme-gen generate
```

## Development

```bash
git clone https://github.com/saud06/readme-generator.git
cd readme-generator
bundle install
```


## License

This project is licensed under the MIT License.
