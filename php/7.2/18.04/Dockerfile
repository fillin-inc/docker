FROM ubuntu:18.04
LABEL maintainer="fillin Inc."
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

ENV WORK_DIR /opt/app
WORKDIR $WORK_DIR
VOLUME $WORK_DIR

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
      && apt-get install -y curl wget zip build-essential \
      && apt-get install -y php7.2 \
        php7.2-cli \
        php7.2-bcmath \
        php7.2-curl \
        php7.2-dev \
        php7.2-gd \
        php7.2-json \
        php7.2-mysql \
        php7.2-opcache \
        php7.2-pgsql \
        php7.2-readline \
        php7.2-sqlite3 \
        php7.2-tidy \
        php7.2-xml \
        php7.2-bz2 \
        php7.2-fpm \
        php7.2-intl \
        php7.2-mbstring \
        php7.2-zip \
        php-imagick \
        php-memcached \
        php-redis \
        php-uploadprogress \
        php-uuid \
        php-xdebug \
        php-yaml \
        composer

# php.ini の変更
RUN find /etc/php/7.2/ -name php.ini | xargs -I{} cp {} {}.bak \
      && find /etc/php/7.2 -name php.ini -print0 | xargs -0 sed -i -e "s/^error_reporting = .\+$/error_reporting = E_ALL/" \
      && find /etc/php/7.2 -name php.ini -print0 | xargs -0 sed -i -e "s/^display_errors = off/display_errors = On/" \
      && find /etc/php/7.2 -name php.ini -print0 | xargs -0 sed -i -e "s/^display_startup_errors = off/display_startup_errors = On/" \
      && find /etc/php/7.2 -name php.ini -print0 | xargs -0 sed -i -e "s/^;mbstring.language/mbstring.language/" \
      && find /etc/php/7.2 -name php.ini -print0 | xargs -0 sed -i -e "s/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" \
      && find /etc/php/7.2 -name php.ini -print0 | xargs -0 sed -i -e "s/^post_max_size = .\+$/post_max_size = 20M/" \
      && find /etc/php/7.2 -name php.ini -print0 | xargs -0 sed -i -e "s/^upload_max_filesize = .\+$/upload_max_filesize = 10M/" \
      && sed -i -e "s/^listen = .\+$/listen = 127.0.0.1:9000/" /etc/php/7.2/fpm/pool.d/www.conf

RUN mkdir -p /run/php \
      && rm -rf /tmp/* \
      && rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/php", "-a"]
