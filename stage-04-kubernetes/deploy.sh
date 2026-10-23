#!/bin/bash
# deploy.sh
# Скрипт деплоя приложения в локальный кластер K3s

VM_USER="devops"
VM_IP="192.168.227.128"
IMAGE_NAME="homelab-webapp:latest"
REMOTE_DIR="/home/devops/k8s-build"

echo "[1/3] Copying Dockerfile, app and manifests to VM..."
ssh ${VM_USER}@${VM_IP} "mkdir -p ${REMOTE_DIR} ${REMOTE_DIR}/manifests"
scp ./app/Dockerfile ./app/index.html ${VM_USER}@${VM_IP}:${REMOTE_DIR}/
scp ./manifests/deployment.yaml ${VM_USER}@${VM_IP}:${REMOTE_DIR}/manifests/
scp ./manifests/service.yaml ${VM_USER}@${VM_IP}:${REMOTE_DIR}/manifests/

echo "[2/3] Building image on VM and importing to K3s..."
ssh ${VM_USER}@${VM_IP} "cd ${REMOTE_DIR} && \
                           docker build -t ${IMAGE_NAME} . && \
                           docker save ${IMAGE_NAME} | sudo k3s ctr images import -"

echo "[3/3] Applying Kubernetes manifests..."
ssh ${VM_USER}@${VM_IP} "sudo kubectl apply -f ${REMOTE_DIR}/manifests/deployment.yaml -f ${REMOTE_DIR}/manifests/service.yaml"

echo "Deployment complete. Check http://${VM_IP}:30080"