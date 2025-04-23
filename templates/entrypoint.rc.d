#!/bin/ash
set -e

for ep in /etc/entrypoint.d/*; do
    ext="${ep##*.}"
    if [ "${ext}" = "env" -a -f "${ep}" ]; then
        # source files ending in ".env"
        echo "Sourcing: ${ep}"
        set -a && . "${ep}" && set +a
    elif [ "${ext}" = "sh" -a -x "${ep}" ]; then
        # run scripts ending in ".sh"
        echo "Running: ${ep}"
        ash -a -c "${ep} $@"
    fi
done

cleanup() {
    echo "Caught SIGTERM, stopping..."
    for ep in /etc/entrypoint.d/*.stop; do
        if [ -x "${ep}" ]; then
            echo "Running: ${ep}"
            ash -a -c "${ep}"
        fi
    done
    echo "All done, exit"
    exit 0
}

#Trap SIGTERM (notty) and EXIT(tty) signals
trap 'cleanup' SIGTERM EXIT

# run command with exec to pass control
if [ -n "$1" ]; then
    echo "Running CMD: $@"
    # check if tty is available
    if [ -t 0 ]; then
        # tty available: run command with exec to pass control
        exec "$@" </dev/tty >/dev/tty 2>&1 &
    else
        # tty not available: run command with exec to pass control
        exec "$@" &
    fi
    wait $!
else
    echo "No command provided. Exiting."
    exit 1
fi