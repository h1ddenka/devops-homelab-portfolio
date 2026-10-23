   #!/bin/bash
   # deploy.sh
   # Скрипт сборки и запуска Docker-контейнера на удаленной ВМ

   VM_USER="devops"
   VM_IP="192.168.227.128"
   REMOTE_DIR="/home/devops/docker-app"
   IMAGE_NAME="homelab-webapp"
   CONTAINER_NAME="webapp-container"

   echo "Copying application files to VM..."
   scp ./app/Dockerfile ./app/index.html ${VM_USER}@${VM_IP}:${REMOTE_DIR}/

   echo "Building Docker image on VM..."
   ssh ${VM_USER}@${VM_IP} "cd ${REMOTE_DIR} && docker build -t ${IMAGE_NAME} ."

   echo "Stopping and removing old container (if exists)..."
   ssh ${VM_USER}@${VM_IP} "docker stop ${CONTAINER_NAME} 2>/dev/null || true && docker rm ${CONTAINER_NAME} 2>/dev/null || true"

   echo "Running new Docker container..."
   ssh ${VM_USER}@${VM_IP} "docker run -d --name ${CONTAINER_NAME} -p 8080:80 ${IMAGE_NAME}"

   echo "Deployment complete. Check http://${VM_IP}:8080"