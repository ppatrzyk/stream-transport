defmodule StreamTransport.Repo do
  use Ecto.Repo,
    otp_app: :stream_transport,
    adapter: Ecto.Adapters.SQLite3
end
