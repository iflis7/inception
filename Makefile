
# all: up

all: run

run:
	@

up:
	@docker-compose -f srcs/docker-compose.yml up -d -build

down:
	@docker-compose -f srcs/docker-compose.yml down

re: clean up

clean: down

.PHONY: up down re clean
	sudo rm -rf /data/db/*
	sudo rm -rf /data/wp/*
	docker volume rm srcs_wordpress_vol
	docker volume rm srcs_database_vol