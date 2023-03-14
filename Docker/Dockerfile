FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y apache2 libapache2-mod-php php-mysql git php-memcache libmemcached11 libmemcached-dev curl unzip php-pgsql wget2

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2ctl","-D","FOREGROUND", "-k", "start"]
