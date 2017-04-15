defmodule PlaceTest do
  use ExUnit.Case
  doctest Place

  test "board" do
    {:ok, pid} = Place.Server.start_link
    GenServer.cast(pid, %Place.Pixel{color: 10})
    {:ok, board} = GenServer.call(pid, :board)
    assert Enum.at(board, 0) == 10
  end
end
