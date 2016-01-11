FROM alpine:3.3
MAINTAINER Stefan Lemme <stefan.lemme@dfki.de>

WORKDIR /srv

RUN apk add --update apache2 php-apache2 php-xml && \
    rm -rf /var/cache/apk/*

RUN wget http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz && \
    tar -xzf dokuwiki-stable.tgz && \
    mv dokuwiki-2* /srv/dokuwiki && \
    rm dokuwiki-stable.tgz && \
    chown apache:apache -R /srv/dokuwiki

RUN mkdir /run/apache2 && \
    chown apache:apache -R /run/apache2

COPY httpd.conf /etc/apache2/httpd.conf

VOLUME ["/srv/dokuwiki/conf", "/srv/dokuwiki/data", "/srv/dokuwiki/lib/plugins"]

EXPOSE 80

ENTRYPOINT ["httpd", "-D", "FOREGROUND"]
