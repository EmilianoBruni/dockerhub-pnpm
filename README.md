<!-- this file is generated via docker-builder, do not edit it directly -->


# What is pnpm?

pnpm is a Docker image node with git and pnpm enabled.

All images, unless explicitly defined, are based on [node:23-alpine3.20](https://hub.docker.com/repository/docker/node)

# Supported tags and respective Dockerfile links

* ebruni/pnpm: [23.3.4, latest (main/Dockerfile)](https://github.com/EmilianoBruni/dockerhub-pnpm/blob/master/main/Dockerfile) (size: ****)


# How to use this image

Start the application as

    $ docker run --rm -ti ebruni/pnpm

# Authors

Emiliano Bruni (EB) <info@ebruni.it>

# Changes

| AUTHOR | DATE | VER. | COMMENTS |
|:---|:---:|:---:|:---|
| EB | 2025-03-14 | 23.3.4 | Fix bugs |
| EB | 2025-03-13 | 23.3.3 | Add support for custom UID/GID for node user. Add colored prompt |
| EB | 2025-03-11 | 23.3.2 | Add tini as entrypoint. Update corepack to latest |
| EB | 2024-12-02 | 23.3.1 | Add PNPM_HOME to PATH |
| EB | 2024-12-02 | 23.3.0 | First Release |

# Source

The source of this image on [GitHub](https://github.com/EmilianoBruni/dockerhub-pnpm).
