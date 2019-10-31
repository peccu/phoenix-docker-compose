# https://hexdocs.pm/phoenix/releases.html#containers
FROM elixir:1.9.2-alpine as build

ARG APP_NAME
ARG DATABASE_URL
ARG SECRET_KEY_BASE

# install build dependencies
RUN apk add --update git build-base nodejs yarn python

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY ${APP_NAME}/mix.exs ${APP_NAME}/mix.lock ./
COPY ${APP_NAME}/config config
RUN mix deps.get
RUN mix deps.compile

# build assets
COPY ${APP_NAME}/assets assets
RUN cd assets && yarn install && yarn run deploy
RUN mix phx.digest

# build project
COPY ${APP_NAME}/priv priv
COPY ${APP_NAME}/lib lib
RUN mix compile

# build release
COPY ${APP_NAME}/rel rel
RUN mix release

# prepare release image
FROM alpine:3.9 AS app
ARG APP_NAME
ARG DATABASE_URL
ARG SECRET_KEY_BASE

RUN apk add --update bash openssl

RUN mkdir /app
WORKDIR /app

COPY --from=build /app/_build/prod/rel/${APP_NAME} ./
RUN chown -R nobody: /app
USER nobody

ENV HOME=/app
