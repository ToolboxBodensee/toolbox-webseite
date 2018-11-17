LEKTOR_SERVER_FLAGS=-h 127.0.0.1

all: build

build:
	lektor build

deploy:
	lektor deploy --key $(LEKTOR_DEPLOY_KEY) toolbox

server:
	lektor server $(LEKTOR_SERVER_FLAGS)

## Docker stuff
IMAGE:=toolboxbodensee/lektor:latest

CACHE:=$(HOME)/.cache
CACHE_VOL:=-v $(CACHE)/lektor:/root/.cache/lektor
SOURCE_VOL:=-v $(PWD):/opt/lektor

DOCKER_FLAGS:=--rm -it
DEPLOY_FLAGS:=-e LEKTOR_DEPLOY_KEY -v $(HOME)/.ssh/known_hosts:/root/.ssl/known_hosts

EXPORTED_PORTS=-p 5000:5000

DOCKER_RUN:=docker run $(DOCKER_FLAGS) $(SOURCE_VOL) $(CACHE_VOL)

docker-pull:
	docker pull $(IMAGE)

docker-build: docker-pull
	$(DOCKER_RUN) $(IMAGE) make build

docker-deploy: docker-build
	$(DOCKER_RUN) $(DEPLOY_FLAGS) $(IMAGE) make deploy

docker-shell: docker-pull
	$(DOCKER_RUN) $(EXPORTED_PORTS) $(IMAGE) /bin/sh

docker-server:
	$(DOCKER_RUN) $(EXPORTED_PORTS) $(IMAGE) lektor server -h 0.0.0.0