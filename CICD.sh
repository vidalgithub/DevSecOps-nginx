#!/bin/bash
set -e

APP_NAME=mywebapp
VERSION=INSECURE

#BUILD: Clenaup old container/build image
docker rm -f $APP_NAME 2>/dev/null || true
docker build -t $APP_NAME:$VERSION . 

# Remove existing container if it exists
docker rm -f webapp 2>/dev/null || true
#TEST: Run a new container
docker run -d -p 8182:80 --name webapp $APP_NAME:$VERSION 


