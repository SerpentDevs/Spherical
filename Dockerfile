# Spherical. Created by Jake Gealer <jake@gealer.email> 2018.

FROM python:3.6.6-stretch
# Sets the image to the Python 3.6.6 stretch image.

MAINTAINER jake@gealer.email
# Sets me as a maintainer.

RUN apt-get update && apt-get install -y nginx php7.0-fpm php7.0-gd php7.0-dom php7.0-sqlite unzip libpng-dev libjpeg-dev freetype*
# Installs all needed stuff.

RUN echo "cgi.fix_pathinfo=0" > /etc/php/7.0/fpm/php.ini
RUN service php7.0-fpm reload
# PHP fix because it is shit.

WORKDIR /var/spherical_unpack
RUN git clone git://github.com/SerpentDevs/Spherical /var/spherical_unpack
# Sets the work directory and copies everything there.

RUN wget https://captcha.com/bd4/botdetect-php-captcha-component-free.zip
# Downloads BotDetect CAPTCHA.

RUN unzip botdetect-php-captcha-component-free.zip
# Unzips the BotDetect CAPTCHA library.

RUN mv ./BotDetect-PHP-CAPTCHA-Component-Free-v4.2.3/lib/ "/var/spherical_unpack/BotDetect CAPTCHA Handler/botdetect/"
# Moves BotDetect CAPTCHA into the folder where the PHP is.

RUN rm -rf ./BotDetect-PHP-CAPTCHA-Component-Free-v4.2.3/ && rm ./botdetect-php-captcha-component-free.zip
# Deletes the garbage files.

RUN mv "/var/spherical_unpack/BotDetect CAPTCHA Handler/" /var/spherical_captcha_php
# Moves the CAPTCHA handler into the correct folder.

RUN mv "/var/spherical_unpack/Nginx Configs/php-captcha" /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/php-captcha /etc/nginx/sites-enabled/
RUN service nginx reload
# Adds the PHP CAPTCHA Nginx config.

RUN mv "/var/spherical_unpack/Default Certificate" /var/spherical_cert
# Moves the self-signed certificate into the certificate folder to be changed during setup.

RUN mv "/var/spherical_unpack/Nginx Configs/main-server" /etc/nginx/sites-available/
RUN mv /var/spherical_unpack/Website /var/spherical_website
RUN ln -s /etc/nginx/sites-available/main-server /etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default
RUN service nginx reload
# Adds the main Nginx config.

RUN mv "/var/spherical_unpack/API V1" /var/spherical_api_v1 && cd /var/spherical_api_v1
RUN mv /var/spherical_unpack/docker_entrypoint_script.sh /var/spherical_api_v1/docker_entrypoint_script.sh
WORKDIR /var/spherical_api_v1
# Moves API V1.

RUN python -m pip install -r requirements.txt
# Installs all of the Python requirements.

RUN chmod 777 ./docker_entrypoint_script.sh
# Grants the script execution rights.

EXPOSE 80
EXPOSE 443
# Exposes the ports 80/443.

CMD ./docker_entrypoint_script.sh
# Runs the Bash script.
