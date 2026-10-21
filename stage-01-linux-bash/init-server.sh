#!/bin/bash
# init-server.sh
# Скрипт базовой инициализации Ubuntu Server для DevOps-лаборатории
# Автор: Nikita Dolmatov
# Дата: 2026-10-21

set -e  # Остановить выполнение при любой ошибке

echo "Обновление списков пакетов и upgrade системы..."
sudo apt update && sudo apt upgrade -y

echo "Установка базовых утилит..."
sudo apt install -y git curl vim htop net-tools ufw iputils-ping

echo "Настройка UFW..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh      # Порт 22
sudo ufw allow 80/tcp   # HTTP
sudo ufw allow 443/tcp  # HTTPS
echo "y" | sudo ufw enable

echo "Выполнена базовая настройка"
echo "Рекомендуется перезагрузить систему: sudo reboot"
