NAME        = inception
COMPOSE     = docker compose -f srcs/docker-compose.yml
LOGIN       = $(shell whoami)
DATA_DIR    = /home/$(LOGIN)/data

all: up

up:
	@mkdir -p $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

restart: down up

logs:
	$(COMPOSE) logs -f

status:
	$(COMPOSE) ps

# stop + remove containers, networks, images built for this project
clean: down
	docker system prune -f

# clean + wipe the actual data on disk (irreversible)
fclean: clean
	docker volume rm -f mariadb_data wordpress_data 2>/dev/null || true
	sudo rm -rf $(DATA_DIR)

re: fclean all
