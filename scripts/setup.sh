#!/bin/bash

# Setup script for development environment
# This script sets up the development environment for local development

set -e

echo "🚀 Setting up development environment..."

# Check for required tools
echo "📋 Checking for required tools..."

if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 16+ and try again."
    exit 1
fi

if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm and try again."
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git and try again."
    exit 1
fi

echo "✅ All required tools are installed."
echo "   Node.js: $(node --version)"
echo "   npm: $(npm --version)"
echo "   Git: $(git --version)"

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
npm install

# Set up environment variables
echo ""
echo "🔐 Setting up environment variables..."
if [ ! -f .env ]; then
    cp .env.example .env
    echo "✅ Created .env file from .env.example"
    echo "⚠️  Please update .env with your actual configuration values"
else
    echo "✅ .env file already exists"
fi

# Create necessary directories
echo ""
echo "📁 Creating necessary directories..."
mkdir -p src
mkdir -p dist
mkdir -p coverage
echo "✅ Directories created"

# Initialize git hooks (if using husky)
echo ""
echo "🪝 Setting up git hooks..."
if [ -f "package.json" ] && grep -q "husky" package.json; then
    npm run prepare 2>/dev/null || true
    echo "✅ Git hooks configured"
else
    echo "⚠️  Husky not installed. Run 'npm install husky --save-dev' to enable git hooks"
fi

# Run type checking and linting
echo ""
echo "🔍 Running type check and linting..."
npm run type-check || echo "⚠️  Type check issues found (this is okay for setup)"
npm run lint || echo "⚠️  Linting issues found (this is okay for setup)"

echo ""
echo "✅ Development environment setup complete!"
echo ""
echo "📝 Next steps:"
echo "   1. Review and update .env with your configuration"
echo "   2. Run: npm run dev"
echo "   3. Visit: http://localhost:3000"
echo ""
echo "📚 For more information, see docs/development/README.md"
