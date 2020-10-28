# ベースとなるdocker imageを指定
FROM ubuntu:20.04

# tzdataの設定で止まらないようにする
ENV DEBIAN_FRONTEND=noninteractive

# image作成時に実行するコマンド
RUN apt-get update && apt-get upgrade -y

# timezone setting
RUN apt-get install -y tzdata
ENV TZ=Asia/Tokyo 

# zip, unzip
RUN apt-get install -y zip unzip

# nano, less
RUN apt-get install -y nano less

# sudo
RUN apt-get install -y sudo

# curl
RUN apt-get install -y curl

# java jre
RUN apt-get install -y openjdk-8-jre-headless

# gcc, g++
# RUN apt-get install -y build-essential
# minisatなどで利用されている圧縮ライブラリ
# RUN apt-get install -y zlib1g-dev
# java jdk
# RUN apt-get install -y default-jdk
# git
# RUN apt-get install -y git

# apt-get clean
RUN apt-get clean

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
RUN useradd -G sudo -u 1000 -ms /bin/bash cspsat
RUN echo 'cspsat:cspsat' | chpasswd
USER cspsat
RUN echo 'export PATH=/usr/local/scala-2.12.8/bin:$PATH' >>~/.bashrc
WORKDIR /work
