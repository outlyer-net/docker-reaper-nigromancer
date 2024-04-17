# Official and semi-official architectures: https://github.com/docker-library/official-images#architectures-other-than-amd64

# A new version can be prepared with, e.g. for version r2:
# make push TAG=r2 && make push


IMAGE_NAME=outlyernet/reaper-nigromancer

POST_BUILD_ACTION= # --load not supported with manifests
TAG=latest

build: prepare
	docker buildx build \
		--platform linux/amd64,linux/386,linux/arm/v7,linux/arm64/v8 \
		$(POST_BUILD_ACTION) \
		-t $(IMAGE_NAME):$(TAG) .

prepare:
	@# Create the builder, multiarch requires one to be created
	-docker buildx create --use --name "multiarch"

# Repository-specific stuff. Can only be used as-is by me

# Not invoked by default since it slows things down
login:
	docker login

push:
	$(MAKE) POST_BUILD_ACTION=--push

.PHONY: build prepare login push
