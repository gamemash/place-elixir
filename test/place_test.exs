defmodule PlaceTest do
  use ExUnit.Case
  doctest Place

  test "board" do
    {:ok, pid} = Place.Server.start_link

    Place.Server.set_pixel(pid, %Place.Pixel{color: 10})
    {:ok, board} = GenServer.call(pid, :board)
    assert Enum.at(board, 0) == 10
  end

  test "clear history" do
    {:ok, pid} = Place.Server.start_link

    Place.Server.set_pixel(pid, %Place.Pixel{color: 10})
    Place.Server.clear_history(pid)

    {:ok, board} = Place.Server.get_board(pid)
    assert Enum.at(board, 0) == 0
  end

  test "clear board" do
    {:ok, pid} = Place.Server.start_link

    Place.Server.set_pixel(pid, %Place.Pixel{color: 10})
    Place.Server.clear_board(pid)
    {:ok, history} = Place.Server.get_history(pid)
    assert Enum.at(history, 100).color == 10
  end
end
