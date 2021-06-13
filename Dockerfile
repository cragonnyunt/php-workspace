FROM cragonnyunt/development-docker:latest

RUN add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y \
    apache2 \
    libapache2-mod-fcgid \
    libapache2-mod-php8.0 \
    php8.0 \
    php8.0-bcmath \
    php8.0-cli \
    php8.0-common \
    php8.0-curl \
    php8.0-dev \
    php8.0-fpm \
    php8.0-gd \
    php8.0-mbstring \
    php8.0-memcached \
    php8.0-mysql \
    php8.0-pgsql \
    php8.0-sqlite3 \
    php8.0-zip \
    php8.0-xdebug \
    php8.0-xml

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
