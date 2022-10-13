FROM ubuntu:22.04

#Define no terminal
ARG DEBIAN_FRONTEND=noninteractive

# Define locales
ENV TZ Europe/Madrid
ENV LANG es_ES.UTF-8
ENV LANGUAGE es_ES:es
ENV LC_ALL es_ES.UTF-8
ENV USER rstudio
ENV USER_PWD rstudio
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#Update image packages
RUN apt-get update -y && apt-get upgrade -y

#Install RStudio dependencies
RUN apt-get install r-base r-base-dev gdebi-core wget curl -y

#Configure system locales
RUN apt-get install -y locales
RUN locale-gen es_ES.UTF-8
RUN localedef -f UTF-8 -i es_ES es_ES.UTF-8

#Install RStudio
RUN wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2022.07.2-576-amd64.deb
RUN gdebi -n rstudio-server-2022.07.2-576-amd64.deb
RUN rm ./rstudio-server-2022.07.2-576-amd64.deb

#Copy RStudio config file and entrypoint script
COPY files/rserver.conf /etc/rstudio/rserver.conf
COPY files/entrypoint.sh /entrypoint.sh

#Create RStudio data folder with right permissions
RUN mkdir /data
RUN chown rstudio-server /data
RUN chmod 755 /data
RUN chmod +x /entrypoint.sh

#Expose Rstudio port
EXPOSE 80
RUN rstudio-server stop
#Set up supervisor
RUN apt-get install supervisor
COPY files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

HEALTHCHECK CMD curl --fail http://localhost:80 || exit 1

#Configure entrypoint
ENTRYPOINT ["/entrypoint.sh"]
