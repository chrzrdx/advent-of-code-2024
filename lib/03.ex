defmodule AdventOfCode.Day3 do
  def solve_p1(filename) do
    read_input(filename) |> Enum.count()
    1
  end

  def solve_p2(filename) do
    read_input(filename) |> Enum.count()
    1
  end

  defp read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer(&1))
    end)
  end
end
