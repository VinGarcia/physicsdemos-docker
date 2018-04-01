proj_name=physicsdemos
container=app
fullname=$(proj_name).$(container)

login:
	@# Login as root on netlex-site:
	docker exec -it $(fullname) bash

up:
	@# Always rebuild netlex-site on deploy:
	docker stop $(fullname) &> /dev/null || true
	docker-compose up -d

down:
	docker-compose down

logs:
	@# Follow all the logs from the
	@# composed containers:
	docker-compose logs -f

build: setup
	@# Build/rebuild any images whose Dockerfile
	@# might have changed since last build:
	docker-compose build
	@
	@echo '`make build` completed successfully'

setup: .setup.mk

.setup.mk:
	@# Setup the physicsdemos website:
	@cd site && make setup
	@
	@# Start mysql container:
	@docker-compose up -d mysql
	@# Wait until mysql container is ready:
	@sleep 1
	@# Insert all the default video-data and users into the database:
	@echo 'CREATE DATABASE IF NOT EXISTS physicsdemos;' | docker exec -i physicsdemos.mysql mysql -u root -p1234 &> /dev/null
	@cat site/physicsdemos.sql | docker exec -i physicsdemos.mysql mysql physicsdemos -u root -p1234 &> /dev/null
	@# Stop mysql container
	@docker-compose stop mysql
	@
	@# Setup docker configuration for the website to work properly:
	@cd site/config && cp physicsdemos-settings.examples/docker-default.php physicsdemos-settings.php
	@
	@# Save a file to tell make this process has completed succesfully:
	@echo '`make setup` completed successfully'
	@echo '`make setup` completed successfully' > .setup.mk
	@
	@echo 'You still need to download the physicsdemos-data directory!'
