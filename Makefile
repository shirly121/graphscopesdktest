.PHONY: all build push clean

DOCKER_FILE ?= ./Dockerfile
DOCKER_HUB ?= reg.docker.alibaba-inc.com/zxl
IMAGE_NAME ?= default
IMAGE_VERSION ?= 0.0.1

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	XARGS_EMPTY_FLAG := --no-run-if-empty
endif

ifeq ($(PROFILE),)
    PROFILE := debug
endif

all:
	@echo "target:"
	@echo "   build           : compile & build image using source from ROOT_DIR and DOCKER_FILE"
	@echo "   push            : docker push image to registry"
	@echo "   clean           : clean local build files"

build:
	docker build --target coordinator -t ${DOCKER_HUB}/${IMAGE_NAME}:${IMAGE_VERSION} -f ${DOCKER_FILE} .
	docker images -f "dangling=true" -q | xargs $(XARGS_EMPTY_FLAG) docker rmi -f

push:
	docker push ${DOCKER_HUB}/${IMAGE_NAME}:${IMAGE_VERSION}

clean:
	#cd $(ROOT_DIR) && rm -rf build
	#cd $(ROOT_DIR) && mvn clean
	docker ps -qa  | xargs $(XARGS_EMPTY_FLAG) docker rm -f
	docker images -f "dangling=true" -q | xargs $(XARGS_EMPTY_FLAG) docker rmi -f
