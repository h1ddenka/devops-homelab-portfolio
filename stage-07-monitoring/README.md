# Stage 07: Monitoring & Logging (Observability)

## Стек технологий
- **Prometheus**: сбор и хранение метрик (порт 9090)
- **Grafana**: визуализация метрик и логов (порт 3000)
- **Loki + Promtail**: легковесная агрегация логов (порт 3100)
- **Node Exporter**: сбор метрик хоста (CPU, RAM, Disk, Network)

## Почему Docker Compose вместо Helm?
Docker-контейнеры используют `docker.io`, для которого настроены registry-mirrors.
В небольших развертываниях мониторинг часто работает на уровне хоста, а не внутри K8s — это проще в обслуживании.

## Установка

1. Скопировать `.env.example` в `.env` и задать пароль:
   ```bash
   cp .env.example .env
   nano .env  # свой пароль```
2. Запустить стек
   ```bash
   docker compose up -d
   ```
3. Открыть в браузере:
	* Prometheus: http://192.168.227.128:9090
	* Grafana: http://192.168.227.128:3000 (admin / ваш пароль из .env)
	* Loki: http://192.168.227.128:3100
4. P.S. Был использован .env в рамках работы в этом проекте, понимаю что было бы правильнее использовать тот же HashiCorp Vault
<img width="1592" height="1001" alt="image" src="https://github.com/user-attachments/assets/c1841d9d-5dcc-405a-9a3e-e3888a4ca389" />
<img width="1599" height="918" alt="image" src="https://github.com/user-attachments/assets/0b813d66-6e45-410d-afe3-766a585361b0" />
<img width="1595" height="916" alt="image" src="https://github.com/user-attachments/assets/61abfb5c-c210-4ceb-8b22-ef9b2283f383" />
