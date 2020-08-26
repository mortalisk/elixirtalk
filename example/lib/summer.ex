defmodule Summer do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def init(sum) do
    {:ok, sum}
  end

  def handle_cast({:add, x}, sum) do
    GenServer.cast(Counter, :count)
    {:noreply, sum + x}
  end

  def handle_call(:get, _from, sum) do
    {:reply, sum, sum}
  end

  def add(x) do
    GenServer.cast(Summer, {:add, x})
  end

  def get do
    GenServer.call(Summer, :get)
  end
end
