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

  def set_pixel(pid, pixel = %Pixel{}) do
    GenServer.cast(pid, pixel)
  end

  def get_board(pid) do
    GenServer.call(pid, :board)
  end

  def get_history(pid) do
    GenServer.call(pid, :state)
  end

  def clear_board(pid) do
    GenServer.cast(pid, :clear_board)
  end

  def clear_history(pid) do
    GenServer.cast(pid, :clear_history)
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

  def handle_cast(:clear_history, _) do
    {:noreply, []}
  end

  def handle_cast(:clear_board, state) do
    clearPixels = for x <- 0..(@width - 1), y <- 0..(@height - 1), do: %Pixel{x: x, y: y, color: 0}
    {:noreply, clearPixels ++ state}
  end

  defp empty_board() do
    for _ <- 0..(@width - 1), _ <- 0..(@height - 1), do: 0
  end
end
