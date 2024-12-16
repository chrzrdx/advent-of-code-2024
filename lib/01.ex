defmodule AdventOfCode.Day01 do
  def solve_p1(filename) do
    {left, right} = read_input(filename)

    # distance =
    Enum.zip(Enum.sort(left), Enum.sort(right))
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def solve_p2(filename) do
    {left, right} = read_input(filename)
    freq = Enum.frequencies(right)

    # similarity =
    left
    |> Enum.map(fn a -> a * Map.get(freq, a, 0) end)
    |> Enum.sum()
  end

  def read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> (fn [a, b] ->
            {String.to_integer(a), String.to_integer(b)}
          end).()
    end)
    |> Enum.unzip()
  end
end
