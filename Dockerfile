ARG NODE_VERSION=current

FROM ghcr.io/alimd/tdlib:1 AS tdlib
FROM node:${NODE_VERSION}-alpine

WORKDIR /app

ENV TDLIB_PATH=/usr/local/lib
COPY --from=tdlib ${TDLIB_PATH}/libtdjson.* ${TDLIB_PATH}/

COPY package.json yarn.lock ./

ARG APK_RUN_DEPS
ARG APK_BUILD_DEPS
RUN set -ex; \
    if [ ! -z "$APK_BUILD_DEPS" ]; then \
      apk add --no-cache --virtual .build-deps ${APK_BUILD_DEPS}; \
    fi; \
    if [ ! -z "$APK_RUN_DEPS" ]; then \
      apk add --no-cache ${APK_RUN_DEPS}; \
    fi; \
    yarn install --no-lockfile  --non-interactive --no-progress --network-timeout 5000; \
    yarn cache clean; \
    if [ ! -z "$APK_BUILD_DEPS" ]; then \
      apk del .build-deps; \
    fi;

COPY . .

RUN yarn build

EXPOSE 80
CMD yarn start
