# ベースとなるdocker imageを指定
FROM alpine:3.12

# apk
RUN apk update && apk upgrade

# timezone setting
RUN apk add tzdata
ENV TZ=Asia/Tokyo 

# bash
RUN apk add bash

# sudo
RUN apk add sudo

# zip, unzip
RUN apk add zip unzip

# nano, less
RUN apk add nano less

# curl
RUN apk add curl

# perl
RUN apk add perl

# python
RUN apk add python3

# java jre
# RUN apk add openjdk11-jre-headless
RUN apk add openjdk8-jre

# remove apk cache
RUN rm -rf /var/cache/apk/*

# scala
RUN curl -LO https://downloads.lightbend.com/scala/2.12.8/scala-2.12.8.zip \
    && unzip scala-2.12.8.zip \
    && mv scala-2.12.8 /usr/local/ \
    && chmod +x /usr/local/scala-2.12.8/bin/*

# cspsat-setup
RUN curl -LO https://github.com/tamura70/cspsat-setup/archive/main.zip \
    && unzip main.zip \
    && chmod +x cspsat-setup-main/bin/* \
    && cp -pr cspsat-setup-main/bin/* /usr/local/bin/ \
    && cp -pr cspsat-setup-main/lib/* /usr/local/lib/

# User
RUN adduser -S -h /home/cspsat -s /bin/bash -u 2000 -G users cspsat \
    && mkdir -p /home/cspsat && chown cspsat.users /home/cspsat \
    && echo "cspsat ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && echo 'cspsat:cspsat' | chpasswd
USER cspsat
RUN echo 'umask 0002' >>~/.bashrc
RUN echo 'export PATH=/usr/local/scala-2.12.8/bin:$PATH' >>~/.bashrc
WORKDIR /work
