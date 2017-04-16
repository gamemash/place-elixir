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

  def handle_in("update_pixel", %{"pixel" => pixel_params}, socket) do
    pixel = %Place.Pixel{
      color: pixel_params["color"],
      x: pixel_params["x"],
      y: pixel_params["y"]}

    case Server.set_pixel(@board, pixel) do
      :ok ->
        broadcast! socket, "pixel", %{pixel: pixel}
        {:reply, {:ok, %{pixel: pixel}}, socket}
      :error ->
        {:reply, {:error}, socket}
    end
  end

  def handle_in("clear_board", _params, socket) do
    Server.clear_board(@board)
    {:reply, {:ok, %{}}, socket}
  end

  def handle_in("clear_history", _params, socket) do
    Server.clear_history(@board)
    {:reply, {:ok, %{}}, socket}
  end
end
