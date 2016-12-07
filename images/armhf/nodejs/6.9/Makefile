NS = alexellis2
VERSION ?= 6.9.2
REPO = nodejs-armhf

.PHONY: build push shell run start stop rm release

build:
	docker build -t $(NS)/$(REPO):$(VERSION) .
push:
	docker push $(NS)/$(REPO):$(VERSION)

default: build

