defmodule Divider do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def init(count) do
    {:ok, count}
  end

  def handle_call({:div, x, y}, _from, count) do
    answer = div(x, y)
    {:reply, answer, count + 1}
  end

  def divide(x, y) do
    GenServer.call(Divider, {:div, x, y})
  end
end
