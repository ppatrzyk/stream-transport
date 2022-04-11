defmodule StreamTransport.Repo.Migrations.CreatePositions do
  use Ecto.Migration

  def change do
    create table(:positions) do
      add :k, :string
      add :name, :string
      add :type, :string
      add :x, :float
      add :y, :float
      add :timestamp, :utc_datetime
    end
  end
end
