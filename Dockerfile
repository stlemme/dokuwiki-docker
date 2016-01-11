FROM istepanov/dokuwiki
MAINTAINER Stefan Lemme <stefan.lemme@dfki.de>

RUN mkdir -p /var/dokuwiki-storage/lib/plugins && \
    cd /var/www && \
    mv /var/www/lib/plugins /var/dokuwiki-storage/lib/plugins && \
    ln -s /var/dokuwiki-storage/lib/plugins /var/www/lib/plugins
