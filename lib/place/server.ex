defmodule Place.Server do
  use GenServer

  alias Place.Pixel

  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_call(:state, _from, state) do
    {:reply, {:ok, state}, state}
  end

  def handle_cast({:pixel, pixel = %Pixel{}}, state) do
    state = [pixel | state]
    {:noreply, state}
  end
end
