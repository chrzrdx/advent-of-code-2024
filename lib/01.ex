defmodule AdventOfCode.Day1 do
  def solve(filename) do
    input = read_input(filename)

    left = input |> Enum.map(fn [a, _] -> a end) |> Enum.sort()
    right = input |> Enum.map(fn [_, b] -> b end) |> Enum.sort()

    IO.inspect(left)
    IO.inspect(right)

    # distance =
    Enum.zip(left, right)
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  defp read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.split(line, " ")
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.map(&String.to_integer(&1))
    end)
    |> Enum.filter(&(length(&1) == 2))
  end
end
