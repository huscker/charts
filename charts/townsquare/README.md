# Townsquare

A self-hosted web app for running [Blood on the Clocktower](https://bloodontheclocktower.com/) games — a Storyteller grimoire and player view in one.

## Introduction

Townsquare provides a digital grimoire for the Storyteller and a live-synced player view over WebSocket. It supports official editions, custom scripts, fabled characters, and live session management.

## Prerequisites

- Kubernetes 1.21+
- Helm 3.8+
- An ingress controller (e.g. ingress-nginx) if exposing externally

## Installing the Chart

```bash
helm repo add huscker https://huscker.github.io/charts/
helm repo update
helm install townsquare huscker/townsquare -n townsquare --create-namespace
```

## Configuration

| Parameter | Description | Default |
|---|---|---|
| `frontend.image.tag` | Frontend image tag | `""` |
| `backend.image.tag` | Backend image tag | `""` |
| `frontend.runtimeConfig.wsUrl` | Override WebSocket URL (leave empty to auto-derive from page origin) | `""` |
| `frontend.runtimeConfig.defaultLanguage` | Default UI language (`en` or `ru`) | `""` |
| `backend.server.allowedOrigins` | Regex of allowed WebSocket origins | `""` |
| `ingress.enabled` | Enable ingress | `false` |
| `ingress.hostname` | Hostname for the ingress | `""` |
| `ingress.tls` | Enable TLS | `false` |

### Example values

```yaml
frontend:
  image:
    tag: "2.16.5"
  runtimeConfig:
    defaultLanguage: "en"

backend:
  image:
    tag: "2.16.5"
  server:
    allowedOrigins: "^https?://(yourdomain\\.example\\.com|localhost)"

ingress:
  enabled: true
  ingressClassName: nginx
  hostname: townsquare.example.com
  tls: true
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt
```

### WebSocket origins

The backend validates the `Origin` header against `allowedOrigins` (a regex). If left empty, all origins are allowed. For production deployments set it to your domain:

```yaml
backend:
  server:
    allowedOrigins: "^https://townsquare\\.example\\.com$"
```

## Changelog

See the [CHANGELOG](https://github.com/huscker/townsquare/blob/develop/CHANGELOG.md) for release notes.

## Source

- App: [huscker/townsquare](https://github.com/huscker/townsquare)
- Chart: [huscker/charts/tree/main/charts/townsquare](https://github.com/huscker/charts/tree/main/charts/townsquare)
