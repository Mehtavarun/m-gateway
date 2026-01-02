# --- CONFIGURATION ---
# The path to your infrastructure repo relative to this Makefile
INFRA_DIR := gateway

# Export OTLP Endpoint for local development or shell context
export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4318
export OTEL_SERVICE_NAME=root-make

# --- COMMANDS ---

.PHONY: help start stop restart logs build pull clean shell-app

help: ## Show this help message
	@echo "🏠 Home Platform Manager"
	@echo "-----------------------"
	@echo "make start    - Start the full platform (Gateway, Dashboard, Clipboard)"
	@echo "make stop     - Stop all services"
	@echo "make restart  - Restart all services"
	@echo "make logs     - Follow logs from all services"
	@echo "make build    - Rebuild Docker images (use after code changes)"
	@echo "make pull     - Pull latest git changes for all repos"
	@echo "make clean    - Remove containers and orphans"

start: ## Start everything in the background
	@echo "🚀 Starting Home Platform..."
	@docker-compose up -d --remove-orphans
	@echo "✅ Services are running at https://mehta.local"

stop: ## Stop everything
	@echo "🛑 Stopping Home Platform..."
	@docker-compose down
# 	@cd $(INFRA_DIR) && docker rm -f gateway collector dashboard clipboard

restart: stop start ## Restart everything

logs: ## View live logs
	@docker-compose logs -f

build: ## Rebuild images (Required if you change App or Dashboard code)
	@echo "🔨 Rebuilding Service Images..."
	@docker-compose up -d --build

pull: ## Git pull for all sub-directories
	@echo "⬇️  Pulling gateway..."
	@git pull origin main
	@echo "⬇️  Pulling dashboard..."
	@cd ../dashboard && git pull origin main
	@echo "⬇️  Pulling clipboard..."
	@cd ../clipboard && git pull origin main
	@echo "✅ All repos updated."

clean: ## Deep clean (stops containers and removes images)
	@echo "🧹 Cleaning up..."
	@docker-compose down --rmi local --remove-orphans

shell-app: ## Open a shell inside the Clipboard App container
	@docker-compose exec clipboard sh