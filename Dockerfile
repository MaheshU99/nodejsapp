FROM node:12-alpine3.9 AS build
# FROM node:12.22.12-slim AS build

# FROM node:14-slim AS build

WORKDIR /usr/src/app

# RUN node -v && npm -v

COPY . .

# RUN npm install 

# RUN npm run build

# FROM mhart/alpine-node:0.10.48 AS runtime

FROM node:10.15.2-alpine AS runtime

# FROM alpine:3.14 AS runtime

# FROM node:12-alpine3.9 AS runtime

WORKDIR /app

# RUN apk add --no-cache node

# COPY .  .

COPY --from=build /usr/src/app/*.json /app/

COPY --from=build /usr/src/app/index.js /app/index.js

RUN npm install --production=true

# COPY --from=build /usr/src/app/node_modules/ /app/node_modules
# COPY --from=build /usr/src/app/bin /app/bin
# COPY --from=build /usr/src/app/.env* /app/
# COPY --from=build /usr/src/app/dist /app/dist

EXPOSE 3000

CMD [ "node", "/app/index.js" ]

# ENTRYPOINT ["tail", "-f", "/dev/null"]