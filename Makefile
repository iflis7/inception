DC_SRC = srcs/docker-compose.yml

# Define command prefix
CMD_PREFIX = sudo
DOCKER_COMPOSE = $(CMD_PREFIX) docker compose -f $(DC_SRC)
DOCKER = $(CMD_PREFIX) docker

# Path definitions for data directories
DATA_DB_DIR = /home/hsaadi/data/db
DATA_WP_DIR = /home/hsaadi/data/wp

# Define colors for pretty print
GREEN=\033[0;32m
NC=\033[0m # No Color
WARN_COLOR  = \033[0;33m

# Define .PHONY to tell make these targets are not files
.PHONY: ps build up down clean stop delete prune rebuild help

# Default action is to show help
default: help

# The setup target for creating necessary directories
config:
	@echo "${GREEN}Checking and creating necessary data directories...${NC}"
	@mkdir -p $(DATA_DB_DIR) $(DATA_WP_DIR)

setup: config kabylia

# List all containers
ps:
	@echo "${GREEN}Here are all the containers...${NC}"
	@$(DOCKER) ps -a

# Build or rebuild services
build: setup
	@echo  "${GREEN}Building the Docker images...${NC}"
	@$(DOCKER_COMPOSE) build

# Start services
up: setup
	@echo  "${GREEN}Starting up the containers...${NC}"
	@$(DOCKER_COMPOSE) up

# Stop services
down:
	@echo "${GREEN}Stopping the containers...${NC}"
	@$(DOCKER_COMPOSE) down

# Stop and remove containers, networks
clean: stop delete

# Stop all running containers
stop:
	@echo "${GREEN}Stopping all containers...${NC}"
	@$(DOCKER) stop $$(docker ps -aq)

# Delete all stopped containers
delete:
	@echo "${GREEN}Removing all containers...${NC}"
	@$(DOCKER) rm $$(docker ps -aq)

rmimage:
	@echo "${GREEN}Removing all images...${NC}"
	@$(DOCKER) rmi $$(docker images -aq)
# Remove all unused containers, networks, images (both dangling and unreferenced), and optionally, volumes.
prune:
	@echo "${GREEN}Removing unused Docker assets...${NC}"
	@$(DOCKER) system prune -a

# Rebuild and restart the containers
rebuild: down build up

# List all Docker volumes
vls:
	@echo "${GREEN}Listing all Docker volumes...${NC}"
	@$(DOCKER) volume ls

# List all Docker networks
nls:
	@echo "${GREEN}Listing all Docker networks...${NC}"
	@$(DOCKER) network ls

# Remove all unused Docker volumes
vprune:
	@echo "${GREEN}Removing all unused Docker volumes...${NC}"
	@$(DOCKER) volume rm $$(docker volume ls -q)

# Remove all unused Docker networks
nprune:
	@echo "${GREEN}Removing all unused Docker networks...${NC}"
	@$(DOCKER) network prune -f

# Display help for commands
help:
	@echo -e "${GREEN}Makefile commands:${NC}"
	@echo "ps            : List all containers"
	@echo "build         : Build or rebuild services"
	@echo "up            : Create and start containers"
	@echo "down          : Stop and remove containers, networks, etc."
	@echo "clean         : Stop and remove all containers"
	@echo "stop          : Stop all containers"
	@echo "delete        : Remove all stopped containers"
	@echo "prune         : Remove all unused Docker assets"
	@echo "rebuild       : Rebuild and restart the containers"
	@echo "volume-list   : List all Docker volumes"
	@echo "network-list  : List all Docker networks"
	@echo "volume-prune  : Remove all unused Docker volumes"
	@echo "network-prune : Remove all unused Docker networks"
	@echo "help          : Display this help"


kabylia:
	@printf "%b" "$(WARN_COLOR)"
	@echo " ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ FREE KABYLIA ⵣ  ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ "
	@echo " ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ "
	@echo " ⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠿⠿⠿⠻⠿⠿⠿⠿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠉⠉⠻⣿⣿⣿ "
	@echo " ⣿⡿⠿⣿⡿⠟⠛⠉⠠⠐⢀⠐⡀⠂⠄⡐⠀⢂⠐⢀⠂⡐⠠⠈⢸⠀⠈⠛⠻⣿⣿⣿⣿⣿⣿⠿⠋⠁⠀⠉⠁⠀⠀⠀⠀⠀⠀⠹⣿⣿ "
	@echo " ⣿⣷⠀⢠⠀⠂⡌⠀⢡⠐⠀⠂⢠⠈⠀⠐⠈⠀⠐⢠⠀⠐⠀⢡⢸⠀⠀⠀⠀⠘⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿ "
	@echo " ⣿⣿⠀⢂⠈⡀⠄⡈⠄⠐⠠⢈⠀⢂⠁⠢⠑⠈⠄⣾⣞⡇⠐⠀⣾⡶⠀⠀⢰⣶⡎⠉⠉⠐⡀⠀⠀⠀⢀⣀⣀⣠⣶⣦⣤⣤⣶⣶⣶⣿ "
	@echo " ⣿⣿⣇⠀⠂⠄⡐⠀⠄⡁⠂⠄⡈⠀⢎⠂⠃⢋⠀⠙⠾⠷⠤⡥⣿⡽⠠⠤⠜⠓⠁⠀⠐⠪⡗⠌⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ "
	@echo " ⣿⣿⣿⣷⣬⣶⡄⠈⠄⠐⡀⢂⠠⠡⠘⣁⡝⡆⠠⢁⣤⣤⡤⠤⣿⡽⠤⠤⣀⣀⠀⠀⢠⠚⢗⢀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿ "
	@echo " ⣿⣿⣿⣿⣿⣿⠃⡈⠐⠠⠐⠀⠄⠂⢁⠪⣑⠓⡄⣿⣻⠆⠀⡀⣿⣳⠀⠀⢸⣟⡇⢀⠬⣴⠃⠁⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿ "
	@echo " ⣿⣿⣿⣿⣿⡟⠃⢀⠁⠂⠌⠐⠠⠁⠂⠢⣈⢡⣐⣈⢁⠁⠂⠄⢹⠀⠀⠀⠀⡠⠠⣈⠧⠀⠒⠀⠀⠀⠀⠀⠀⢺⣿⣿⣿⣿⣿⣿⣿⣿ "
	@echo " ⣿⣿⣿⣿⡟⠃⡐⠠⠈⠐⠠⠁⢂⠈⠄⢁⠀⡐⣆⢈⡠⡣⡨⢀⣸⠀⣀⢀⢦⡒⢌⠌⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿ "
	@echo " ⣿⣿⣿⣿⣿⣿⣦⡀⡡⠈⠐⡀⠂⢤⣾⣶⣷⣶⣶⣿⡆⠓⠂⢁⢸⠈⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿ "
	@echo " ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⣃⣠⣀⣼⣿⣿⣿⣿⣿⡟⠀⡀⠃⣄⣸⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣧⣼⣿⣿⣿⣿⣿⣿⣿⣿ "
	@echo " ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣿⣿⣿⣿⣷⣤⣀⠀⠀⠀⠀⠀⢠⣤⣤⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ "
	@echo " ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⣀⣀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ "
	@echo " ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ "
	