FROM ubuntu:18.04
MAINTAINER Henrique Weiand <henriqueweiand@gmail.com>

RUN apt-get update && apt-get upgrade -y

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y apache2 git npm
RUN apt-get install -y php7.2 libapache2-mod-php7.2 php7.2-mbstring php7.2-zip php7.2-xml php7.2-mysql mysql-client php7.2-pgsql zip unzip nano curl php7.2-curl php-pear wget
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
RUN mv composer.phar /usr/local/bin/composer

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]