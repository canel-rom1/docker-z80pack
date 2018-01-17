prefix  ?= canelrom1
name    ?= z80pack
tag     ?= $(shell date +%y.%m.%d)

env_file = ./environment.conf

all: run

run:
	test -f $(env_file) \
		&& docker run -it --name $(name) --env-file=$(env_file) $(prefix)/$(name):latest bash \
		|| docker run -it --name $(name) $(prefix)/$(name):latest bash

build: Dockerfile
	docker images -q $(prefix)/$(name):latest >> .imagesid
	docker build -t $(prefix)/$(name):$(tag) .
	docker tag $(prefix)/$(name):$(tag) $(prefix)/$(name):latest 

stop:
	docker stop $(name)

rm: stop
	docker rm $(name)

clean-old-images:
	docker rmi `tac .imagesid`

clean-docker:
	docker rmi $(prefix)/$(name):$(tag)

clean-docker-latest:
	docker rmi $(prefix)/$(name):latest

clean: clean-docker clean-docker-latest


# vim: ft=make
