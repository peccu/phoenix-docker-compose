FROM elixir:1.9.2

ENV NODE_VERSION 10.x

RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} | bash \
  && apt-get install -y nodejs inotify-tools

RUN npm install npm -g

RUN mix local.hex --force \
        && mix archive.install --force hex phx_new 1.4.10 \
        && mix local.rebar --force

WORKDIR /app
ENV HOME=/app
