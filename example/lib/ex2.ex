defmodule Ex2 do
  def start(:normal, []) do
    children = [
      %{
        id: Divider,
        start: {Divider, :start_link, []}
      },
      %{
        id: Summer,
        start: {Summer, :start_link, []}
      },
      %{
        id: Counter,
        start: {Counter, :start_link, []}
      }
    ]

    {:ok, _pid} = Supervisor.start_link(children, strategy: :one_for_one, max_restarts: 100)
  end

  def run_clients do
    Counter.reset()
    n = 100
    run_many_clients(n)
    IO.puts("waiting for #{n / 2} to complete")
    Counter.wait_until(n / 2)
    n = Counter.get()
    sum = Summer.get()
    IO.puts("counter was now #{n}, sum was #{sum}")
  end

  def client do
    :timer.sleep(:rand.uniform(3000))
    a = :rand.uniform(20) - 1
    b = :rand.uniform(20) - 1
    result = Divider.divide(a, b)
    Summer.add(result)
  end

  def run_many_clients(n) do
    0..n
    |> Enum.map(fn _n ->
      Task.start(&client/0)
    end)

    # |> Enum.map(&Task.await/1)
    # |> Enum.each(fn t -> IO.puts(t) end)

    IO.puts("done with clients")
  end
end
