FROM node:16.17.0-bullseye-slim

RUN apt update && apt install -y wget
RUN wget https://registry.npmjs.org/ghost/-/ghost-5.49.0.tgz -O ghost.tgz

RUN mkdir -p /var/lib/ghost/content && \
    tar -xzf ghost.tgz -C /var/lib/ghost && \
    rm ghost.tgz

WORKDIR /var/lib/ghost
RUN mv package current

RUN cd current && rm yarn.lock && yarn install --ignore-engines --ignore-platform --network-timeout 1000000
VOLUME ["/var/lib/ghost/content"]

COPY content ./content.orig
COPY config.production.json config.production.json

ENV NODE_ENV production
CMD cp -rn content.orig/* /var/lib/ghost/content && node current/index.js

EXPOSE 2368