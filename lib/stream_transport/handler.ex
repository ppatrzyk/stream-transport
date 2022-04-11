defmodule Handler do
  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module: {BroadwayRabbitMQ.Producer,
          queue: "my_queue",
        },
        concurrency: 1
      ],
      processors: [
        positions: [concurrency: 50]
      ],
      batchers: [
        sqlite: [concurrency: 5, batch_size: 10, batch_timeout: 1000]
      ]
    )
  end

  def handle_message(:positions, message, _context) do
    message
    |> Message.update_data(&process_data/1)
    |> Message.put_batcher(:s3)
  end

  def handle_batch(:sqlite, messages, _batch_info, _context) do
    # TODO
  end

  defp process_data(data) do
    # TODO
  end
end
