LEKTOR_SERVER_FLAGS=-h 127.0.0.1

all: build

install:
	pip install lektor

build: install
	lektor build

deploy:
	lektor deploy --key $(LEKTOR_DEPLOY_KEY) toolbox

server:
	lektor server $(LEKTOR_SERVER_FLAGS)