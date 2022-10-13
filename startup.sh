#!/bin/bash
docker run -d -p 80:80 -e USER=sdg -e USER_PWD=sdg2022 -v /home/alfmagar/rstudio-custom/data:/data --name rstudio rstudio-custom:1