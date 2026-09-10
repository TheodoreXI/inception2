*This project has been created as part of the 42 curriculum by aakroud.*

# Inception

## Description
This project is about building a small Docker infrastructure from scratch. The stack runs three services: NGINX, WordPress with PHP-FPM, and MariaDB.

The goal is to understand how to split a web application into separate containers, connect them with a Docker network, keep data on the host, and secure the setup with Docker secrets instead of plain environment variables.

The sources in this project are the custom Dockerfiles, the compose file, the init scripts for WordPress and MariaDB, and the NGINX configuration. I used Docker and Docker Compose to manage the build and the communication between the services.

### Main design choices
- NGINX is the only public entrypoint and listens on port 443.
- WordPress runs with PHP-FPM and is not exposed directly to the host.
- MariaDB stays inside the private Docker network.
- Secrets are stored in the `secrets/` folder.
- Persistent data is stored on the host in `/home/aakroud/data` through Docker volumes.

### Required comparisons
#### Virtual Machines vs Docker
Virtual machines run a full guest operating system, which makes them heavier and slower to start. Docker containers share the host kernel, so they are lighter and faster for this kind of project.

#### Secrets vs Environment Variables
Environment variables are fine for simple configuration, but they are not a good place for passwords. Docker secrets are better for sensitive values because they are mounted as files and kept out of the compose file and image layers.

#### Docker Network vs Host Network
The host network connects a container directly to the host network stack, which removes isolation. A Docker network keeps the services separated and lets them talk to each other by service name.

#### Docker Volumes vs Bind Mounts
Bind mounts point directly to a host path and depend on that path being managed manually. Docker volumes are easier to manage through Compose, and in this project they are mapped to the host data directory so the database and WordPress files persist.

## Instructions
### Start the project
From the root of the repository, run:
```bash
make
```

This creates the data folders if they do not exist and starts the stack with Docker Compose.

### Stop the project
```bash
make stop
```

### Restart the project
```bash
make restart
```

### Useful extra commands
- `make status` to check the containers.
- `make logs` to follow the logs.
- `make down` to stop and remove the containers and network.
- `make fclean` to remove the containers, volumes, and host data.

## Resources
- [Docker documentation](https://docs.docker.com/)
- [Docker Compose documentation](https://docs.docker.com/compose/)
- [NGINX documentation](https://nginx.org/en/docs/)
- [WordPress documentation](https://wordpress.org/documentation/)
- [MariaDB documentation](https://mariadb.com/kb/en/documentation/)

### AI use
I used AI to help me organize the structure of the documentation and check that I did not forget any requirement from the subject. I wrote the final content myself and kept it aligned with my project setup.
