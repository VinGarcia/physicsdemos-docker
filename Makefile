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

build:
	@# Build/rebuild any images whose Dockerfile
	@# might have changed since last build:
	docker-compose build
