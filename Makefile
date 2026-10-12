.PHONY: help setup start stop restart logs pull clean

help:
	@echo "Web Messages - Local Development"
	@echo ""
	@echo "  make setup    - Clone web-messages-service and web-messages-pwa"
	@echo "  make start    - Start the service and PWA"
	@echo "  make stop     - Stop both"
	@echo "  make restart  - Restart both"
	@echo "  make logs     - Follow logs from both"
	@echo "  make pull     - Pull latest changes in both repositories"
	@echo "  make clean    - Stop both and remove their node_modules volumes"

setup:
	@[ -d web-messages-service ] || git clone https://github.com/appdevjohn/web-messages-service.git
	@[ -d web-messages-pwa ] || git clone https://github.com/appdevjohn/web-messages-pwa.git
	@echo "✓ Repositories ready. Run 'make start'."

start:
	@docker compose up -d
	@echo "✓ Started. The first start installs dependencies; run 'make logs' to follow along."

stop:
	@docker compose down

restart: stop start

logs:
	@docker compose logs -f

pull:
	@git -C web-messages-service pull
	@git -C web-messages-pwa pull

clean:
	@docker compose down -v
