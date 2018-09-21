FROM php:7-apache
MAINTAINER Fabian Köster <mail@fabian-koester.com>

EXPOSE 80

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    libldap2-dev \
 && rm -rf /var/lib/apt/lists/*

ARG KIMAI_VERSION=1.3.1
ARG KIMAI_SHA256=cbf86e8e52bc48a1769e15301463b698f475c47201c973268c43a38efc3491ad

RUN curl -L -o kimai.zip https://github.com/kimai/kimai/releases/download/${KIMAI_VERSION}/kimai_${KIMAI_VERSION}.zip \
  && echo "${KIMAI_SHA256} kimai.zip" | sha256sum -c \
  && mkdir -p /var/www/html \
  && unzip kimai.zip -d /var/www/html/ \
  && chown -R www-data:www-data /var/www/html/ \
  && rm *.zip

RUN docker-php-ext-install mysqli \
  && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
  && docker-php-ext-install ldap

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]

