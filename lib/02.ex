defmodule AdventOfCode.Day2 do
  def solve_p1(filename) do
    levels =
      read_input(filename)
      |> Enum.count(fn level -> decreasing?(level) or increasing?(level) end)
  end

  def solve_p2(filename) do
    levels = read_input(filename)
  end

  defp increasing?([]), do: true
  defp increasing?([a, b]), do: 1 <= b - a and b - a <= 3
  defp increasing?([a, b | rest]) when 1 <= b - a and b - a <= 3, do: increasing?([b | rest])
  defp increasing?(_), do: false

  defp decreasing?([]), do: true
  defp decreasing?([a, b]), do: 1 <= a - b and a - b <= 3
  defp decreasing?([a, b | rest]) when 1 <= a - b and a - b <= 3, do: decreasing?([b | rest])
  defp decreasing?(_), do: false

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
