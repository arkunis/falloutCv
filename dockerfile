FROM php:8.3-apache
 
RUN a2enmod rewrite
 
RUN apt-get update \
  && apt-get install -y libzip-dev git wget --no-install-recommends \
  && apt install libicu-dev -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
 
RUN docker-php-ext-install intl pdo mysqli pdo_mysql zip;

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
 
COPY ./vhosts.conf /etc/apache2/sites-enabled/000-default.conf
COPY . /var/www

WORKDIR /var/www
 
CMD ["apache2-foreground"]