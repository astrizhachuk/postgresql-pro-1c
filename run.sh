#!/bin/sh

docker run --name postgresql-pro-1c \
  -d \
  -v postgresql-pro-1c-data:/var/lib/postgresql \
  strizhhh/postgresql-pro-1c:9.6