import Config

config :stream_transport,
  ecto_repos: [StreamTransport.Repo]

config :stream_transport, StreamTransport.Repo,
  database: "positions.db"
