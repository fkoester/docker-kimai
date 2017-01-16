# docker-kimai

A docker image for Kimai time tracking based on the [official php docker image](https://hub.docker.com/_/php/).

This repository also contains a `docker-compose.yaml` configuration file for simple usage together with the [official mariadb image](https://hub.docker.com/_/mariadb/).

## Supported tags and respective Dockerfile links

* `1.1.0`, `stable`, `latest` [(Dockerfile)](https://github.com/fkoester/docker-kimai/blob/master/Dockerfile)

## Getting started

1. Make sure you have current versions of Docker (>= 1.12) and docker-compose (>= 1.9).
2. Clone this repository
3. Create a docker volume named `kimai-database`:

  ```bash
  $ docker volume create --name kimai-database
  ```
4. Create and start the docker containers using docker-compose:

  ```bash
  $ docker-compose up
  ```
  This will command will:
  * Fetch the necessary docker images
  * Start the Apache and Mariadb services

After completion, you should be able to access the Kimai instance at [http://localhost:8080](http://localhost:8080) and peform the initial installation. For the database connection choose the following parameters:

* Host: *db*
* User: *kimai*
* Password: *kimai*
* Database: *kimai* (Existing)

After you finished the installation, you should remove the installer directory:

```bash
docker-compose exec kimai rm -rf /var/www/html/installer
```

## Configuration

Create a file `.env` in the working directory with any of the following variables:

* `EXTERNAL_PORT`: The external port (and ip address) to bind to (default `127.0.0.1:8080`)
