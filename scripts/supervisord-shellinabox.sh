#! /bin/bash

set -e
set -x

service=$SHELL_IN_A_BOX_SERVICE
theme=$WEB_SHELL_THEME

if [ -z "$service" ]; then
  service="/:user:users:/home/user:/bin/bash"
fi

if [ -z "$theme" ]; then
  theme="DarkTheme"
fi

if [ "$theme" == "DarkTheme" ]; then
  theme="/opt/shellinabox/shellinabox/white-on-black.css"
else  
  theme="/opt/shellinabox/shellinabox/black-on-white.css"
fi

#/opt/shellinabox/shellinaboxd -b --css $theme --no-beep --service $service
/opt/shellinabox/shellinaboxd --verbose -b --css $theme --no-beep 
