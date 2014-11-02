FROM fedora:20

# RUN yum -y update
RUN yum install -y supervisor python-pip git
RUN \
    cd /tmp && \
    git clone https://github.com/arcolife/dockerComp.git && \
    cd dockerComp/client-side

EXPOSE 5000
EXPOSE 80

# RUN python app.py

# RUN cd docker
ADD config/supervisord.conf /etc/supervisord.conf
CMD ["supervisord","-n"]
