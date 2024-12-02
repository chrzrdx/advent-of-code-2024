defmodule AdventOfCode.Day2 do
  def solve_p1(filename) do
    reports = read_input(filename)

    Enum.count(reports, fn report ->
      safe?(report, true) or safe?(Enum.reverse(report), true)
    end)
  end

  def solve_p2(filename) do
    reports = read_input(filename)

    Enum.count(reports, fn report ->
      safe?(report, false) or safe?(Enum.reverse(report), false)
    end)
  end

  defp safe?([a, b], _), do: 1 <= b - a and b - a <= 3

  defp safe?([a, b, c | rest], damped)
       when 1 <= b - a and b - a <= 3 and 1 <= c - b and c - b <= 3,
       do: safe?([b, c | rest], damped)

  defp safe?([a, b, c | rest], false),
    do: safe?([b, c | rest], true) or safe?([a, c | rest], true) or safe?([a, b | rest], true)

  defp safe?(_, _), do: false

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
