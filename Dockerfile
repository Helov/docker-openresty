FROM openresty/openresty:buster

MAINTAINER "hello hello@vvaii.com"

# replace aliyun mirror
RUN set -eux; \
printf 'deb http://mirrors.cloud.aliyuncs.com/debian/ buster main non-free contrib\n\
deb http://mirrors.cloud.aliyuncs.com/debian-security buster/updates main\n\
deb http://mirrors.cloud.aliyuncs.com/debian/ buster-updates main non-free contrib\n\
deb http://mirrors.cloud.aliyuncs.com/debian/ buster-backports main non-free contrib\n\
deb http://mirrors.aliyun.com/debian/ buster main non-free contrib\n\
deb http://mirrors.aliyun.com/debian-security buster/updates main\n\
deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib\n\
deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib' > /etc/apt/sources.list; \
apt-get update

# create nginx extended config dir
RUN set -eux; \
mkdir -p /etc/nginx/params

# create php-fpm shared www root
RUN set -eux; \
mkdir -p /var/www/html

# curl
RUN set -eux; \
apt-get install -y --no-install-recommends curl

# clean apt cache
RUN set -eux; \
rm -rf /var/lib/apt/lists/*

# openresty health
HEALTHCHECK --interval=30s --timeout=30s --retries=3 CMD curl -fs http://127.0.0.1/nginx_status || exit 1
