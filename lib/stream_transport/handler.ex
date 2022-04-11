defmodule StreamTransport.Handler do
  use Broadway
  alias Broadway.Message

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
    message |> inspect |> Logger.info

    message
    |> Message.update_data(&process_data/1)
    |> Message.put_batcher(:sqlite)
  end

  def handle_batch(:sqlite, messages, _batch_info, _context) do
    # TODO
  end

  defp process_data(data) do
    # TODO
    data
  end
end
