defmodule StreamTransport.Position do
  use Ecto.Schema
  import Ecto.Changeset

  schema "positions" do
    field :k, :string
    field :name, :string
    field :type, :string
    field :x, :float
    field :y, :float
    field :timestamp, :utc_datetime
  end

  @doc false
  def changeset(positions, attrs) do
    positions |> cast(attrs, [:k, :name, :type, :x, :y, :timestamp])
  end
end
