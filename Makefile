# Inception Makefile

DCSRC = srcs/docker-compose.yml
DCMD = sudo docker compose -f $(DCSRC)
PSID = $(docker ps -aq)

# Variable that represents the condition

.PHONY: ps build up down clean stop delete prune rebuild

ps: 
	@echo "Here are all the containers..."
	docker ps -a

build:
	@echo "Building all services..."
	$(DCMD) build

up:
	@echo "Starting all services..."
	$(DCMD) up -d

down:
	@echo "Stopping all services..."
	@$(DCMD) down

stop:
	@echo "Stopping services..."
	@docker stop $(PSID)

delete:
	@echo "Deleting all stopped containers..."
	docker rm $(shell [ -n "$(PSID)" ] && echo $(PSID)) || true
	@echo "Deleting all untagged images..."
	docker rmi $(docker images -aq)

prune:
	@echo "Pruning system..."
	docker volume prune -f
	@docker network prune -f
	docker system prune -af

rebuild: delete prune
	@echo "Rebuilding All Services..."
	$(MAKE) build

