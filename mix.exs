defmodule StreamTransport.MixProject do
  use Mix.Project

  def project do
    [
      app: :stream_transport,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {StreamTransport.Application, []}
    ]
  end

  defp deps do
    [
      {:broadway, "~> 1.0.3"},
      {:broadway_rabbitmq, "~> 0.7.0"},
      {:ecto, "~> 3.7.2"},
      {:ecto_sqlite3, "~> 0.7.4"},
    ]
  end
end
