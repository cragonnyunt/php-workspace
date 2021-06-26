# PHP Workspace

[![PHP Workspace CI](https://github.com/cragonnyunt/php-workspace/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/cragonnyunt/php-workspace/actions/workflows/main.yml)

PHP Workspace Docker is built on top of the [development workspace docker](https://github.com/cragonnyunt/development-workspace). It contains the most used tools for PHP developers, and prepare environment configuration for developing php apps and websites.

Set of tools installed
- Everything installed on [development workspace docker](https://github.com/cragonnyunt/development-workspace)
- PHP & PHP-FPM
- Composer (v2.0)
- PECL

## Pulling the image

```
docker pull cragonnyunt/php-workspace-docker:<<tag>>
```

## Running the image

```
docker run --rm -it \
    -v $(pwd):/workspace \
    cragonnyunt/php-workspace-docker:<<tag>>
```

## php-workspace-docker:<version>-fpm

This version contains PHP-FPM, FastCGI processor for the use with external nginx, apache reverse proxy.

## php-workspace-docker:<version>-apache

This version contains apache by default. Your website's `index.php` will need to be in `/workspace/public/index.php` for default config.
