defmodule Example do
  def start do
    pr = spawn(&printer/0)
    sum = spawn(&summer/0)
    mul = spawn(fn -> multiplier(sum, pr) end)

    1..1_000_000
    |> Enum.each(&send(mul, &1))

    send(mul, :done)
  end

  def summer(sum \\ 0) do
    receive do
      n when is_integer(n) ->
        summer(sum + n)

      {:get, result_to} ->
        send(result_to, sum)
        summer(sum)
    end
  end

  def multiplier(summer, pr) do
    receive do
      x when is_integer(x) ->
        answer = x * x

        if rem(x, 1000) == 0 do
          send(pr, "#{x} * #{x} = #{answer}")
        end

        send(summer, answer)
        multiplier(summer, pr)

      :done ->
        send(summer, {:get, self})

        receive do
          a -> send(pr, "Sum is #{a}")
        end
    end
  end

  def printer do
    receive do
      a -> IO.puts(a)
    end

    printer()
  end

  def start2 do
    1..1_000_000
    |> Enum.map(&:math.pow(&1, 2))
    |> Enum.sum()
  end

  def start3 do
    1..1_000_000
    |> Task.async_stream(&:math.pow(&1, 2))
    |> Enum.map(fn {:ok, n} -> n end)
    |> Enum.sum()
  end
end
