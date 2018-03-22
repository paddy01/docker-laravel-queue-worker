FROM php:7.1-alpine

LABEL maintainer="Patrik Forsberg <patrik.forsberg@ip-only.se>" \
		version.image="v2.3" \
		version.php=$PHP_VERSION \
		description="A supervisor configured to run with laravel artisan queue:work or artisan horizon command"

ENV PYTHON_VERSION=2
ENV PY_PIP_VERSION=2
ENV SUPERVISOR_VERSION=3.3.3

ENV QUEUE_CONNECTION=redis
ENV QUEUE_NAME=default
ENV LARAVEL_HORIZON=false
ENV LARAVEL_HOME="/var/www"

# Install pdo if you want to use database queue
RUN docker-php-ext-install pdo pdo_mysql pcntl posix

# Install supervisor
RUN apk update && apk add -u python py-pip
RUN pip install supervisor==$SUPERVISOR_VERSION

# Define working directory
WORKDIR /etc/supervisor/conf.d

# Use local configuration
COPY laravel-worker.conf.tpl /etc/supervisor/conf.d/laravel-worker.conf.tpl
COPY laravel-horizon.conf.tpl /etc/supervisor/conf.d/laravel-horizon.conf.tpl

# Copy scripts
COPY init.sh /usr/local/bin/init.sh

VOLUME /var/www

# Run supervisor
ENTRYPOINT ["/bin/sh", "/usr/local/bin/init.sh"]
