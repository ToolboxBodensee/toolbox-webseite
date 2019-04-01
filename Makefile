LEKTOR_SERVER_FLAGS=-h 127.0.0.1

all: build

install:
	echo "installiere lektor und ein paar abhängigkeiten"
	if hash apt 2>/dev/null; then sudo apt update; sudo apt install imagemagick nodejs yarn python3-pip -y;\
	elif hash pacman 2>/dev/null; then sudo pacman -Sy imagemagick nodejs yarn python-pip --noconfirm;\
	elif hash dnf 2>/dev/null; then sudo dnf install -y ImageMagick nodejs yarn python3-pip;\
	else echo -e "Please install Imagemagick, NodeJS, yarn and pip "; fi
	pip install lektor --user

build:
	lektor clean
	lektor build -f webpack

server:
	lektor server -f webpack $(LEKTOR_SERVER_FLAGS)

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
	$(DOCKER) $(RUN) $(IMAGE) lektor build -f webpack

docker-shell: $(LEKTOR_CACHE) docker-pull
	$(DOCKER) $(RUN) $(EXPORTED_PORTS) $(IMAGE) /bin/sh

docker-server: $(LEKTOR_CACHE) docker-pull
	$(DOCKER) $(RUN) $(EXPORTED_PORTS) $(IMAGE) lektor server -f webpack -h 0.0.0.0
