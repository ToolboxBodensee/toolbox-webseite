LEKTOR_SERVER_FLAGS=-h 127.0.0.1

all: build

sass:
	sassc -t compressed ./assets/sass/main.scss ./assets/css/main.min.css
	sassc -t compressed ./assets/sass/ie9.scss ./assets/css/ie9.min.css
	lektor clean --yes
	lektor build

sass-uncompressed:
	sassc ./assets/sass/main.scss ./assets/css/main.css
	sassc ./assets/sass/ie9.scss ./assets/css/ie9.css
	lektor clean --yes
	lektor build

install-travis:
	pip install lektor
	if hash apt 2>/dev/null; then sudo apt update; sudo apt install imagemagick -y; elif hash pacman 2>/dev/null; then sudo pacman -Sy imagemagick --noconfirm; elif hash dnf 2>/dev/null; then sudo dnf install -y ImageMagick; else echo -e "Please install Imagemagick"; fi
	if hash apt 2>/dev/null; then sudo apt install sassc -y; elif hash pacman 2>/dev/null; then sudo pacman -Sy sassc --noconfirm; elif hash dnf 2>/dev/null; then sudo dnf install -y sassc; else echo -e "Please install sassc"; fi

install:
	pip install lektor --user
	if hash apt 2>/dev/null; then sudo apt update; sudo apt install imagemagick -y; elif hash pacman 2>/dev/null; then sudo pacman -Sy imagemagick --noconfirm; elif hash dnf 2>/dev/null; then sudo dnf install -y ImageMagick; else echo -e "Please install Imagemagick"; fi
	if hash apt 2>/dev/null; then sudo apt install sassc -y; elif hash pacman 2>/dev/null; then sudo pacman -Sy sassc --noconfirm; elif hash dnf 2>/dev/null; then sudo dnf install -y sassc; else echo -e "Please install sassc"; fi

build: sass
	lektor build

server:
	lektor server $(LEKTOR_SERVER_FLAGS)

## Docker stuff
IMAGE_TAG:=v1.2.0
IMAGE:=toolboxbodensee/lektor:$(IMAGE_TAG)

PWD:=$(shell pwd)

CACHE:=$(HOME)/.cache
PWD:=$(shell pwd)

LEKTOR_CACHE:=$(CACHE)/lektor
CACHE_VOL:=-v $(CACHE)/lektor:/home/lektor/.cache/lektor
SOURCE_VOL:=-v $(PWD):/opt/lektor

EXPORTED_PORTS=-p 5000:5000

DOCKER:=docker

# On linux...
ifeq ($(shell uname),Linux)
	# When user is not in docker group
	ifneq ($(findstring docker,$(shell groups)),docker)
		# And the user is not root
		ifneq ($(shell whoami),root)
			# Run docker client inside docker group
			DOCKER:=sudo -E -g docker docker
		endif
	endif
endif

RUN:=run --rm -it $(SOURCE_VOL) $(CACHE_VOL)

$(LEKTOR_CACHE):
	mkdir -p $(LEKTOR_CACHE)

docker-pull:
	$(DOCKER) pull $(IMAGE)

docker-build: docker-pull $(LEKTOR_CACHE)
	$(DOCKER) $(RUN) $(IMAGE) make build

docker-shell: $(LEKTOR_CACHE) docker-pull
	$(DOCKER) $(RUN) $(EXPORTED_PORTS) $(IMAGE) /bin/sh

docker-server: $(LEKTOR_CACHE) docker-pull
	$(DOCKER) $(RUN) $(EXPORTED_PORTS) $(IMAGE) make sass
	$(DOCKER) $(RUN) $(EXPORTED_PORTS) $(IMAGE) lektor server -h 0.0.0.0
