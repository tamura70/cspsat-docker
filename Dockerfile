# ベースとなるdocker imageを指定
FROM ubuntu:20.04

# tzdataの設定で止まらないようにする
ENV DEBIAN_FRONTEND=noninteractive

# image作成時に実行するコマンド
RUN apt-get update && apt-get upgrade -y

# timezone setting
RUN apt-get install -y tzdata
ENV TZ=Asia/Tokyo 

## gcc, g++
RUN apt-get install -y build-essential

## minisatなどで利用している圧縮ライブラリ
RUN apt-get install -y zlib1g-dev

## java
RUN apt-get install -y default-jdk

## scala
RUN apt-get install -y scala

## git
RUN apt-get install -y git

## unzip
RUN apt-get install -y unzip

## nano
RUN apt-get install -y nano

## cspsat-setup
RUN git clone https://github.com/tamura70/cspsat-setup.git
RUN cd cspsat-setup && make install

# User
RUN useradd -ms /bin/bash cspsat
USER cspsat
WORKDIR /work
