FROM debian:jessie
MAINTAINER Randall Mason <randall@mason.ch>

ENV LAST_APT_GET_UPDATE=1494695501

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y git curl build-essential python software-properties-common npm virtualenv nodejs-legacy pwgen tmux ssh sudo

RUN echo %sudo        ALL=NOPASSWD: ALL >> /etc/sudoers
RUN useradd -ms /bin/bash cloud9 && adduser cloud9 sudo
RUN mkdir /workspace && chown cloud9:cloud9 /workspace

USER cloud9
WORKDIR /home/cloud9

RUN git clone https://github.com/c9/install.git c9install && c9install/install.sh

RUN git clone https://github.com/c9/core.git c9sdk

WORKDIR /home/cloud9/c9sdk
ENV PATH=/home/cloud9/.c9/node/bin:$PATH
ENV NODE_PATH=/home/cloud9/.c9/node_modules
RUN scripts/install-sdk.sh

USER root
RUN rm /etc/sudoers
RUN echo %sudo        ALL=NOPASSWD: ALL >> /etc/sudoers
USER cloud9

ENTRYPOINT ["node", "server"]
CMD ["-w", "/workspace", "-p", "8181", "--collab", "-a", ":", "-l", "0.0.0.0"]
