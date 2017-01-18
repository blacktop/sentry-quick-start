#!/bin/bash

set -e

# Wait for. Params: host, port, service
waitFor() {
    echo -n "===> Waiting for ${3}(${1}:${2}) to start..."
    i=1
    while [ $i -le 20 ]; do
        if nc -vz ${1} ${2} 2>/dev/null; then
            echo "${3} is ready!"
            return 0
        fi

        echo -n '.'
        sleep 1
        i=$((i+1))
    done

    echo
    echo >&2 "${3} is not available"
    echo >&2 "Address: ${1}:${2}"
}

waitFor redis 6379 Redis
waitFor postgres 5432 Postgres

# first check if we're passing flags, if so
# prepend with sentry
if [ "${1:0:1}" = '-' ]; then
	set -- sentry "$@"
fi

case "$1" in
	celery|cleanup|config|createuser|devserver|django|exec|export|help|import|init|plugins|queues|repair|run|shell|start|tsdb|upgrade)
		set -- sentry "$@"
	;;
esac

if [ "$1" = 'sentry' ]; then
	set -- tini -- "$@"
	if [ "$(id -u)" = '0' ]; then
		mkdir -p "$SENTRY_FILESTORE_DIR"
		chown -R sentry "$SENTRY_FILESTORE_DIR"
		set -- gosu sentry "$@"
	fi
fi

exec "$@"
