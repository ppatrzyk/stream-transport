FROM elixir:1.13.3-slim

COPY . .

RUN apt-get update \
    && apt-get install -y \
    gcc \
    build-essential \
    --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix deps.get \
    && MIX_ENV=prod mix release

CMD _build/prod/rel/my_release/bin/my_release start
