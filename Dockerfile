FROM ubuntu:14.10
MAINTAINER Randall Mason <randall@mason.ch>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -q -y git curl build-essential python software-properties-common npm virtualenv nodejs-legacy pwgen tmux

RUN echo %sudo        ALL=NOPASSWD: ALL >> /etc/sudoers
RUN useradd -ms /bin/bash cloud9
RUN adduser cloud9 sudo
RUN mkdir /workspace
RUN chown cloud9:cloud9 /workspace

USER cloud9
WORKDIR /home/cloud9/

# Needed until virtualenv is pulled upstream.
ENV version c15c243
RUN git clone -b node-early-ref https://github.com/ClashTheBunny/install.git c9install
RUN c9install/install.sh

RUN git clone https://github.com/c9/core.git c9sdk

WORKDIR /home/cloud9/c9sdk
RUN scripts/install-sdk.sh

ENV NODE_PATH=/home/cloud9/.c9/node_modules

ENTRYPOINT ["/home/cloud9/.c9/node/bin/node", "server"]
CMD ["-w", "/workspace", "-p", "8181"]
