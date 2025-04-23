#!/bin/ash

# This script is used to change the UID and GID of the 'node' user

# required shadow su-exec packages

# Cleanup function to run on SIGTERM
cleanup() {
    echo "Caught SIGTERM, stopping..."
    for ep in /etc/entrypoint.d/*.stop; do
        if [ -x "${ep}" ]; then
            echo "Running: ${ep}"
            ash -a -c "${ep}"
        fi
    done
    exit 0
}

if [ -z "$1" ]; then
    echo "No command provided. Exiting."
    exit 1
fi

# Check if FORCE_UID is set, otherwise just run the command
if [ -z "$FORCE_UID" ]; then
    exec "/etc/entrypoint.d/entrypoint.rc.d" "$@"
fi

USER_ID="$FORCE_UID"
GROUP_ID="${FORCE_GID:-1000}"

# Elevate to root if not already running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Redefined UID=${FORCE_UID} and GID=${FORCE_GID} for node user. Temporary elevate to root"
    exec sudo FORCE_UID="$FORCE_UID" FORCE_GID="$FORCE_GID" "$0" "$@"
fi

# Change UID and GID for user 'node'
usermod -u "$USER_ID" node
groupmod -g "$GROUP_ID" node

# Refresh ownership of home directory
if [ -d "/home/node" ]; then
    chown -R node:node /home/node
fi

# Refresh ownership of app_folder
if [ -d "/ws" ]; then
    chown node:node "/ws"
fi

# Execute this as the 'node' user
exec su-exec node "/etc/entrypoint.d/entrypoint.rc.d" "$@"
