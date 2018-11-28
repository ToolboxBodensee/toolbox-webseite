LEKTOR_SERVER_FLAGS=-h 127.0.0.1

all: build

sass:
	sassc ./assets/sass/main.scss ./assets/css/main.css
	sassc ./assets/sass/ie9.scss ./assets/css/ie9.css

install:
	pip install lektor

build: sass
	lektor build

deploy:
	lektor deploy --key $(LEKTOR_DEPLOY_KEY) toolbox

server:
	lektor server $(LEKTOR_SERVER_FLAGS)

## Docker stuff
IMAGE_TAG:=v1.2.0
IMAGE:=toolboxbodensee/lektor:$(IMAGE_TAG)

CACHE:=$(HOME)/.cache
CACHE_VOL:=-v $(CACHE)/lektor:/home/lektor/.cache/lektor
SOURCE_VOL:=-v $(PWD):/opt/lektor

DOCKER_CACHE_DIR:=$(CACHE)/docker
DOCKER_CACHE:=$(DOCKER_CACHE_DIR)/lektor.tar.gz

DOCKER_FLAGS:=--rm -it
DEPLOY_FLAGS:=-e LEKTOR_DEPLOY_KEY -v $(HOME)/.ssh/known_hosts:/root/.ssl/known_hosts

EXPORTED_PORTS=-p 5000:5000

DOCKER_RUN:=docker run $(DOCKER_FLAGS) $(SOURCE_VOL) $(CACHE_VOL)

"$(DOCKER_CACHE_DIR)":
	mkdir -p "$(DOCKER_CACHE_DIR)"

docker-pull: "$(DOCKER_CACHE_DIR)"
	if [ -f "$(DOCKER_CACHE)" ]; then gzip -dc "$(DOCKER_CACHE)" | docker load; fi
	docker pull $(IMAGE) && docker save $(IMAGE) | gzip > "$(DOCKER_CACHE)"

docker-build: docker-pull
	$(DOCKER_RUN) $(IMAGE) make build

docker-deploy: docker-build
	$(DOCKER_RUN) $(DEPLOY_FLAGS) $(IMAGE) make deploy

docker-shell: docker-pull
	$(DOCKER_RUN) $(EXPORTED_PORTS) $(IMAGE) /bin/sh

docker-server: docker-build
	$(DOCKER_RUN) $(EXPORTED_PORTS) $(IMAGE) lektor server -h 0.0.0.0