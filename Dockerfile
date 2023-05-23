FROM node:lts-alpine

RUN wget https://registry.npmjs.org/ghost/-/ghost-5.49.0.tgz -O ghost.tgz

RUN mkdir -p /var/lib/ghost/content && \
    tar -xvzf ghost.tgz -C /var/lib/ghost && \
    rm ghost.tgz

WORKDIR /var/lib/ghost
RUN mv package current

RUN cd current && yarn install --production
VOLUME ["/var/lib/ghost/content"]

COPY content ./content.orig
COPY config.production.json config.production.json

ENV NODE_ENV production
CMD cp -rn content.orig/* /var/lib/ghost/content && node current/index.js

EXPOSE 2368