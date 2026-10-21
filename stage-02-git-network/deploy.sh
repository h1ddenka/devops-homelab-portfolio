#!/bin/bash
# deploy.sh
# Скрипт для копирования веб-файлов на ВМ и запуска простого HTTP-сервера

VM_USER="devops"
VM_IP="192.168.227.128"
REMOTE_DIR="/home/devops/webapp"

echo "Copying files to VM..."
scp -r ./app ${VM_USER}@${VM_IP}:${REMOTE_DIR}

echo "Stopping old Python HTTP server..."
ssh ${VM_USER}@${VM_IP} "pkill -f 'python3 -m http.server' || true"

echo "Starting Python HTTP server on VM in background..."
ssh -f ${VM_USER}@${VM_IP} "cd ${REMOTE_DIR} && nohup python3 -m http.server 8080 </dev/null >/dev/null 2>&1 &"

echo "Deployment complete. Check http://${VM_IP}:8080"