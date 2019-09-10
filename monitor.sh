#!/bin/sh

# Quick and dirty docker container monitor and "healer" inspired by
# https://hub.docker.com/r/willfarrell/autoheal

# Environment variables:

# RESURRECT_IDS # TODO
# RESURRECT_NAMES

# TODO: Filter by label
if [ -z "$RESURRECT_NAMES" ]; then
    echo "The \$RESURRECT_NAME variable isn't defined! Can't do anything"
    exit 1
fi
echo "Monitoring: $RESURRECT_NAMES"

docker events \
    --filter 'event=health_status'  \
    --format '{{.Status}} {{.ID}} {{.Actor.Attributes.name}}'\
| \
    while read event ; do
        #event is "health_status: <status> <id> <name>"
        health_status=`echo "$event" | awk '{print $2}'`
        ct_id=`echo "$event" | awk '{print $3}'`
        ct_name=`echo "$event" | awk '{print $4}'`

        if [ "$health_status" = "unhealthy" ]; then
            echo "Unhealthy container event received"
            # Figure out if we care
            for name in $RESURRECT_NAMES; do
                if [ "$name" = "$ct_name" ]; then
                    echo "Trying to bring back container $ct_name, $ct_id"
                    docker container restart "$name"
                    break # breaks one level only!
                fi
            done
        fi
    done
