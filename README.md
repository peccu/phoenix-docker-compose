# phoenix docker compose

## instruction for deb

- ./dev-up.sh
- ./dev-bash.sh
  - from https://hexdocs.pm/phoenix/up_and_running.html
  - mix phx.new my_app
    - this name should be set to docker-compose.yml and docker-compose.dev.yml
  - cd my_app
  - modify config/dev.exs and update hostname of DB to `db` (container name)
  - mix ecto.create
  - mix phx.server
    - this can be executed by ./dev-serve.sh
- open http://localhost:4100/

## instruction for prod
Please follow the official documents.
[Deploying with Releases — Phoenix v1.4.10](https://hexdocs.pm/phoenix/releases.html)

- ./dev-bash.sh
  - cd my_app
  - mix phx.gen.secret
    - set secret key into docker-compose.yml
  - mix release.init?
- docker-compose build web
