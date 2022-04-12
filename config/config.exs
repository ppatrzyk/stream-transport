import Config

config :stream_transport,
  ecto_repos: [StreamTransport.Repo]

config :stream_transport, StreamTransport.Repo,
  database: "data/positions.db"

config :logger, :console,
  level: :info,
  utc_log: true,
  metadata: :all
