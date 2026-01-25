#!/bin/bash

# Build script
# Builds the application for production

set -e

echo "🏗️  Building application..."

# Clean previous build
echo "🧹 Cleaning previous builds..."
rm -rf dist/
echo "✅ Cleaned"

# Type check
echo "📝 Running type check..."
npm run type-check || echo "⚠️  Type check warnings (continuing...)"

# Lint
echo "🔍 Linting code..."
npm run lint || echo "⚠️  Lint warnings (continuing...)"

# Build
echo "📦 Building application..."
npm run build

# File size report
echo ""
echo "📊 Build size report:"
du -sh dist/ || true

echo ""
echo "✅ Build completed successfully!"
echo "📁 Output directory: ./dist"
