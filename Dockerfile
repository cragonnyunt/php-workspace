FROM cragonnyunt/development-docker:latest

RUN add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y \
    php7.4 \
    php7.4-bcmath \
    php7.4-cli \
    php7.4-common \
    php7.4-curl \
    php7.4-dev \
    php7.4-fpm \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-memcached \
    php7.4-mysql \
    php7.4-pgsql \
    php7.4-sqlite3 \
    php7.4-zip \
    php7.4-xdebug \
    php7.4-xml

RUN pecl channel-update pecl.php.net

RUN usermod -aG devuser www-data

COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir /etc/service/php-fpm && mkdir -p /run/php

COPY run.sh /etc/service/php-fpm/run

RUN chmod +x /etc/service/php-fpm/run

USER devuser

RUN echo "" >> ~/.zshrc && \
    echo 'export PATH="$HOME/:$HOME/.composer/vendor/bin:$PATH"' >> ~/.zshrc

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar ~/composer

COPY composer.json /home/devuser/.config/composer/composer.json

RUN ~/composer global install

USER root

EXPOSE 9000
