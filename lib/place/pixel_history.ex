defmodule Place.PixelHistory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pixel_history" do
    field :x, :integer
    field :y, :integer
    field :color, :integer

    timestamps()
  end

  @required_fields ~w(x y color)a

  def changeset(pixel, params \\ %{}) do
    pixel
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end