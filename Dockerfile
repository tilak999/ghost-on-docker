FROM node:lts-alpine

RUN wget https://registry.npmjs.org/ghost/-/ghost-5.49.0.tgz -O ghost.tgz
RUN mkdir -p /var/lib/ghost && tar -xvzf ghost.tgz -C /var/lib/ghost && rm ghost.tgz

WORKDIR /var/lib/ghost
RUN mv package current

RUN cd current && yarn install --production

COPY content ./content
COPY config.production.json config.production.json

ENV NODE_ENV production
CMD node current/index.js
EXPOSE 2368