defmodule Place.PlaceChannel do
  use Phoenix.Channel

  alias Place.Server

  @board :main

  def join("place:board", _message, socket) do
    {:ok, socket}
  end

  def handle_in("get_board", _params, socket) do
    {:ok, board} = Server.get_board(@board)
    {:reply, {:ok, %{board: board}}, socket}
  end
end
