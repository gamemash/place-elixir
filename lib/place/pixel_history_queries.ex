defmodule Place.PixelHistoryQueries do
  import Ecto.Query

  alias Place.{Repo, PixelHistory}

  def get_all do
    Repo.all(from PixelHistory, order_by: [asc: :id])
  end

  def create(pixel) do
    Repo.insert(pixel)
  end
end