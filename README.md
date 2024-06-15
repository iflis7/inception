# Inception:

<div style="display: flex; justify-content: center;">
  <img src="https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white" alt="Docker">
  <img src="https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white" alt="Nginx">
  <img src="https://img.shields.io/badge/WordPress-%23117AC9.svg?style=for-the-badge&logo=WordPress&logoColor=white" alt="WordPress">
  <img src="https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white" alt="MariaDB">
  <img src="https://img.shields.io/badge/php-143?style=for-the-badge&logo=php&logoColor=black&color=black&labelColor=darkorchid" alt="Php">
</div>


## Subject

This project aims to broaden my knowledge of system administration by using Docker.
I had to virtualize several Docker images, creating them in your new personal virtual machine.

<img src="subject/container.png">

* The whole project has to be done in a virtual machine.
* You have to use docker compose.
* Each Docker image must have the same name as its corresponding service.
* Each service has to run in a dedicated container.

For performance matters, the containers must be built either from the penultimate stable version of Alpine or Debian. The choice is yours.

* You also have to write your own Dockerfiles, one per service.
* The Dockerfiles must be called in your docker-compose.yml by your Makefile. It means you have to build yourself the Docker images of your project. It is then forbidden to pull ready-made Docker images, as well as using services such as DockerHub (Alpine/Debian being excluded from this rule).

You then have to set up:
* A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.
* A Docker container that contains WordPress + php-fpm (it must be installed and configured) only without nginx.
* A Docker container that contains MariaDB only without nginx.
* A volume that contains your WordPress database.
* A second volume that contains your WordPress website files.
* A docker-network that establishes the connection between your containers.

* Your containers have to restart in case of a crash.
A Docker container is not a virtual machine. Thus, it is not
recommended to use any hacky patch based on ’tail -f’ and so forth
when trying to run it. Read about how daemons work and whether it’s
a good idea to use them or not.

NOTE: Of course, using network: host or --link or links: is forbidden.
The network line must be present in your docker-compose.yml file.
Your containers musn’t be started with a command running an infinite
loop. Thus, this also applies to any command used as entrypoint, or
used in entrypoint scripts. The following are a few prohibited hacky
patches: tail -f, bash, sleep infinity, while true.

* In your WordPress database, there must be two users, one of them being the administrator. The administrator’s username can’t contain admin/Admin or administrator/Administrator (e.g., admin, administrator, Administrator, admin-123, andso forth).

* Your volumes will be available in the /home/login/data folder of the
host machine using Docker. Of course, you have to replace the login
with yours.

* To make things simpler, you have to configure your domain name so it points to your local IP address. This domain name must be login.42.fr. Again, you have to use your own login.For example, if your login is wil, wil.42.fr will redirect to the IP address pointing to wil’s website.

NOTE: The latest tag is prohibited.
* No password must be present in your Dockerfiles.
* It is mandatory to use environment variables.
* Also, it is strongly recommended to use a .env file to store environment variables. The .env file should be located at the root
of the srcs directory.
* Your NGINX container must be the only entrypoint into your
infrastructure via the port 443 only, using the TLSv1.2 or TLSv1.3
protocol.

</br>

# Docker:

To install Docker on Debian, you can follow these steps:
Update the package index:
`sudo apt update`

Install packages to allow apt to use a repository over HTTPS:
`sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release`

Add Docker’s official GPG key:
`curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg`

Use the following command to set up the stable repository:
`echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`

Update the package index again:
`sudo apt update`

Install the latest version of Docker:
`sudo apt install docker-ce docker-ce-cli containerd.io`

Verify that Docker is installed correctly by running the following command:
`sudo docker run hello-world`

## Dcoker-compose
1- Update the package index and install the required packages:
`sudo apt-get update`
`sudo apt-get install -y curl jq`

2- Download the latest version of Docker Compose:
`sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`

3- Apply executable permissions to the Docker Compose binary:
`sudo chmod +x /usr/local/bin/docker-compose`

4-Verify the installation by checking the version of Docker Compose:
`docker-compose --version`

#### Pull Docker Images:

` docker pull  <imageName>` ex: docker pull ubuntu:latest \*the latest is the version of the software

#### Run a container

