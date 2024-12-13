defmodule AdventOfCode.Day13 do
  def solve_p1(filename) do
    read_input(filename)
    |> Enum.map(&cost/1)
    |> Enum.sum()
  end

  def solve_p2(filename) do
    read_input(filename)
    |> Enum.map(fn [a, b, c, d, e, f] ->
      [a, b, c, d, 10_000_000_000_000 + e, 10_000_000_000_000 + f]
    end)
    |> Enum.map(&cost/1)
    |> Enum.sum()
  end

  def cost([a, b, c, d, e, f]) do
    try do
      x = div(d * e - c * f, d * a - c * b)
      y = div(b * e - a * f, b * c - a * d)

      if a * x + c * y == e and b * x + d * y == f, do: 3 * x + y, else: 0
    rescue
      _ -> 0
    end
  end

  defp read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn group ->
      [[_, a, b]] = Regex.scan(~r/Button A: X\+(\d+), Y\+(\d+)/, group)
      [[_, c, d]] = Regex.scan(~r/Button B: X\+(\d+), Y\+(\d+)/, group)
      [[_, e, f]] = Regex.scan(~r/Prize: X\=(\d+), Y\=(\d+)/, group)

      [a, b, c, d, e, f]
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
