.PHONY: help

IMAGE_NAME ?= bitwalker/httpbin

help:
	@echo "$(IMAGE_NAME)"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Rebuild the Docker image
	docker build --force-rm -t $(IMAGE_NAME):latest .

run: build ## Rebuild and release the Docker image to Docker Hub
	docker run --rm -p 8080:8080 --net=host -it $(IMAGE_NAME):latest
