defmodule AdventOfCode.Day07 do
  def solve_p1(filename) do
    read_input(filename)
    |> Enum.filter(&solvable?/1)
    |> Enum.map(fn {target, _} -> target end)
    |> Enum.sum()
  end

  def solve_p2(filename) do
    read_input(filename)
    1
  end

  def solvable?({target, nums}) do
    solvable?(target, 0, nums)
  end

  def solvable?(target, current, []), do: target == current
  def solvable?(target, current, _nums) when current > target, do: false

  def solvable?(target, current, [top | rest]) do
    solvable?(target, current * top, rest) or
      solvable?(target, current + top, rest)
  end

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
