FROM ubuntu:16.04
MAINTAINER Henrique Weiand <henriqueweiand@gmail.com>

RUN apt-get update && apt-get install -y apache2 git npm
RUN apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-mbstring php7.0-zip php7.0-xml php7.0-mysql mysql-client php7.0-pgsql zip unzip nano curl php7.0-curl php-pear wget
RUN a2enmod rewrite

ENV COMPOSER_HOME /composer
ENV PATH /composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN mkdir -p /var/www/html/public
RUN wget http://pear.php.net/go-pear.phar
RUN php go-pear.phar
RUN mkdir -p /var/www/html/public
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN php composer.phar --install-dir=bin --filename=composer
RUN mv composer.phar /usr/local/bin/composer

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]