.PHONY: default setup letsencrypt generate_dhparam install uninstall

default: setup install

setup:
	apt update
	apt install -y python3 python3-venv pipx libaugeas0 openssl

generate_dhparam:
	openssl dhparam -out ./nginx/dhparam.pem 2048

letsencrypt: setup generate_dhparam
	pipx ensurepath
	pipx install certbot
	certbot certonly --standalone
	echo "/usr/bin/env python3 -c 'import random; import time; time.sleep(random.random() * 3600)' && sudo certbot renew -q" > /etc/cron.weekly/certbot && chmod +x /etc/cron.weekly/certbot
	chown -R root:www-data /etc/letsencrypt/live/
	chown -R root:www-data /etc/letsencrypt/archive/
	chmod -R 640 /etc/letsencrypt/live/
	chmod -R 640 /etc/letsencrypt/archive/

install: setup nginx/dhparam.pem rssh.service
	mkdir -p /etc/docker/compose/rssh
	cp docker-compose.yml rssh.env /etc/docker/compose/rssh
	cp rssh.service /etc/systemd/system/
	ln -s "$(shell pwd)/data" /etc/docker/compose/rssh/data
	systemctl enable rssh.service

uninstall: rssh.service
	systemctl disable rssh.service
	rm /etc/systemd/system/rssh.service
	rm -rf /etc/docker/compose/rssh
