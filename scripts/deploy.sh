#!/bin/bash

# Deploy script
# Deployment helper script

set -e

# Configuration
ENVIRONMENT=${1:-development}
DOCKER_REGISTRY=${DOCKER_REGISTRY:-registry.example.com}
IMAGE_NAME="professional-project"
VERSION=$(npm run --silent get-version 2>/dev/null || echo "$(date +%s)")

echo "🚀 Deploying to $ENVIRONMENT environment..."
echo "📦 Image: $DOCKER_REGISTRY/$IMAGE_NAME:$VERSION"

# Validate environment
case $ENVIRONMENT in
    development|dev)
        echo "🔨 Development deployment"
        docker-compose -f docker-compose.yml up -d
        ;;
    staging)
        echo "🧪 Staging deployment"
        docker build -t "$DOCKER_REGISTRY/$IMAGE_NAME:$VERSION" .
        docker push "$DOCKER_REGISTRY/$IMAGE_NAME:$VERSION"
        echo "✅ Pushed to staging registry"
        ;;
    production|prod)
        echo "🏢 Production deployment"
        read -p "⚠️  Are you sure you want to deploy to production? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            docker build -t "$DOCKER_REGISTRY/$IMAGE_NAME:$VERSION" .
            docker tag "$DOCKER_REGISTRY/$IMAGE_NAME:$VERSION" "$DOCKER_REGISTRY/$IMAGE_NAME:latest"
            docker push "$DOCKER_REGISTRY/$IMAGE_NAME:$VERSION"
            docker push "$DOCKER_REGISTRY/$IMAGE_NAME:latest"
            echo "✅ Pushed to production registry"
        else
            echo "❌ Deployment cancelled"
            exit 1
        fi
        ;;
    *)
        echo "❌ Unknown environment: $ENVIRONMENT"
        echo "Usage: ./deploy.sh [development|staging|production]"
        exit 1
        ;;
esac

echo "✅ Deployment completed!"
