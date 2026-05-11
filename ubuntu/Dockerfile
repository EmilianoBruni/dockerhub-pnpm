FROM ubuntu:24.04

ARG NODE_VERSION=24

LABEL maintainer="Emiliano Bruni <info@ebruni.it>"
ENV TZ=Europe/Rome
ENV PNPM_HOME=/home/node/pnpm
ENV PATH=$PNPM_HOME/bin:$PATH
ENV ENV=/etc/profile
ENV SHELL=bash

ENV NVM_DIR=/usr/local/nvm


RUN apt-get update && apt-get install -y \
    locales curl git tzdata tini jq bash-completion sudo build-essential \
    # set locale
    && locale-gen it_IT && update-locale LANG=it_IT LANGUAGE=it_IT LC_ALL=it_IT \
    && mkdir -p $NVM_DIR \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash \
    # install su-exec
    && mkdir -p /tmp/su-exec \
    && git clone https://github.com/ncopa/su-exec.git /tmp/su-exec     && cd /tmp/su-exec \
    && make \
    && mv su-exec /usr/bin/ \
    && rm -rf /tmp/su-exec \
    # create node user and group 
    && groupadd -g 1001 node && useradd -rm -d /home/node -u 1001 -g node -s /bin/bash node \
    && echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    # cleanup
    && apt-get remove build-essential -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && true

# add entrypoint and entrypoint.d
COPY entrypoint.sh /
COPY entrypoint.rc.d/ /etc/entrypoint.d/
# add root bash prompt
COPY .root.bashrc /root/.bashrc_prompt
# add node bash prompt
COPY --chown=node:node .node.bashrc /home/node/.bashrc_prompt

# install node & create /(etc/profile.d/nvm.sh) to load nvm on shell startup
RUN echo "export NVM_DIR=\"$NVM_DIR\"" > /etc/profile.d/nvm.sh \
    && echo "echo 'Loading nvm from $NVM_DIR/nvm.sh'" >> /etc/profile.d/nvm.sh \
    && echo "[ -s \"$NVM_DIR/nvm.sh\" ] && \. \"$NVM_DIR/nvm.sh\" # This loads nvm" >> /etc/profile.d/nvm.sh \
    && echo "[ -s \"$NVM_DIR/bash_completion\" ] && \. \"$NVM_DIR/bash_completion\"  # This loads nvm bash_completion" >> /etc/profile.d/nvm.sh \
    && . /etc/profile.d/nvm.sh && nvm install $NODE_VERSION \
    && npm install -g npm \
    && npm install -g corepack \
    && corepack enable \
    && su -s /bin/bash -l -c "mkdir -p ${PNPM_HOME}/store && pnpm set store-dir ${PNPM_HOME}/store" node \
    && true

# and bind in .bashrc
RUN echo "" >> /root/.bashrc     && echo "# load custom prompt" >> /root/.bashrc \
    && echo "if [ -f ~/.bashrc_prompt ]; then" >> /root/.bashrc \
    && echo "    . ~/.bashrc_prompt" >> /root/.bashrc \
    && echo "fi" >> /root/.bashrc \
    && true

USER node

# and bind in .bashrc
RUN echo "" >> /home/node/.bashrc \
    && echo "# load custom prompt" >> /home/node/.bashrc \
    && echo "if [ -f ~/.bashrc_prompt ]; then" >> /home/node/.bashrc \
    && echo "    . ~/.bashrc_prompt" >> /home/node/.bashrc \
    && echo "fi" >> /home/node/.bashrc \
    && true

WORKDIR /ws

ARG NOW=not-set
LABEL org.opencontainers.image.authors="Emiliano Bruni <info@ebruni.it>"
LABEL org.opencontainers.image.created=$NOW
LABEL org.opencontainers.image.description="Docker image node with git and pnpm enabled."
LABEL org.opencontainers.image.documentation=https://github.com/EmilianoBruni/dockerhub-pnpm/blob/master/README.pod
LABEL org.opencontainers.image.licenses=Artistic-2.0
LABEL org.opencontainers.image.source=https://github.com/EmilianoBruni/dockerhub-pnpm/blob/master/ubuntu/Dockerfile
LABEL org.opencontainers.image.title=dockerhub-pnpm
LABEL org.opencontainers.image.url=https://github.com/EmilianoBruni/dockerhub-pnpm
LABEL org.opencontainers.image.version=24.4.3-ubuntu

ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]
CMD ["/bin/bash"]
