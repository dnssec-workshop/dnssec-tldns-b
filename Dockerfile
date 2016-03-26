# Image: dnssec-tldns-a
# Startup a docker container as BIND slave for DNS TLDs

FROM dnssecworkshop/dnssec-bind

MAINTAINER dape16 "dockerhub@arminpech.de"

LABEL RELEASE=20160326-2104

# Set timezone
ENV     TZ=Europe/Berlin
RUN     ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Deploy DNSSEC workshop material
RUN     cd /root && git clone https://github.com/dnssec-workshop/dnssec-data && \
          rsync -v -rptgoD --copy-links /root/dnssec-data/dnssec-tldns-b/ /

# Start services using supervisor
RUN     mkdir -p /var/log/supervisor

EXPOSE  22 53
CMD     [ "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/dnssec-tldns-b.conf" ]

# vim: set syntax=docker tabstop=2 expandtab:
