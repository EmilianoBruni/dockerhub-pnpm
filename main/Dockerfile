# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# AUTHORS :  Emiliano Bruni (EB) <info@ebruni.it>
# DATE    :  2025-05-12
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
#   EB      2025-05-12  23.3.6  Add jq to process json files (package.json).
#   EB      2025-04-23  23.3.5  Add entrypoint.d system to run other script before command.
#   EB      2025-03-14  23.3.4  Fix bugs
#   EB      2025-03-13  23.3.3  Add support for custom UID/GID for node user. Add colored prompt
#   EB      2025-03-11  23.3.2  Add tini as entrypoint. Update corepack to latest
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
ENV ENV=/etc/profile



RUN apk add --no-cache \
    git \
    tzdata \
    sudo \
    shadow \
    tini \
    su-exec \
    jq \
  # update corepack to latest version
  && npm install -g corepack \
  && corepack enable \
  # add node tu sudoers
  && echo '%node ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/node \
  && su -c "pnpm set store-dir ${PNPM_HOME}/store" node \
  && apk del \
  && rm -rf /var/cache/apk/* \
  && rm -rf /tmp/* \
  && true

COPY color_prompt.sh /etc/profile.d/color_prompt.sh
COPY entrypoint.sh /
COPY entrypoint.rc.d/ /etc/entrypoint.d/

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
LABEL org.opencontainers.image.version=23.3.6

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
CMD ["/bin/ash"]
