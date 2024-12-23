defmodule AdventOfCode.Day01.Part1 do
  alias AdventOfCode.Day01.Parser

  def solve(filename) do
    {left, right} = Parser.parse(filename)

    distance(left, right)
  end

  def distance(left, right) do
    sorted_left = Enum.sort(left)
    sorted_right = Enum.sort(right)

    Enum.zip(sorted_left, sorted_right)
    |> Enum.sum_by(fn {a, b} -> abs(a - b) end)
  end
end
