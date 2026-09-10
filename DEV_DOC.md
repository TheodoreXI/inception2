# Developer Documentation

## Setup from scratch
Before starting, make sure you have:
- Docker installed
- Docker Compose installed
- sudo access on the machine

Add the project domain to `/etc/hosts`:
```text
127.0.0.1 aakroud.42.fr
```

Check that these files exist and are filled in:
- `srcs/.env`
- `secrets/db_password.txt`
- `secrets/db_root_pass.txt`
- `secrets/credentials.txt`

The project tree is simple:
- `Makefile`
- `secrets/`
- `srcs/docker-compose.yml`
- `srcs/requirements/`

## Build and launch
From the repository root, run:
```bash
make
```

This creates the host data directories and runs:
```bash
docker compose -f srcs/docker-compose.yml up -d --build
```

Other useful Makefile commands:
- `make stop` to stop the containers.
- `make start` to start them again.
- `make down` to stop and remove the containers and network.
- `make restart` to restart the stack.
- `make logs` to follow the logs.
- `make status` to check the container status.
- `make re` to rebuild from scratch.
- `make fclean` to remove everything, including the host data folder.

## Managing containers and volumes
Use Compose when you need direct control:
```bash
docker compose -f srcs/docker-compose.yml ps
docker compose -f srcs/docker-compose.yml logs -f
docker compose -f srcs/docker-compose.yml exec wordpress bash
```

The persistent data is stored on the host here:
- `/home/aakroud/data/mariadb`
- `/home/aakroud/data/wordpress`

The compose file maps those paths through named volumes, so the database and website files stay on disk even if the containers are removed.

## Where the data is stored
- MariaDB data: `/home/aakroud/data/mariadb`
- WordPress files: `/home/aakroud/data/wordpress`

If you remove the stack with `make down`, the data stays. If you run `make fclean`, the data folder is removed too.
