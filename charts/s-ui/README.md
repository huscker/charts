# S-UI Helm Chart

A Helm chart for [S-UI](https://github.com/alireza0/s-ui) — a web panel built on [SagerNet/Sing-Box](https://github.com/SagerNet/sing-box) for managing multi-protocol proxy services.

## Installing

```bash
helm repo add huscker https://huscker.github.io/charts/
helm repo update
helm install my-s-ui huscker/s-ui
```

## Parameters

### Image

| Name | Description | Default |
|------|-------------|---------|
| `image.registry` | Image registry | `docker.io` |
| `image.repository` | Image repository | `alireza7/s-ui` |
| `image.tag` | Image tag | `1.5.3` |
| `image.pullPolicy` | Pull policy | `IfNotPresent` |

### Configuration

| Name | Description | Default |
|------|-------------|---------|
| `config.logLevel` | Log level (debug/info/warn/error) | `info` |
| `config.debug` | Enable debug mode | `false` |
| `config.singboxApi` | Singbox API endpoint | `""` |
| `config.timezone` | Container timezone | `Asia/Tehran` |

### Service

| Name | Description | Default |
|------|-------------|---------|
| `service.type` | Service type | `ClusterIP` |
| `service.panel.port` | Panel port | `2095` |
| `service.subscription.port` | Subscription port | `2096` |

### Persistence

| Name | Description | Default |
|------|-------------|---------|
| `persistence.enabled` | Enable database persistence | `true` |
| `persistence.size` | PVC size | `1Gi` |
| `certPersistence.enabled` | Enable cert persistence | `false` |
| `certPersistence.size` | Cert PVC size | `100Mi` |

### Ingress

| Name | Description | Default |
|------|-------------|---------|
| `ingress.enabled` | Enable ingress | `false` |
| `ingress.hostname` | Ingress hostname | `s-ui.local` |
| `ingress.tls` | Enable TLS | `false` |
| `ingress.subscription.enabled` | Enable subscription ingress | `false` |

## Quick Start with Port-Forwarding

```bash
helm install my-s-ui huscker/s-ui
kubectl port-forward svc/my-s-ui 2095:2095
# Open http://localhost:2095/app/
# Default credentials: admin / admin
```

## Ingress Example

```yaml
ingress:
  enabled: true
  ingressClassName: nginx
  hostname: s-ui.example.com
  path: /app/
  tls: true
  subscription:
    enabled: true
    hostname: s-ui.example.com
    path: /sub/
```
