defmodule StreamTransport.Handler do
  use Broadway
  alias Broadway.Message
  alias StreamTransport.Position

  require Logger

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module: {BroadwayRabbitMQ.Producer,
          connection: "amqp://user_666:password_666@localhost:5672", # TODO change to rabbit once in docker
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
    # entry = %Position{}
    # |> Position.changeset(msg |> Map.fetch!(:data))
    Logger.info("batcher:")
    messages |> length |> inspect() |> Logger.info()
    messages |> hd |> inspect() |> Logger.info()
  end

  defp process_data(data, headers) do
    {_key, _type, raw_time} = headers |> Enum.filter(fn({key, _, _}) -> key == "timestamp" end) |> hd
    {:ok, timestamp, 0} = DateTime.from_iso8601(raw_time)
    data
    |> Poison.decode!
    |> Enum.map(&Map.put(&1, "timestamp", timestamp))
  end
end
