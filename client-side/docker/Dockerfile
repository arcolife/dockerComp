FROM fedora:20

RUN yum update
RUN yum install -y supervisor python-pip git
RUN \
    cd /tmp && \
    git clone https://github.com/arcolife/dockerComp.git\
    cd dockerComp/client-side

EXPOSE 5000
EXPOSE 80

RUN python run.py

# ADD config/supervisord.conf /etc/supervisord.conf
# CMD ["supervisord","-n"]
