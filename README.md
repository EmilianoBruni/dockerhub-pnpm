<!-- this file is generated via docker-builder, do not edit it directly -->


# What is pnpm?

pnpm is a Docker image node with git and pnpm enabled.

All images, unless explicitly defined, are based on [node:24-alpine3.22](https://hub.docker.com/repository/docker/node)

# Supported tags and respective Dockerfile links

* ebruni/pnpm: [24.3.0, latest (main/Dockerfile)](https://github.com/EmilianoBruni/dockerhub-pnpm/blob/master/main/Dockerfile) (size: ****)


# How to use this image

Start the application as

    $ docker run --rm -ti ebruni/pnpm

# Environment variables

This image runs under the user *node* (uid/gid 1000/1000) by default.

You can match the UID/GID of the user in the container with the UID of the user on your host system. 
This is useful if you want to mount a volume from your host system into the container.

You can do this by setting the environment variable `FORCE_UID` to the UID of the user on your host system and `FORCE_GID` to the GID of the user on your host system.

For example, if your user has UID 1000 and GID 1000, you can run the container like this:

    $ docker run --rm -ti -e FORCE_UID=1000 -e FORCE_GID=1000 ebruni/pnpm

This will set the UID and GID of the user in the container to the same UID and GID as the user on your host system. 

This way, you can avoid permission issues when mounting a volume from your host system into the container.

# Entrypoint.d

This image supports the multiple entrypoint.d scripts.
You can add your own scripts to the `/etc/entrypoint.d` directory in the container.
These scripts will be executed in alphabetical order when the container starts.
You can use this feature to run your own initialization scripts or to customize the behavior of the container.

Supported scripts are:

* `*.sh` - shell scripts running at startup in alphabetical
* `*.env` - environment variables to be set in the container
* `*.stop` - shell scripts running at shutdown in alphabetical order


# Authors

Emiliano Bruni (EB) <info@ebruni.it>

# Changes

| AUTHOR | DATE | VER. | COMMENTS |
|:---|:---:|:---:|:---|
| EB | 2026-01-08 | 24.3.0 | Switch to bash as default shell for node user and add bash autocomplete. Update node to 24.x and alpine to 3.22 |
| EB | 2025-05-12 | 23.3.6 | Add jq to process json files (package.json). |
| EB | 2025-04-23 | 23.3.5 | Add entrypoint.d system to run other script before command. |
| EB | 2025-03-14 | 23.3.4 | Fix bugs |
| EB | 2025-03-13 | 23.3.3 | Add support for custom UID/GID for node user. Add colored prompt |
| EB | 2025-03-11 | 23.3.2 | Add tini as entrypoint. Update corepack to latest |
| EB | 2024-12-02 | 23.3.1 | Add PNPM_HOME to PATH |
| EB | 2024-12-02 | 23.3.0 | First Release |

# Source

The source of this image on [GitHub](https://github.com/EmilianoBruni/dockerhub-pnpm).
