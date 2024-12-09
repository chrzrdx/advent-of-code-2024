defmodule AdventOfCode.Day08 do
  def solve_p1(filename) do
    {nodes, rows, cols} = read_input(filename)

    nodes
    |> Enum.flat_map(fn {_, positions} -> gen_antinodes(positions) end)
    |> MapSet.new()
    |> Enum.count(fn {x, y} -> x >= 0 and x < cols and y >= 0 and y < rows end)
  end

  def solve_p2(filename) do
    read_input(filename)
    1
  end

  def gen_antinodes(positions) do
    positions
    |> make_pairs()
    |> Enum.flat_map(fn {a, b} -> place_antinodes(a, b) end)
  end

  def make_pairs(positions) do
    for a <- positions, b <- positions, a < b do
      {a, b}
    end
  end

  def place_antinodes({a, b}, {c, d}) do
    xdiff = a - c
    ydiff = b - d

    [{a + xdiff, b + ydiff}, {c - xdiff, d - ydiff}]
  end

  defp read_input(filename) do
    chars =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "", trim: true))

    rows = length(chars)
    cols = length(Enum.at(chars, 0))

    nodes =
      chars
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, y} ->
        line
        |> Enum.with_index()
        |> Enum.filter(fn {antenna, _} -> antenna != "." end)
        |> Enum.map(fn {antenna, x} -> {antenna, {x, y}} end)
      end)
      |> Enum.group_by(fn {k, _} -> k end, fn {_, v} -> v end)
      |> Enum.filter(fn {_, v} -> length(v) > 1 end)

    {nodes, rows, cols}
  end
end
