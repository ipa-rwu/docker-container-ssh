FROM openjdk:7

RUN apt-get update && \
    apt-get install -y openssh-server vim

EXPOSE 22


RUN useradd -rm -d /home/nf2/ -s /bin/bash -g root -G sudo -u 1001 ubuntu
USER ubuntu
WORKDIR /home/ubuntu

RUN mkdir -p /home/nf2/.ssh/ && \
    chmod 0700 /home/nf2/.ssh  && \
    touch /home/nf2/.ssh/authorized_keys && \
    chmod 600 /home/nf2/.ssh/authorized_keys && \
    touch /home/nf2/.ssh/config && \
    chmod 600 /home/nf2/.ssh/config

COPY --chown=ubuntu:root ssh-keys/ /keys/
RUN cat /keys/ssh_test.pub >> /home/nf2/.ssh/authorized_keys
RUN cat /keys/config >> /home/nf2/.ssh/config

USER root
ENTRYPOINT service ssh start && bash
