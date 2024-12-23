defmodule AdventOfCode.Day01.Locations do
  def distance(left, right) do
    sorted_left = Enum.sort(left)
    sorted_right = Enum.sort(right)

    sorted_left
    |> Stream.zip(sorted_right)
    |> Enum.sum_by(fn {a, b} -> abs(a - b) end)
  end

  def similarity(left, right) do
    freq = Enum.frequencies(right)

    Enum.sum_by(left, fn a -> a * Map.get(freq, a, 0) end)
  end
end
