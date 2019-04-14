LEKTOR_SERVER_FLAGS=-h 127.0.0.1

all: build

install-packages:
	if hash apt 2>/dev/null; then sudo apt update; sudo apt install imagemagic python3-pip -y;\
	elif hash pacman 2>/dev/null; then sudo pacman -Sy imagemagick python-pip --noconfirm;\
	elif hash dnf 2>/dev/null; then sudo dnf install -y ImageMagick python3-pip;\
	else echo -e "Please install Imagemagick, NodeJS, yarn and python3-pip "; fi

install: install-packages
	pip3 install lektor --user
	echo "\nFor a complete install with all requirements like nodejs, please make:\nmake full-install\n\n"
	
install-nodejs:
	if hash apt 2>/dev/null; then sudo apt update; sudo apt install nodejs yarn -y;\
	elif hash pacman 2>/dev/null; then sudo pacman -Sy nodejs yarn lib32-icu --noconfirm;\
	elif hash dnf 2>/dev/null; then sudo dnf install -y nodejs yarn;\
	else echo -e "Please install Imagemagick, NodeJS, yarn and python3-pip "; fi

full-install: install-packages install-nodejs
	pip3 install lektor --user

virtual-env-install: install-packages
	if hash apt 2>/dev/null; then sudo apt update; sudo apt install python3-virtualenv -y;\
	elif hash pacman 2>/dev/null; then sudo pacman -Sy python-virtualenv --noconfirm;\
	elif hash dnf 2>/dev/null; then sudo dnf install -y python3-virtualenv;\
	else echo -e "Please install python-virtualenv "; fi
	virtualenv venv
	. venv/bin/activate
	pip3 install lektor

build:
	lektor clean --yes
	lektor build -f webpack

server:
	lektor server $(LEKTOR_SERVER_FLAGS)

virtual-env-server:
	. venv/bin/activate
	lektor server $(LEKTOR_SERVER_FLAGS)
	
server-all:
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
