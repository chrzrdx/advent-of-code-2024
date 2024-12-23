defmodule AdventOfCode.Day01.Locations do
  def distance(left, right) do
    sorted_left = Enum.sort(left)
    sorted_right = Enum.sort(right)

    Enum.zip(sorted_left, sorted_right)
    |> Enum.sum_by(fn {a, b} -> abs(a - b) end)
  end

  def similarity(left, right) do
    freq = Enum.frequencies(right)

    left
    |> Enum.sum_by(fn a -> a * Map.get(freq, a, 0) end)
  end
end
