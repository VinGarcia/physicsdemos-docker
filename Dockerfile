
FROM nimmis/apache-php7

RUN apt-get update -yqq &&\
    apt-get install -yqq vim

# Remove default apache configurations:
RUN rm -f /etc/apache2/sites-enabled/*
RUN cp /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/

WORKDIR /site

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND
