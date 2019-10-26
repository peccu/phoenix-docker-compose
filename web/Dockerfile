FROM beardedeagle/alpine-phoenix-builder:1.7.3 as builder
ARG appname
ENV appdir /opt/${appname}
ENV appver 0.0.1
WORKDIR ${appdir}
COPY ../${appname} ${appdir}
RUN mix deps.get --only prod \
  && MIX_ENV=prod mix compile \
  && cd assets \
  && npm install \
  && node node_modules/brunch/bin/brunch build --production \
  && cd ${appdir} \
  && MIX_ENV=prod mix phx.digest \
  && MIX_ENV=prod mix release --env=prod

FROM alpine:3.8
EXPOSE 4000
ARG appname
ENV appdir /opt/${appname}
ENV appver 0.0.1
WORKDIR /opt/
COPY --from=builder ${appdir}/_build/prod/rel/${appname}/releases/${appver}/${appname}.tar.gz .
RUN apk add --no-cache bash libressl \
  && tar -xzvf ${appname}.tar.gz \
  && rm -rf ${appname}.tar.gz \
  && rm -rf /root/.cache \
  && rm -rf /var/cache/apk/*
CMD ["bin/${appname}", "foreground"]

# To start the release you have built, you can use one of the following tasks:

#     # start a shell, like 'iex -S mix'
#     > _build/prod/rel/my_app/bin/my_app console

#     # start in the foreground, like 'mix run --no-halt'
#     > _build/prod/rel/my_app/bin/my_app foreground

#     # start in the background, must be stopped with the 'stop' command
#     > _build/prod/rel/my_app/bin/my_app start

# If you started a release elsewhere, and wish to connect to it:

#     # connects a local shell to the running node
#     > _build/prod/rel/my_app/bin/my_app remote_console

#     # connects directly to the running node's console
#     > _build/prod/rel/my_app/bin/my_app attach

# For a complete listing of commands and their use:

#     > _build/prod/rel/my_app/bin/my_app help
