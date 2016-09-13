NS = alexellis2
VERSION ?= 4.4
REPO = nodejs-armv6

.PHONY: build push shell run start stop rm release

build:
	docker build -t $(NS)/$(REPO):$(VERSION) .
push:
	docker push $(NS)/$(REPO):$(VERSION)

default: build

