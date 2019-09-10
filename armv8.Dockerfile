# docker-reaper-nigromancer
#
# This Dockerfile creates an image for the armv8 architecture.
#
# <https://github.com/outlyer-net/docker-reaper-nigromancer>
#
# Must be defined before the first FROM
ARG DOCKER_PREFIX=arm64v8
ARG ARCHITECTURE=

# Stage 0: Preparations. To be run on the build host
FROM alpine:latest
ARG ARCHITECTURE
ARG ALPINE_ARCH=aarch64
# Fetch docker for the target architecture
# FIXME: This is an ugly hack, but can't run apk cross-platform on stage 1
RUN apk update \
	&& wget -O /docker-cli.apk `apk policy docker-cli | tail -1`/${ALPINE_ARCH}/docker-cli-`apk policy docker-cli \
		| sed -e '2!d' -e 's/ *//' -e 's/://'`.apk
# Extract the archive's actual contents (the docker binary)
RUN tar xvf /docker-cli.apk usr/bin/docker

# Stage 1: The actual produced image
FROM ${DOCKER_PREFIX}/alpine:latest
LABEL maintainer="Toni Corvera <outlyer@gmail.com>"
ARG ARCHITECTURE
# import docker binary from previous stage
# FIXME: ugly hack part 2
COPY --from=0 /usr/bin/docker /usr/local/bin/

COPY monitor.sh /

ENTRYPOINT ["/monitor.sh"]
