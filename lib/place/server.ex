defmodule Place.Server do
  use GenServer

  alias Place.Pixel

  @width  10
  @height 10

  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def init(:ok) do
    state = for x <- 0..@width, y <- 0..@height, do: %Pixel{x: x, y: y, color: 0}
    {:ok, state}
  end

  def handle_call(:state, _from, state) do
    {:reply, {:ok, state}, state}
  end

  def handle_cast({:pixel, pixel = %Pixel{}}, state) do
    state = [pixel | state]
    {:noreply, state}
  end
end
