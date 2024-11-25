.PHONY: install uninstall

install: rssh.service
	mkdir -p /etc/docker/compose/rssh
	cp docker-compose.yml rssh.env /etc/docker/compose/rssh
	cp rssh.service /etc/systemd/system/
	ln -s "$(pwd)/data" /etc/docker/compose/rssh/data
	systemctl enable rssh.service

uninstall: rssh.service
	systemctl disable rssh.service
	rm /etc/systemd/system/rssh.service
	rm -rf /etc/docker/compose/rssh
