FROM ubuntu:22.04

USER root
ENV HOME="/root"

# Install & configure necessory tools
RUN apt-get update && \
    apt-get install -y zip unzip curl git git-lfs wget python3 python3-pip && \
    pip3 install pyyaml && \
    pip3 install psutil


RUN mkdir -p ${HOME}/.bashrc.d

# Install SDKMAN
RUN curl -fsSL "https://get.sdkman.io" | bash

# 指定时区为中国（Asia/Shanghai）,并设置语言环境为UTF-8
ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8 