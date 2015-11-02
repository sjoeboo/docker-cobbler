FROM sjoeboo/baseimage:latest
MAINTAINER mattthew.a.nicholson@gmail.com

EXPOSE 80
EXPOSE 443

RUN ln -s /opt/puppetlabs/bin/puppet /usr/local/bin/puppet
RUN mkdir /puppet/
ADD Puppetfile /puppet/Puppetfile
ADD default.pp /puppet/default.pp
ADD files/ /puppet/files
ADD templates/ puppet/templates
ADD hiera.yaml /puppet/hiera.yaml
ADD hiera/  /puppet/hiera/
WORKDIR /puppet/

RUN /usr/local/bin/librarian-puppet install --verbose
RUN /opt/puppetlabs/bin/puppet apply --modulepath=/puppet/modules/ --hiera_config=/puppet/hiera.yaml -v /puppet/default.pp

CMD /usr/bin/supervisord -n -c /etc/supervisord.conf
