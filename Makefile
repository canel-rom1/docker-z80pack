prefix ?= canelrom1
name   ?= z80pack
tag    ?= $(shell date +%y.%m.%m)
repo_git ?= 

all: run

run:
	docker run -it --name $(name) $(repo_git) $(prefix)/$(name):latest bash

build: Dockerfile
	docker build -t $(prefix)/$(name):$(tag) .
	docker tag $(prefix)/$(name):$(tag) $(prefix)/$(name):latest 

clean-docker:
	docker rmi $(prefix)/$(name):$(tag)

clean-docker-latest:
	docker rmi $(prefix)/$(name):latest

clean: clean-docker clean-docker-latest


# vim: ft=make