`docker run -d -t --name <containerName> <imageSource>`: runs a container- <containerName> based on an image-<imageSource> <br>
-d: Runs the container in detached mode (in the background) <br>
-t: Allocates a pseudo-TTY for the container <br>
TTY mode: In this mode, a pseudo-TTY is allocated for the container, allowing the user to interact with the container's console. This mode is useful for running containers with an interactive shell. <br>
--name: Gives the chosen <containerName> to the created instance.

##### Refrences
https://docs.docker.com/engine/reference/commandline/cli/

</br>

# Nginx

### Introduction

nginx is a web server that can also be used as a reverse proxy, load balancer, and HTTP cache. It is a popular choice for serving static content and handling high traffic websites.

### Installation

nginx can be installed on various operating systems using package managers or downloaded from the nginx website. Consult the documentation for your specific platform for installation instructions.

### Configuration

nginx uses a configuration file to define how it should handle incoming requests. The configuration file is typically located at `/etc/nginx/nginx.conf`.

The configuration file is made up of a series of blocks, each with its own directives. Some common directives include:

* `worker_processes`: sets the number of worker processes to use
* `events`: configures event processing for incoming connections
* `http`: defines the HTTP server and its settings
* `server`: defines a virtual server and its settings
* `location`: defines how to handle requests for a specific URL location

### Serving Static Content

nginx can be used to serve static files like HTML, CSS, and JavaScript. To serve static content, add a `root` directive inside a `server` block and define the document root directory:

```
server {
    listen 80;
    server_name example.com;
    root /var/www/html;
}
```

This configuration will serve files from the `/var/www/html` directory when a request is made to `example.com`.

## Proxying Requests

nginx can also be used as a reverse proxy to forward requests to other servers. To proxy requests, add a `proxy_pass` directive inside a `location` block:

```
location / {
    proxy_pass http://localhost:8000;
    }
```

This configuration will forward requests to the local server running on port 8000.

## Load Balancing

nginx can also be used as a load balancer to distribute requests across multiple servers. To configure load balancing, add multiple `server` blocks with different `proxy_pass` directives:

```
upstream backend {
    server backend1.example.com;
    server backend2.example.com;
}

server {
    listen 80;
    server_name example.com;
    location / {
    proxy_pass http://backend;
}
}
```

This configuration will distribute requests between `backend1.example.com` and `backend2.example.com`.

</br>

# MariaDB

## Introduction

MariaDB is a popular open-source relational database management system. It is a fork of the MySQL database server and is designed to be a drop-in replacement for MySQL.

## Installation

MariaDB can be installed on various operating systems using package managers or downloaded from the MariaDB website. Consult the documentation for your specific platform for installation instructions.

## Configuration

MariaDB uses a configuration file to define how it should operate. The configuration file is typically located at `/etc/mysql/mariadb.conf.d/50-server.cnf`.

The configuration file is made up of a series of sections, each with its own directives. Some common directives include:

* `bind-address`: sets the IP address to bind to
* `port`: sets the port number to listen on
* `datadir`: sets the directory where MariaDB will store its data
* `user`: sets the user account under which MariaDB should run
* `default_storage_engine`: sets the default storage engine to use

## Administration

MariaDB provides several command-line tools for administration:

* `mysql`: the command-line client for MariaDB
* `mysqldump`: a tool for creating backups of MariaDB databases
* `mysqladmin`: a tool for performing administrative tasks like creating users and checking server status
* `mysql_upgrade`: a tool for upgrading the database schema after upgrading MariaDB

## Connecting to MariaDB

To connect to MariaDB, use the `mysql` command-line client:

``` 
mysql -u username -p 
```

This will prompt you for your password and connect you to the MariaDB server.

## Creating a Database

To create a new database in MariaDB, use the `CREATE DATABASE` command:

```
CREATE DATABASE dbname;
```

This will create a new database with the name `dbname`.

## Creating a Table

To create a new table in a database, use the `CREATE TABLE` command:

```
CREATE TABLE tablename (
    column1 datatype,
    column2 datatype,
    column3 datatype
);
```

This will create a new table with the name `tablename` and three columns.

</br> 

# Different CMDS

Show available images:
```
docker images -a
```

Show available containers:
```
docker ps -a
```

Stop running containers:
```
docker stop $(shell docker ps -aq)
```

Remove available images:
```
docker rmi $(shell docker images -aq)
```

Remove available containers:
```
docker rm $(shell docker ps -aq)
```
