## Physicsdemos Docker

This project is the recommended way to deploy the physicsdemos website.

### Download and Setup

First make sure you have all dependencies installed:

1. `git`
2. `docker` and `docker-compose`
3. `make`

Then proceed to clone this project **recursively**:

```
git clone --recursive http://git.luar.dcc.ufmg.br/lfs/physicsdemos-docker.git
```

> You will need access to the repositories: `physicsdemos-docker` and `physicsdemos`;
> If you don't have it yet ask the developer in charge to give it to you.

Then build it:

```
cd physicsdemos-docker
make up
```

Then website should be available for you in the url:

- `http://localhost:80/` or simply `localhost`

If you need to change the port used you may edit the
`docker-compose.yml` file and replace "80:80" for "####:80"
where "####" is the port you prefer.

### Commands

The `Makefile` contain a few important commands:

- `make up`: Start your server and download/build any dependencies
- `make login [container=app|mysql|redis]`: Login into any of the 3 containers (if ommited app is the default)
- `make down`: Stops and removes all containers.
- `make build`: Use it if you ever make changes to Dockerfile so its image is updated.

Tips:

1. To use composer or any php commands you must login into the app container.
2. To quickly login into the app container use `make`, it's equivalent to `make login container=app`.