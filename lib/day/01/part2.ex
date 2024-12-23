defmodule AdventOfCode.Day01.Part2 do
  alias AdventOfCode.Day01.Parser

  def solve(filename) do
    {left, right} = Parser.parse(filename)

    similarity(left, right)
  end

  def similarity(left, right) do
    freq = Enum.frequencies(right)

    left
    |> Enum.sum_by(fn a -> a * Map.get(freq, a, 0) end)
  end
end
