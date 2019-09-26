LEKTOR_SERVER_FLAGS=-h 127.0.0.1
# prettify html output, minify javascript assets, compile scss assets
LEKTOR_PLUGIN_FLAGS=-f scss

all: build

.ONESHELL:
install:
	if hash apt-get 2>/dev/null; then
	  sudo apt-get update -qq >/dev/null && sudo apt-get install -qq apt-utils imagemagick python3-pip python3-setuptools gcc
	elif hash pacman 2>/dev/null; then
	  sudo pacman -Syu imagemagick python-pip glibc lib32-glibc gcc --noconfirm
	elif hash dnf 2>/dev/null; then
	  sudo dnf install -y ImageMagick python3-pip gcc
	else 
	  echo -e "Please install Imagemagick, python3-pip and gcc"
	fi
	pip3 install wheel --user
	pip3 install lektor --user
	./setup/install-pre-commit.sh


build:
	lektor clean --yes
	lektor plugin flush-cache 
	lektor build $(LEKTOR_PLUGIN_FLAGS)

server:
	lektor server $(LEKTOR_SERVER_FLAGS)
	
server-all:
	lektor clean --yes
	lektor plugin flush-cache
	lektor server $(LEKTOR_PLUGIN_FLAGS) $(LEKTOR_SERVER_FLAGS)

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
	$(DOCKER) $(RUN) $(IMAGE) lektor build $(LEKTOR_PLUGIN_FLAGS)

docker-shell: $(LEKTOR_CACHE) docker-pull
	$(DOCKER) $(RUN) $(EXPORTED_PORTS) $(IMAGE) /bin/sh

docker-server: $(LEKTOR_CACHE) docker-pull
	$(DOCKER) $(RUN) $(EXPORTED_PORTS) $(IMAGE) lektor server $(LEKTOR_PLUGIN_FLAGS) -h 0.0.0.0
