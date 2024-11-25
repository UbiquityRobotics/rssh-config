.PHONY: install uninstall

install: rssh.service
	mkdir -p /etc/docker/compose/rssh
	cp docker-compose.yml rssh.env /etc/docker/compose/rssh
	cp rssh.service /etc/systemd/system/
	systemctl enable rssh.service

uninstall: rssh.service
	systemctl disable rssh.service
	rm /etc/systemd/system/rssh.service
	rm -rf /etc/docker/compose/rssh
