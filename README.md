# DevOps Homelab Portfolio

Мой путь в DevOps. Этот репозиторий содержит все артефакты, 
созданные в процессе обучения и построения локальной лаборатории.

## Конфигурация стенда
- **CPU**: AMD Ryzen 7 7800X3D
- **GPU**: NVIDIA RTX 4070 Ti Super
- **RAM**: 32 GB DDR5
- **Storage**: 2 TB NVMe SSD
- **Hypervisor**: VMware Workstation Pro
- **Guest OS**: Ubuntu Server 24.04 LTS

## Этапы обучения
- [x] Stage 01: Linux & Bash
- [x] Stage 02: Git & Networking
- [x] Stage 03: Docker
- [x] Stage 04: Kubernetes
- [x] Stage 05: IaC (Ansible)
- [x] Stage 06: CI/CD (GitHub Actions)
- [x] Stage 07: Monitoring (Prometheus, Grafana)

## CI/CD Pipeline

Проект использует GitHub Actions для автоматизации проверки кода при каждом Push или Pull Request в ветку `main`.

### Этапы пайплайна (`.github/workflows/ci-cd.yml`)

| Job | Шаг | Инструмент | Что проверяет |
|-----|-----|-----------|---------------|
| Lint Infrastructure Code | Lint Ansible playbooks | ansible-lint (profile: production) | FQCN, идемпотентность |
| Lint Infrastructure Code | Lint Dockerfile | hadolint | Безопасность и оптимальность Dockerfile |
| Build and Validate Manifests | Build Docker image | Docker Buildx | Корректность сборки образа |
| Build and Validate Manifests | Validate Kubernetes manifests | kubeconform (strict) | Валидность K8s манифестов против официальных схем |

Статус пайплайна: [![CI/CD](https://github.com/h1ddenka/devops-homelab-portfolio/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/h1ddenka/devops-homelab-portfolio/actions/workflows/ci-cd.yml)
