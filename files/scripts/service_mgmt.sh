#!/bin/bash

function debug()
{
    /usr/bin/logger $1
}

start() {
    debug "Starting ${SERVICE}$DEV service..."

    # start service docker
    /usr/bin/${SERVICE}.sh start $DEV

    debug "Started ${SERVICE}$DEV service..."
}

wait() {
    /usr/bin/${SERVICE}.sh wait $DEV
}

stop() {
    debug "Stopping ${SERVICE}$DEV service..."

    /usr/bin/${SERVICE}.sh stop $DEV

    debug "Stopped ${SERVICE}$DEV service..."
}

SCRIPT_NAME=$(basename -- "$0")
SERVICE="${SCRIPT_NAME%.*}"

case "$1" in
    start|wait|stop)
        $1
        ;;
    *)
        echo "Usage: $0 {start|wait|stop}"
        exit 1
        ;;
esac
