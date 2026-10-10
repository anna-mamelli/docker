#!/bin/bash
set -e

FTP_USER="${FTP_USER:-ftpuser}"
FTP_PASS="${FTP_PASS:-ftppass}"
WEB_DIR="/var/www/html"

mkdir -p "$WEB_DIR" /var/run/vsftpd/empty

if ! id "$FTP_USER" >/dev/null 2>&1; then
    useradd -d "$WEB_DIR" -s /bin/bash -M "$FTP_USER"
fi
echo "${FTP_USER}:${FTP_PASS}" | chpasswd

if [ -z "$(ls -A "$WEB_DIR")" ]; then
    if [ -n "$(ls -A /seed 2>/dev/null)" ]; then
        cp -r /seed/. "$WEB_DIR"/
    else
        echo "<h1>Serveur web pret</h1>" > "$WEB_DIR/index.html"
    fi
fi

chown -R "${FTP_USER}:${FTP_USER}" "$WEB_DIR"
chmod 755 "$WEB_DIR"

cp /etc/vsftpd.conf.tpl /etc/vsftpd.conf
if [ -n "${PASV_ADDRESS:-}" ]; then
    echo "pasv_address=${PASV_ADDRESS}" >> /etc/vsftpd.conf
fi

touch /var/log/vsftpd.log
tail -F /var/log/vsftpd.log &

vsftpd /etc/vsftpd.conf
