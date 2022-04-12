defmodule StreamTransport.Handler do
  use Broadway
  alias Broadway.Message
  alias StreamTransport.Position
  alias StreamTransport.Repo

  require Logger

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module: {BroadwayRabbitMQ.Producer,
          connection: [
            username: "user_666",
            password: "password_666",
            host: "rabbit",
          ],
          queue: "positions",
          metadata: [:headers, ],
        },
        concurrency: 1
      ],
      processors: [
        positions: [concurrency: 10]
      ],
      batchers: [
        sqlite: [concurrency: 5, batch_size: 10, batch_timeout: 1000]
      ]
    )
  end

  def handle_message(:positions, message, _context) do
    %{metadata: %{headers: headers}} = message
    message
    |> Message.update_data(&process_data(&1, headers))
    |> Message.put_batcher(:sqlite)
  end

  def handle_batch(:sqlite, messages, _batch_info, _context) do
    entries = messages
    |> Enum.map(&Map.fetch!(&1, :data))
    |> Enum.concat
    Repo.insert_all(Position, entries)
    messages
  end

  defp process_data(data, headers) do
    {_key, _type, raw_time} = headers |> Enum.filter(fn({key, _, _}) -> key == "timestamp" end) |> hd
    {:ok, timestamp, 0} = DateTime.from_iso8601(raw_time)
    data
    |> Poison.decode!
    |> Enum.map(&Map.put(&1, "timestamp", timestamp))
    |> Enum.map(&Map.new(&1, fn {k, v} -> {String.to_atom(k), v} end))
  end
end
