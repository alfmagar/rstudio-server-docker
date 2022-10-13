# RStudio Server version 2022.07.2

Clean and simple. Built using Ubuntu 22.04 as parent image.

### Docker Hub

This image is already built and ready to use here:

[Docker Hub - Alfmagar RStudio Server](https://hub.docker.com/r/alfmagar/rstudio-server)

### How to build

```sh
docker build -t <your-image-name>:<your-tag> .
```

### Admitted vars

> **USER:** Default username for RStudio environment.

> **USER_PWD:** Default user password for RStudio environment.

### ¿Where is data stored?

RStudio will store all runtime data in **/data** folder. To persist data create a volume pointing to this folder in the container.

### How to use

```sh
docker run -d -p 80:80 -e USER=<your username> -e USER_PWD=<your-password> -v /<your-persistent-storage-folder>:/data --name rstudio alfmagar/rstudio-server:2022-07-2.Ubuntu22
```