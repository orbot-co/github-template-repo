# Kubernetes Deployment Guide

## Overview

This directory contains Kubernetes manifests for deploying the application to a Kubernetes cluster.

## Files

- `deployment.yaml` - Application deployment configuration
- `service.yaml` - Kubernetes service for exposing the application
- `configmap.yaml` - Configuration and secrets management
- `ingress.yaml` - Ingress configuration for routing
- `rbac.yaml` - Role-based access control configuration
- `hpa.yaml` - Horizontal Pod Autoscaler configuration

## Prerequisites

- Kubernetes cluster (1.19+)
- kubectl CLI tool
- Docker registry access
- Optional: cert-manager for SSL certificates

## Deployment

### 1. Create Namespace (optional)

```bash
kubectl create namespace production
```

### 2. Apply Configurations

```bash
# Deploy all manifests
kubectl apply -f kubernetes/

# Or deploy individually
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/configmap.yaml
kubectl apply -f kubernetes/ingress.yaml
kubectl apply -f kubernetes/rbac.yaml
kubectl apply -f kubernetes/hpa.yaml
```

### 3. Verify Deployment

```bash
# Check deployment status
kubectl get deployment app-deployment
kubectl get pods -l app=professional-project

# View logs
kubectl logs -l app=professional-project -f

# Check service
kubectl get svc app-service
```

## Configuration

### Update Docker Image

Edit `deployment.yaml` and update the image:

```yaml
image: your-registry.com/professional-project:v1.0.0
```

### Update Secrets

Edit `configmap.yaml` with your actual values:

```bash
kubectl edit secret app-secrets -n default
```

### Update Ingress Domain

Edit `ingress.yaml` and replace `example.com` with your domain.

## Scaling

The application uses Horizontal Pod Autoscaler (HPA) for automatic scaling:

- **Min Replicas**: 2
- **Max Replicas**: 10
- **CPU Target**: 70%
- **Memory Target**: 80%

### Manual Scaling

```bash
kubectl scale deployment app-deployment --replicas=5
```

## Monitoring

### View Metrics

```bash
kubectl top nodes
kubectl top pods
```

### View Events

```bash
kubectl get events --sort-by='.lastTimestamp'
```

## Troubleshooting

### Pod Won't Start

```bash
# Check pod status
kubectl describe pod <pod-name>

# View logs
kubectl logs <pod-name>
```

### Service Not Accessible

```bash
# Check service
kubectl describe svc app-service

# Check ingress
kubectl describe ingress app-ingress
```

### Update Image

```bash
kubectl set image deployment/app-deployment \
  app=your-registry.com/professional-project:v1.1.0
```

## Rollback

```bash
# View rollout history
kubectl rollout history deployment/app-deployment

# Rollback to previous version
kubectl rollout undo deployment/app-deployment

# Rollback to specific revision
kubectl rollout undo deployment/app-deployment --to-revision=2
```

## Cleanup

```bash
# Delete all resources
kubectl delete -f kubernetes/

# Or delete deployment only
kubectl delete deployment app-deployment
```

## Further Reading

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/)
