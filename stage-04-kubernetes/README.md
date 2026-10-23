# Stage 04: Kubernetes (K3s)

## Цель
Освоить оркестрацию контейнеров с помощью Kubernetes.

## Что было сделано
- [x] Установка K3s (легковесный Kubernetes) на Ubuntu Server
- [x] Настройка kubectl для пользователя devops
- [x] Создание Deployment с liveness/readiness пробами
- [x] Создание NodePort Service для доступа к приложению
- [x] Настройка resource limits (CPU, RAM)
- [x] Импорт локального Docker-образа в containerd (k3s ctr)
- [x] Масштабирование приложения (1 → 3 реплики)

## Артефакты
- `manifests/deployment.yaml` — манифест Deployment с health probes
- `manifests/service.yaml` — манифест NodePort Service
- `deploy.sh` — скрипт автоматического деплоя

## Как запустить
```bash
./deploy.sh
```
Приложение будет доступно по http://192.168.227.128:30080

## Масштабирование
```bash
kubectl scale deployment webapp-deployment --replicas=3
```
