NS = alexellis2
VERSION ?= 2
REPO = python2-armhf

.PHONY: build push shell run start stop rm release

build:
	docker build -t $(NS)/$(REPO):$(VERSION) .
push:
	docker push $(NS)/$(REPO):$(VERSION)

default: build

