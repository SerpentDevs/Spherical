# Spherical. Created by Jake Gealer <jake@gealer.email> 2018.

FROM python:3.6.6-stretch
# Sets the image to the Python 3.6.6 stretch image.

MAINTAINER jake@gealer.email
# Sets me as a maintainer.

RUN apt-get update && apt-get install -y nginx php7.0
# Installs nginx/PHP 7.x.


