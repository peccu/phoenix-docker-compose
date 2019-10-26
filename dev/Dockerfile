FROM elixir:latest

ENV NODE_VERSION 8.x
ENV NPM_VERSION 6.1.0

RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} | bash \
  && apt-get install -y nodejs inotify-tools

RUN npm install npm@${NPM_VERSION} -g

RUN mix local.hex --force \
        && mix archive.install --force hex phx_new 1.4.10 \
        && mix local.rebar --force

WORKDIR /app
