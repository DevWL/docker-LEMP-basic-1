FROM php:7.4-fpm
ARG uid=1000
ARG user=dev

# install tools
RUN apt update
RUN apt-get update  
RUN apt-get install -y \
git \
curl
# libpng-dev \
# libonig-dev \
# libxml2-dev \
# zip \
# unizip

# cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# install php ext
# RUN docker-php-ext-intall pdo_mysql mbstring
#  exif pcntl gd bcmath

# setup user 
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# aset working direcotry
# WORKDIR /usr/share/nginx
WORKDIR /usr/share/nginx/html

# run ad USER
USER $user

# WORKDIR /usr/share/nginx/html
# COPY /C/laragon/www/docker/nginx-mysql-php/html /usr/share/nginx