defmodule AdventOfCode.Day07 do
  def solve_p1(filename) do
    read_input(filename)
    |> Enum.filter(fn {target, [first | rest]} -> solvable?(target, first, rest, false) end)
    |> Enum.map(fn {target, _} -> target end)
    |> Enum.sum()
  end

  def solve_p2(filename) do
    read_input(filename)
    |> Enum.filter(fn {target, [first | rest]} -> solvable?(target, first, rest, true) end)
    |> Enum.map(fn {target, _} -> target end)
    |> Enum.sum()
  end

  def solvable?(target, current, [] = _nums, _concat?), do: target == current
  def solvable?(target, current, _, _) when current > target, do: false

  def solvable?(target, current, [top | rest], concat?) do
    solvable?(target, current * top, rest, concat?) or
      solvable?(target, current + top, rest, concat?) or
      if concat?, do: solvable?(target, concat(current, top), rest, concat?), else: false
  end

  def concat(a, b), do: String.to_integer("#{a}#{b}")

  defp read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [first, rest] = String.split(line, ":", trim: true)
      target = String.to_integer(first)
      nums = rest |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
      {target, nums}
    end)
  end
end
