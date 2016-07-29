#!/bin/bash


mkdir /var/log/supervisor
chmod 666 /var/log/supervisor/

supervisord -n
