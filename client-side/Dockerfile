FROM ubuntu:trusty
MAINTAINER Archit Sharma <archit.py@gmail.com>

RUN apt-get update
RUN apt-get install -y python python-pip python-dev
RUN apt-get install -y nginx supervisor curl git
RUN pip install uwsgi Flask

RUN \
    cd /tmp && \
    git clone https://github.com/arcolife/dockerComp.git && \
    cd dockerComp/client-side && \
    ./test.sh

ADD ./app /docker/app
ADD ./conf /docker/conf
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /docker/conf/app_nginx.conf /etc/nginx/sites-enabled/
RUN ln -s /docker/conf/app_supervisor.conf /etc/supervisor/conf.d/

EXPOSE 80
EXPOSE 5000
CMD ["supervisord", "-n"]
