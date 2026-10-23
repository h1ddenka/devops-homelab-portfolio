#!/bin/bash
# deploy.sh
# Скрипт деплоя приложения в локальный кластер K3s
# Образ собирается прямо на ВМ, где установлен Docker

VM_USER="devops"
VM_IP="192.168.227.128"
IMAGE_NAME="homelab-webapp:latest"

echo "[1/3] Copying Dockerfile, app and manifests to VM..."
scp ./app/Dockerfile ./app/index.html ${VM_USER}@${VM_IP}:/tmp/
scp -r ./manifests ${VM_USER}@${VM_IP}:~/k8s-manifests/

echo "[2/3] Building image on VM and importing to K3s..."
ssh ${VM_USER}@${VM_IP} "cd /tmp && \
                           docker build -t ${IMAGE_NAME} . && \
                           docker save ${IMAGE_NAME} | sudo k3s ctr images import - && \
                           kubectl apply -f ~/k8s-manifests/"

echo "[3/3] Deployment complete. Check http://${VM_IP}:30080"