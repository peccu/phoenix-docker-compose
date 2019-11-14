FROM elixir:1.9.4

ENV NODE_VERSION 13.x
ENV PHOENIX_VERSION 1.4.11

RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} | bash \
  && apt-get install -y nodejs inotify-tools

RUN npm install npm -g

RUN mix local.hex --force \
        && mix archive.install --force hex phx_new ${PHOENIX_VERSION} \
        && mix local.rebar --force

ENV TZ=Asia/Tokyo
RUN rm /etc/localtime \
        && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
        && echo $TZ > /etc/timezone

WORKDIR /app
ENV HOME=/app
