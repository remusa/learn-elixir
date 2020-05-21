defmodule Math do
  def add(a, b) do
    (a + b)
    |> IO.inspect()
  end

  def double(n) do
    spawn(Math, :add, [n, n])
    |> send(self())

    receive do
      doubled ->
        doubled
    end
  end
end
