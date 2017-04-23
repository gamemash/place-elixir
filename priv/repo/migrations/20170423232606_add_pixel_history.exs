defmodule Place.Repo.Migrations.AddPixelHistory do
  use Ecto.Migration

  def change do
    create table(:pixel_history) do
      add :x, :integer
      add :y, :integer
      add :color, :integer

      timestamps()
    end
  end
end
