FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y software-properties-common git wget composer && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:ondrej/php && apt-get update && apt-get install -y php5.6-fpm php5.6-cli php5.6-curl php5.6-gd php5.6-memcached php5.6-mysql php5.6-mcrypt php5.6-mbstring php5.6-xml php7.4-curl php7.4-xml php7.4-memcached zip unzip memcached nano nginx
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php -- --install-dir=/usr/bin/ --quiet

WORKDIR /app
RUN git clone https://github.com/AdKats/BFACP.git . && php /usr/bin/composer.phar install

COPY nginx.conf /etc/nginx/
RUN sed -ie 's/127\.0\.0\.1:9000/\/var\/run\/php-fpm\.sock/g' /etc/php/5\.6/fpm/php-fpm.conf
RUN sed -ie 's/;clear_env/clear_env/g' /etc/php/5\.6/fpm/php-fpm.conf
RUN chmod -R 775 storage bootstrap/cache && chown -R www-data:www-data storage bootstrap/cache && chown -R www-data. .
RUN cp .env.example .env

COPY wrtenv.py /
RUN chmod +x /wrtenv.py

EXPOSE 80
ENTRYPOINT service memcached start && service php5.6-fpm start && python3 /wrtenv.py && nginx 
