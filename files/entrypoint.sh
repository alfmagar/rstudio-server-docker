#!/bin/bash
useradd -rm -d /home/$USER -s /bin/bash -g root -G sudo -u 1010 $USER
echo -e "$USER_PWD\n$USER_PWD" | passwd $USER &> /dev/null

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf