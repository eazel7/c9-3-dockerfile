FROM ubuntu:14.10
MAINTAINER Randall Mason <randall@mason.ch>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y git curl build-essential python software-properties-common npm virtualenv nodejs-legacy pwgen tmux ssh

RUN echo %sudo        ALL=NOPASSWD: ALL >> /etc/sudoers
RUN useradd -ms /bin/bash cloud9 && adduser cloud9 sudo
RUN mkdir /workspace && chown cloud9:cloud9 /workspace

USER cloud9
WORKDIR /home/cloud9

RUN git clone -b node-early-ref https://github.com/ClashTheBunny/install.git c9install && c9install/install.sh

RUN git clone https://github.com/c9/core.git c9sdk

WORKDIR /home/cloud9/c9sdk
ENV PATH=/home/cloud9/.c9/node/bin:$PATH
ENV NODE_PATH=/home/cloud9/.c9/node_modules
RUN scripts/install-sdk.sh

ENTRYPOINT ["node", "server"]
CMD ["-w", "/workspace", "-p", "8181", "--collab", "-a", ":", "-l", "0.0.0.0"]
