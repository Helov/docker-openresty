FROM openresty/openresty:alpine

MAINTAINER "Helov"

# add params dir
RUN set -eux; \
mkdir -p /etc/nginx/params

# add wwwroot dir
RUN set -eux; \
mkdir -p /var/www/html

# add curl
RUN set -eux; \
apk add --no-cache curl

# openresty health
HEALTHCHECK --interval=30s --timeout=30s --retries=3 CMD curl -fs http://127.0.0.1/nginx_status || exit 1
