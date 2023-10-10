#!/bin/sh

sh /script/generate-config.sh /usr/share/nginx/html/

exec /docker-entrypoint.sh
