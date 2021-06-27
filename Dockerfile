FROM cragonnyunt/development-docker:latest

RUN add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y \
    apache2 \
    libapache2-mod-fcgid \
    libapache2-mod-php7.4 \
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

COPY apache.conf /etc/apache2/sites-available/000-default.conf

RUN usermod -aG devuser www-data

RUN a2enmod proxy proxy_html proxy_http ssl http2 rewrite headers && \
    service apache2 restart

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

RUN mkdir /etc/service/apache2

COPY run.sh /etc/service/apache2/run

RUN chmod +x /etc/service/apache2/run

EXPOSE 80 443
