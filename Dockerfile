# Spherical. Created by Jake Gealer <jake@gealer.email> 2018.

FROM python:3.6.6-stretch
# Sets the image to the Python 3.6.6 stretch image.

MAINTAINER jake@gealer.email
# Sets me as a maintainer.

RUN apt-get update && apt-get install -y nginx php7.0 unzip
# Installs nginx/PHP 7.x.

WORKDIR /var/spherical
COPY . .
# Sets the work directory and copies everything there.

RUN wget https://captcha.com/bd4/botdetect-php-captcha-component-free.zip
# Downloads BotDetect CAPTCHA.

RUN unzip botdetect-php-captcha-component-free.zip
# Unzips the BotDetect CAPTCHA library.

RUN cp -R ./BotDetect-PHP-CAPTCHA-Component-Free-v4.2.3/lib/ "/var/spherical/BotDetect CAPTCHA Handler/botdetect/"
# Copies BotDetect CAPTCHA into the folder where the PHP is.

RUN rm -rf ./BotDetect-PHP-CAPTCHA-Component-Free-v4.2.3/ && rm ./botdetect-php-captcha-component-free.zip
# Deletes the garbage files.
