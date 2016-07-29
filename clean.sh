#!/bin/sh
sudo docker stop steemiesvsdiesels

sudo docker rm steemiesvsdiesels

sudo docker rmi taylormadeapps/steemiesvsdiesels:latest
