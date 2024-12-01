defmodule AdventOfCode.Day1 do
  def solve_p1(filename) do
    input = read_input(filename)

    left = input |> Enum.map(fn [a, _] -> a end) |> Enum.sort()
    right = input |> Enum.map(fn [_, b] -> b end) |> Enum.sort()

    # distance =
    Enum.zip(left, right)
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def solve_p2(filename) do
    input = read_input(filename)

    freq = Enum.frequencies_by(input, fn [_, b] -> b end)

    input
    |> Enum.map(fn [a, _] -> a * Map.get(freq, a, 0) end)
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
