# docker-reaper-nigromancer
#
# <https://github.com/outlyer-net/docker-reaper-nigromancer>

FROM alpine:latest

LABEL maintainer="Toni Corvera <outlyer@gmail.com>"

RUN apk add --no-cache docker-cli

COPY monitor.sh /

ENTRYPOINT ["/monitor.sh"]
