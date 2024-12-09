defmodule AdventOfCode.Day08 do
  def solve_p1(filename) do
    {nodes, rows, cols} = read_input(filename)

    nodes
    |> Enum.flat_map(fn {_, positions} ->
      positions
      |> make_pairs()
      |> Enum.flat_map(fn {a, b} -> place_antinodes(a, b) end)
    end)
    |> MapSet.new()
    |> Enum.count(fn {x, y} -> x >= 0 and x < rows and y >= 0 and y < cols end)
  end

  def solve_p2(filename) do
    {nodes, rows, cols} = read_input(filename)

    nodes
    |> Enum.flat_map(fn {_, positions} ->
      positions
      |> make_pairs()
      |> Enum.flat_map(fn {{a, b}, {c, d}} ->
        {dx, dy} = {a - c, b - d}

        place_antinodes_along_line({a, b}, {dx, dy}, rows, cols) ++
          place_antinodes_along_line({c, d}, {-dx, -dy}, rows, cols)
      end)
    end)
    |> MapSet.new()
    |> Enum.count()
  end

  def make_pairs(positions) do
    for a <- positions, b <- positions, a < b do
      {a, b}
    end
  end

  def place_antinodes({a, b}, {c, d}) do
    {dx, dy} = {a - c, b - d}
    [{a + dx, b + dy}, {c - dx, d - dy}]
  end

  def place_antinodes_along_line({a, b}, _, rows, cols)
      when a < 0 or a >= cols or b < 0 or b >= rows,
      do: []

  def place_antinodes_along_line({a, b}, {dx, dy}, rows, cols) do
    new_antinode = {a + dx, b + dy}
    [{a, b} | place_antinodes_along_line(new_antinode, {dx, dy}, rows, cols)]
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
      |> Enum.flat_map(fn {line, x} ->
        line
        |> Enum.with_index()
        |> Enum.filter(fn {antenna, _} -> antenna != "." end)
        |> Enum.map(fn {antenna, y} -> {antenna, {x, y}} end)
      end)
      |> Enum.group_by(fn {k, _} -> k end, fn {_, v} -> v end)
      |> Enum.filter(fn {_, v} -> length(v) > 1 end)

    {nodes, rows, cols}
  end
end
