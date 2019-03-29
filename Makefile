LEKTOR_SERVER_FLAGS=-h 127.0.0.1

all: build

sass:
	echo "generating compressed css with sassc\n"
	sassc -t compressed ./assets/sass/main.scss ./assets/css/main.min.css
	sassc -t compressed ./assets/sass/ie9.scss ./assets/css/ie9.min.css
	lektor clean --yes
	lektor build

sass-uncompressed:
	echo "generating uncompressed css with sassc\n"
	sassc ./assets/sass/main.scss ./assets/css/main.css
	sassc ./assets/sass/ie9.scss ./assets/css/ie9.css
	lektor clean --yes
	lektor build

travis:
	echo "generating website with travis\n"
	pip install lektor
	if hash apt 2>/dev/null; then sudo apt update; sudo apt install imagemagick -y; elif hash pacman 2>/dev/null; then sudo pacman -Sy imagemagick --noconfirm; elif hash dnf 2>/dev/null; then sudo dnf install -y ImageMagick; else echo -e "Please install Imagemagick"; fi
	git clone https://github.com/sass/sassc.git
	. sassc/script/bootstrap
	make -C sassc -j4
	./sassc/bin/sassc -t compressed ./assets/sass/main.scss ./assets/css/main.min.css
	./sassc/bin/sassc -t compressed ./assets/sass/ie9.scss ./assets/css/ie9.min.css
	lektor clean --yes
	lektor build

install:
	pip install lektor --user
	if hash apt 2>/dev/null; then sudo apt update; sudo apt install imagemagick -y; elif hash pacman 2>/dev/null; then sudo pacman -Sy imagemagick --noconfirm; elif hash dnf 2>/dev/null; then sudo dnf install -y ImageMagick; else echo -e "Please install Imagemagick"; fi
	if hash apt 2>/dev/null; then sudo apt update; sudo apt install sassc -y; elif hash pacman 2>/dev/null; then sudo pacman -Sy sassc --noconfirm; elif hash dnf 2>/dev/null; then sudo dnf install -y sassc; else echo -e "Please install sassc\nhttps://github.com/sass/sassc/blob/master/docs/building/unix-instructions.md"; fi

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
