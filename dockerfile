Apache2 server:

FROM ubuntu/apache2
LABEL author="padma"
RUN apt update && apt install apache2 -y
RUN apt install php libapache2-mod-php php php-mysql -y  
RUN echo "<?php phpinfo() ?>" > /var/www/html/info.php
EXPOSE 80
CMD ["apache2ctl","-D","FOREGROUND"]



Nginx server:

FROM ubuntu:22.04
LABEL author="padma"
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
RUN apt install nginx -y && \
RUN apt install  php php-fpm -y   
COPY /index.html /var/www/srapp/index.html
COPY /info.php /var/www/srapp/info.php
RUN service nginx reload
EXPOSE 80
CMD ["/bin/bash","-c","service php8.1-fpm restart && nginx -g 'daemon off;'"]






FROM ubuntu/nginx
LABEL author="padma"
RUN apt update && apt install nginx -y
RUN echo "<?php phpinfo(); ?>" >> /etc/nginx/nginx.conf
RUN apt install php libapache2-mod-php -y
RUN /etc/nginx/sites-available/default
RUN echo "<?php phpinfo(); ?>" >> /var/www/html/info.php
RUN chmod -R 777 /var/www/html
EXPOSE 80
CMD ["apache2ctl","-D","FOREGROUND"] 

### vi dockerfile
### docker image build -t nginx .
### dokcker container ls
