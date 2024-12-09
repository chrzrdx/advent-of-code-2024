defmodule AdventOfCode.Day08 do
  def solve_p1(filename) do
    {nodes, rows, cols} = read_input(filename)

    nodes
    |> Enum.flat_map(fn {_, positions} ->
      positions
      |> make_pairs()
      |> Enum.flat_map(fn {a, b} -> pair_antinodes(a, b) end)
    end)
    |> MapSet.new()
    |> Enum.filter(&is_within_bounds?(&1, rows, cols))
    |> Enum.count()
  end

  def solve_p2(filename) do
    {nodes, rows, cols} = read_input(filename)

    nodes
    |> Enum.flat_map(fn {_, positions} ->
      positions
      |> make_pairs()
      |> Enum.flat_map(fn {{a, b}, {c, d}} ->
        {dx, dy} = {a - c, b - d}

        linear_antinodes({a, b}, {dx, dy}, rows, cols) ++
          linear_antinodes({c, d}, {-dx, -dy}, rows, cols)
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

  def pair_antinodes({a, b}, {c, d}) do
    {dx, dy} = {a - c, b - d}
    [{a + dx, b + dy}, {c - dx, d - dy}]
  end

  def is_within_bounds?({x, y}, rows, cols) do
    x >= 0 and x < rows and y >= 0 and y < cols
  end

  def linear_antinodes({a, b}, _, rows, cols)
      when a < 0 or a >= rows or b < 0 or b >= cols,
      do: []

  def linear_antinodes({a, b} = pos, {dx, dy} = diff, rows, cols) do
    new_pos = {a + dx, b + dy}
    [pos] ++ linear_antinodes(new_pos, diff, rows, cols)
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
