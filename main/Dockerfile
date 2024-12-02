# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# AUTHORS :  Emiliano Bruni (EB) <info@ebruni.it>
# DATE    :  2024-12-02
# PURPOSE :
#   Docker image node with git and pnpm enabled.
#
#   This image is published in docker hub with handle: ebruni/pnpm
#
# USAGE:
#   docker build -t pnpm .
#
# UPDATES:
#   AUTHOR  DATE        VER  COMMENTS
#   EB      2024-12-02  23.3.1  Add PNPM_HOME to PATH
#   EB      2024-12-02  23.3.0  First Release
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#

#
# this file is generated via docker-builder
#
# do not edit it directly
#
FROM node:23-alpine3.20
LABEL maintainer="Emiliano Bruni <info@ebruni.it>"
ENV TZ=Europe/Rome
ENV PNPM_HOME=/home/node/pnpm
ENV PATH=$PNPM_HOME:$PATH



RUN apk add --no-cache \
    git \
    tzdata \
    sudo \
    shadow \
  && corepack enable \
  # change node group and user id
  && usermod -u 1001 node && groupmod -g 1001 node \
  # add node tu sudoers
  && echo '%node ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/node \
  && su -c "pnpm set store-dir ${PNPM_HOME}/store" node \
  && apk del \
    shadow \
  && rm -rf /var/cache/apk/* \
  && rm -rf /tmp/* \
  && true

USER node

WORKDIR /ws

ARG NOW=not-set
LABEL org.opencontainers.image.authors="Emiliano Bruni <info@ebruni.it>"
LABEL org.opencontainers.image.created=$NOW
LABEL org.opencontainers.image.description="Docker image node with git and pnpm enabled."
LABEL org.opencontainers.image.documentation=https://github.com/EmilianoBruni/dockerhub-pnpm/blob/master/README.pod
LABEL org.opencontainers.image.licenses=Artistic-2.0
LABEL org.opencontainers.image.source=https://github.com/EmilianoBruni/dockerhub-pnpm/blob/master/main/Dockerfile
LABEL org.opencontainers.image.title=dockerhub-pnpm
LABEL org.opencontainers.image.url=https://github.com/EmilianoBruni/dockerhub-pnpm
LABEL org.opencontainers.image.version=23.3.1

CMD ["/bin/ash"]
