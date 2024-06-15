# Inception Project

## Summary
This project is a System Administration exercise aimed at broadening knowledge of Docker and virtualized environments. You will virtualize several Docker images, creating them in your personal virtual machine.

## Table of Contents
- [Introduction](#introduction)
- [General Guidelines](#general-guidelines)
- [Mandatory Part](#mandatory-part)
- [Bonus Part](#bonus-part)
- [Submission](#submission)

## Introduction
This project will help you understand and practice system administration using Docker. You will set up a small infrastructure composed of different services running in Docker containers, each with specific configurations.

## General Guidelines
- The project must be done on a Virtual Machine.
- All configuration files must be placed in a `srcs` folder.
- A `Makefile` is required at the root of your directory to set up the entire application using `docker-compose.yml`.
- Avoid using ready-made Docker images from DockerHub (Alpine/Debian are exceptions).
- Each service must run in a dedicated container.

## Mandatory Part
The project involves setting up the following:
- A Docker container with NGINX configured for TLSv1.2 or TLSv1.3 only.
- A Docker container with WordPress and php-fpm (without NGINX).
- A Docker container with MariaDB (without NGINX).
- A volume for the WordPress database.
- A volume for the WordPress website files.
- A Docker network to connect all containers.
- Configuring your domain name to point to your local IP address (e.g., `hsaadi.42.fr`).
- Use environment variables for sensitive data, stored in a `.env` file.
- Ensure containers restart in case of a crash.

### Directory Structure
An example of the expected directory structure:



## Bonus Part
If you complete the mandatory part perfectly, you can add the following bonus services:
- Set up Redis cache for your WordPress website.
- Set up an FTP server container pointing to the WordPress volume.
- Create a simple static website in a language other than PHP.
- Set up Adminer.
- Add any other useful service and justify its necessity during the evaluation.

## Submission
- Ensure all work is inside your Git repository.
- Double-check the names of your folders and files.
- Follow the naming conventions strictly.

## Usage

### Build and Run
1. **Clone the repository**:
    ```sh
    git clone https://github.com/yourusername/inception.git
    cd inception
    ```

2. **Set up the environment variables**:
    - Create a `.env` file in the `srcs` directory with the following content:
      ```env
      DOMAIN_NAME=hsaadi.42.fr
      MYSQL_USER=your_mysql_user
      MYSQL_PASSWORD=your_mysql_password
      MYSQL_ROOT_PASSWORD=your_mysql_root_password
      ```

3. **Build and run the containers**:
    ```sh
    make
    ```

4. **Access your services**:
    - NGINX: `https://hsaadi.42.fr`
    - WordPress: `https://hsaadi.42.fr`

## Makefile
Your Makefile should include the following targets:
- `all`: Set up and start the Docker containers.
- `clean`: Stop and remove the Docker containers.
- `fclean`: Stop and remove all Docker containers, volumes, and networks.
- `re`: Rebuild and restart the Docker containers.

Example Makefile:
```makefile
.PHONY: all clean fclean re

all:
	docker-compose -f srcs/docker-compose.yml up --build -d

clean:
	docker-compose -f srcs/docker-compose.yml down

fclean: clean
	docker system prune -af
	sudo rm -rf /home/hsaadi/data

re: fclean all
