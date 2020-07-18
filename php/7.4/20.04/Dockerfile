FROM ubuntu:20.04
LABEL maintainer="fillin Inc."
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

ENV WORK_DIR /opt/app
WORKDIR $WORK_DIR
VOLUME $WORK_DIR

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
      && apt-get install -y curl wget zip build-essential \
      && apt-get install -y php7.4 \
        php7.4-cli \
        php7.4-bcmath \
        php7.4-curl \
        php7.4-dev \
        php7.4-gd \
        php7.4-json \
        php7.4-mysql \
        php7.4-opcache \
        php7.4-pgsql \
        php7.4-readline \
        php7.4-sqlite3 \
        php7.4-tidy \
        php7.4-xml \
        php7.4-bz2 \
        php7.4-fpm \
        php7.4-intl \
        php7.4-mbstring \
        php7.4-zip \
        php-imagick \
        php-memcached \
        php-redis \
        php-uploadprogress \
        php-uuid \
        php-xdebug \
        php-yaml \
        composer

# php.ini の変更
RUN find /etc/php/7.4/ -name php.ini | xargs -I{} cp {} {}.bak \
      && find /etc/php/7.4 -name php.ini -print0 | xargs -0 sed -i -e "s/^error_reporting = .\+$/error_reporting = E_ALL/" \
      && find /etc/php/7.4 -name php.ini -print0 | xargs -0 sed -i -e "s/^display_errors = off/display_errors = On/" \
      && find /etc/php/7.4 -name php.ini -print0 | xargs -0 sed -i -e "s/^display_startup_errors = off/display_startup_errors = On/" \
      && find /etc/php/7.4 -name php.ini -print0 | xargs -0 sed -i -e "s/^;mbstring.language/mbstring.language/" \
      && find /etc/php/7.4 -name php.ini -print0 | xargs -0 sed -i -e "s/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" \
      && find /etc/php/7.4 -name php.ini -print0 | xargs -0 sed -i -e "s/^post_max_size = .\+$/post_max_size = 20M/" \
      && find /etc/php/7.4 -name php.ini -print0 | xargs -0 sed -i -e "s/^upload_max_filesize = .\+$/upload_max_filesize = 10M/" \
      && sed -i -e "s/^listen = .\+$/listen = 127.0.0.1:9000/" /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php \
      && rm -rf /tmp/* \
      && rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/php", "-a"]
