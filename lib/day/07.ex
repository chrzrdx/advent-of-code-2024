defmodule AdventOfCode.Day07 do
  alias AdventOfCode.Day07.Equation

  def solve_p1(filename) do
    filename
    |> read_input()
    |> Task.async_stream(
      fn eq ->
        if Equation.solvable?(eq, [&+/2, &*/2]), do: eq.target, else: 0
      end,
      ordered: false
    )
    |> Enum.sum_by(fn {:ok, value} -> value end)
  end

  def solve_p2(filename) do
    filename
    |> read_input()
    |> Task.async_stream(
      fn eq ->
        if Equation.solvable?(eq, [&+/2, &*/2, &Equation.concat/2]), do: eq.target, else: 0
      end,
      ordered: false
    )
    |> Enum.sum_by(fn {:ok, value} -> value end)
  end

  defp read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [first, rest] = String.split(line, ":", trim: true)
      target = String.to_integer(first)
      nums = rest |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
      Equation.new(target, nums)
    end)
  end
end
