FROM alpine:3.3
MAINTAINER Stefan Lemme <stefan.lemme@dfki.de>

WORKDIR /srv

RUN apk add --update apache2 php-apache2 php-xml php-gd php-curl php-openssl php-zip php-zlib && \
    rm -rf /var/cache/apk/*

RUN wget http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz && \
    tar -xzf dokuwiki-stable.tgz && \
    mv dokuwiki-2* /srv/dokuwiki && \
    rm dokuwiki-stable.tgz && \
    chown -R apache:apache /srv/dokuwiki

RUN mkdir /dokuwiki-storage && \
    mv /srv/dokuwiki/conf /dokuwiki-storage/conf && \
    ln -s /dokuwiki-storage/conf /srv/dokuwiki/conf && \
    mv /srv/dokuwiki/data /dokuwiki-storage/data && \
    ln -s /dokuwiki-storage/data /srv/dokuwiki/data && \
    mv /srv/dokuwiki/lib/plugins /dokuwiki-storage/plugins && \
    ln -s /dokuwiki-storage/plugins /srv/dokuwiki/lib/plugins

RUN mkdir /run/apache2 && \
    chown -R apache:apache /run/apache2

ADD httpd.conf /etc/apache2/httpd.conf

VOLUME ["/dokuwiki-storage"]

EXPOSE 80

CMD ["httpd", "-D", "FOREGROUND"]
