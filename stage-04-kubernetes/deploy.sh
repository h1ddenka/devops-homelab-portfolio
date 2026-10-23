#!/bin/bash
# deploy.sh
# Скрипт деплоя приложения в локальный кластер K3s

VM_USER="devops"
VM_IP="192.168.227.128"
IMAGE_NAME="homelab-webapp:latest"
IMAGE_TAR="/tmp/webapp-k3s.tar"

echo "[1/4] Building Docker image locally..."
docker build -t ${IMAGE_NAME} ./app

echo "[2/4] Saving image to tar archive..."
docker save ${IMAGE_NAME} -o ${IMAGE_TAR}

echo "[3/4] Copying image and manifests to VM..."
scp ${IMAGE_TAR} ${VM_USER}@${VM_IP}:/tmp/
scp -r ./manifests ${VM_USER}@${VM_IP}:~/k8s-manifests/

echo "[4/4] Importing image to K3s and applying manifests..."
ssh ${VM_USER}@${VM_IP} "sudo k3s ctr images import --all-platforms /tmp/webapp-k3s.tar && \
                           kubectl apply -f ~/k8s-manifests/"

echo "Deployment complete. Check http://${VM_IP}:30080"