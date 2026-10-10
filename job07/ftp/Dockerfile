FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends vsftpd \
    && rm -rf /var/lib/apt/lists/*

COPY vsftpd.conf /etc/vsftpd.conf.tpl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY seed/ /seed/

EXPOSE 21 21100-21110

ENTRYPOINT ["/entrypoint.sh"]
