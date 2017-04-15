defmodule Place.Server do
  use GenServer

  alias Place.Pixel

  @width  10
  @height 10

  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_call(:board, _from, log) do
    board = Enum.reduce(log, empty_board(), fn pixel, board ->
      List.replace_at(board, pixel.x + pixel.y * @width, pixel.color)
    end)
    {:reply, {:ok, board}, log}
  end

  def handle_call(:state, _from, state) do
    {:reply, {:ok, state}, state}
  end

  def handle_cast(pixel = %Pixel{}, state) do
    state = [pixel | state]
    {:noreply, state}
  end

  defp empty_board() do
    for x <- 0..(@width - 1), y <- 0..(@height - 1), do: 0
  end
end
