# Docker Reaper/Nigromancer

A very simplistic Docker container that monitors a set of containers and restarts them if they become unhealthy.

Currently it can monitor containers based on their name only.

![Docker Image Size](https://img.shields.io/docker/image-size/outlyernet/reaper-nigromancer)


## Information

* [Docker Hub (outlyernet/reaper-nigromancer)][dockerhub]
* [GitHub (outlyer-net/docker-reaper-nigromancer)][github]

## Usage

Let's say we want to monitor containers `some-app` and `some-server`. Create the container with:

   ```bash
   $ docker run \
            --name nigromancer \
            -v /var/run/docker.sock:/var/run/docker.sock \
            -e RESURRECT_NAMES="some-app some-server" \
            --restart always \
            outlyernet/reaper-nigromancer
   ```

## Architecture support

Currently the image found on Docker Hub supports the AMD64, i386, ARM v7 and ARM v8 (i.e. 64 bit ARM).

## References

This container was inspired by [docker-autoheal].

[microbadger]: https://microbadger.com/images/outlyernet/reaper-nigromancer
[docker-autoheal]: https://github.com/willfarrell/docker-autoheal
[dockerhub]: https://hub.docker.com/r/outlyernet/reaper-nigromancer/
[github]: https://github.com/outlyer-net/docker-reaper-nigromancer
