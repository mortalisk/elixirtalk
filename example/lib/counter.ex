defmodule Counter do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def init(count) do
    {:ok, count}
  end

  def handle_cast(:count, count) do
    {:noreply, count + 1}
  end

  def handle_cast(:reset, _count) do
    {:noreply, 0}
  end

  def handle_call(:get, _from, count) do
    {:reply, count, count}
  end

  def handle_call({:notify_on_count, target}, from, count) do
    handle_info({:reply_notify, from, target}, count)
  end

  def handle_info({:reply_notify, from, target}, count) do
    if count >= target do
      GenServer.reply(from, count)
    else
      Process.send_after(self(), {:reply_notify, from, target}, 500)
    end

    {:noreply, count}
  end

  def wait_until(target) do
    GenServer.call(Counter, {:notify_on_count, target}, 30_000)
  end

  def reset do
    GenServer.cast(Counter, :reset)
  end

  def get do
    GenServer.call(Counter, :get)
  end
end
