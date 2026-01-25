#!/bin/bash

# Test runner script
# Run tests with various options

set -e

# Parse arguments
TEST_WATCH=false
COVERAGE=false
VERBOSE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -w|--watch)
            TEST_WATCH=true
            shift
            ;;
        -c|--coverage)
            COVERAGE=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: ./test.sh [-w|--watch] [-c|--coverage] [-v|--verbose]"
            exit 1
            ;;
    esac
done

echo "🧪 Running tests..."

if [ "$COVERAGE" = true ]; then
    echo "📊 Running tests with coverage report..."
    npm run test:coverage
elif [ "$TEST_WATCH" = true ]; then
    echo "👀 Running tests in watch mode..."
    npm run test:watch
else
    echo "🏃 Running tests..."
    npm test
fi

if [ "$COVERAGE" = true ]; then
    echo ""
    echo "✅ Coverage report generated in ./coverage"
fi

echo "✅ Tests completed successfully!"
