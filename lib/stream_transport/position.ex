defmodule StreamTransport.Position do
  use Ecto.Schema
  import Ecto.Changeset

  schema "positions" do
    field :k, :integer
    field :name, :string
    field :type, :string
    field :x, :float
    field :y, :float
    field :timestamp, :utc_datetime_usec
  end

  @doc false
  def changeset(position, attrs) do
    position |> cast(attrs, [:k, :name, :type, :x, :y, :timestamp])
  end
end
