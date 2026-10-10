FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/sshd \
    && echo 'root:root123' | chpasswd \
    && printf 'PermitRootLogin yes\nPasswordAuthentication yes\n' > /etc/ssh/sshd_config.d/10-tp-docker.conf

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]
