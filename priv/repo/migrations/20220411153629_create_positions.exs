defmodule StreamTransport.Repo.Migrations.CreatePositions do
  use Ecto.Migration

  def change do
    create table(:positions) do
      add :k, :integer
      add :name, :string
      add :type, :string
      add :x, :float
      add :y, :float
      add :timestamp, :utc_datetime_usec
    end
  end
end
