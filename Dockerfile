#FROM centos:7
FROM sjoeboo/baseimage:latest
MAINTAINER mattthew.a.nicholson@gmail.com

VOLUME /config
VOLUME /data 
EXPOSE 80
EXPOSE 443

RUN ln -s /opt/puppetlabs/bin/puppet /usr/local/bin/puppet
RUN mkdir /puppet/
ADD Puppetfile /puppet/Puppetfile
ADD default.pp /puppet/default.pp
ADD files/ /puppet/files
ADD templates/ puppet/templates

WORKDIR /puppet/

RUN /usr/local/bin/librarian-puppet install --verbose 
RUN /opt/puppetlabs/bin/puppet apply --modulepath=/puppet/modules/ /puppet/default.pp -v

CMD /usr/bin/supervisord -n -c /etc/supervisord.conf
