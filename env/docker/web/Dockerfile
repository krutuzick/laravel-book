FROM nginx
MAINTAINER krutuzick <krutuzick@gmail.com>

# workaround for bug https://github.com/boot2docker/boot2docker/issues/581
RUN usermod -u 1000 www-data

# set timezone
RUN echo Europe/Moscow | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

COPY env/docker/web/conf.d /etc/nginx/conf.d

VOLUME /var/www