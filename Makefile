.PHONY: help setup clone build start stop restart logs clean pull

help:
	@echo "Web Messages - Local Development Setup"
	@echo ""
	@echo "Available commands:"
	@echo "  make setup    - Clone all repos and set up the project"
	@echo "  make clone    - Clone the two project repositories"
	@echo "  make build    - Build all Docker images"
	@echo "  make start    - Start all services with docker compose"
	@echo "  make stop     - Stop all services"
	@echo "  make restart  - Restart all services"
	@echo "  make logs     - View logs from all services"
	@echo "  make pull     - Pull latest changes from all repositories"
	@echo "  make clean    - Remove Docker volumes and images"
	@echo ""
	@echo "Quick start:"
	@echo "  1. Copy .env.example to .env and configure it"
	@echo "  2. Run 'make setup' to clone repos and build images"
	@echo "  3. Run 'make start' to start all services"

setup: clone build
	@echo ""
	@echo "✓ Setup complete!"
	@echo ""
	@echo "Next steps:"
	@echo "  1. Make sure you have configured your .env file"
	@echo "  2. Run 'make start' to start the application"
	@echo "  3. Access the app on localhost as per your .env configuration"

clone:
	@echo "Cloning repositories..."
	@if [ ! -d "web-messages-service" ]; then \
		echo "Cloning web-messages-service..."; \
		git clone https://github.com/appdevjohn/web-messages-service.git; \
	else \
		echo "web-messages-service already exists, skipping..."; \
	fi
	@if [ ! -d "web-messages-pwa" ]; then \
		echo "Cloning web-messages-pwa..."; \
		git clone https://github.com/appdevjohn/web-messages-pwa.git; \
	else \
		echo "web-messages-pwa already exists, skipping..."; \
	fi
	@echo "✓ Repositories cloned"

build:
	@echo "Building Docker images..."
	@docker compose build
	@echo "✓ Docker images built"

start:
	@echo "Starting services..."
	@docker compose up -d
	@echo "✓ Services started! Run 'make logs' to view service logs."

stop:
	@echo "Stopping services..."
	@docker compose down
	@echo "✓ Services stopped"

restart: stop start

logs:
	@docker compose logs -f

pull:
	@echo "Pulling latest changes from repositories..."
	@if [ -d "web-messages-service" ]; then \
		echo "Pulling web-messages-service..."; \
		cd web-messages-service && git pull && cd ..; \
	fi
	@if [ -d "web-messages-pwa" ]; then \
		echo "Pulling web-messages-pwa..."; \
		cd web-messages-pwa && git pull && cd ..; \
	fi
	@echo "✓ All repositories updated"

clean:
	@echo "Cleaning up..."
	@docker compose down -v --rmi all
	@echo "✓ Cleanup complete"
