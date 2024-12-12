defmodule AdventOfCode.Day10 do
  def solve_p1(filename) do
    heights = read_input(filename)

    MapSet.new()
    |> trailhead(0, heights)
    |> trailhead(1, heights)
    |> trailhead(2, heights)
    |> trailhead(3, heights)
    |> trailhead(4, heights)
    |> trailhead(5, heights)
    |> trailhead(6, heights)
    |> trailhead(7, heights)
    |> trailhead(8, heights)
    |> trailhead(9, heights)
    |> Enum.map(fn {_, trails} -> MapSet.size(trails) end)
    |> Enum.sum()
  end

  def solve_p2(filename) do
    heights = read_input(filename)

    Map.new()
    |> rating(0, heights)
    |> rating(1, heights)
    |> rating(2, heights)
    |> rating(3, heights)
    |> rating(4, heights)
    |> rating(5, heights)
    |> rating(6, heights)
    |> rating(7, heights)
    |> rating(8, heights)
    |> rating(9, heights)
    |> Map.values()
    |> Enum.sum()
  end

  def adjacent({x, y}) do
    [{x, y - 1}, {x, y + 1}, {x - 1, y}, {x + 1, y}]
  end

  def trailhead(_trails, 0, heights) do
    heights[0]
    |> Map.new(fn pos -> {pos, MapSet.new([pos])} end)
  end

  def trailhead(trails, n, heights) do
    heights[n]
    |> Enum.map(fn pos ->
      trails_at_pos =
        adjacent(pos)
        |> Enum.reduce(MapSet.new(), fn pos, acc ->
          adjacent_trails = Map.get(trails, pos, MapSet.new())
          MapSet.union(acc, adjacent_trails)
        end)

      {pos, trails_at_pos}
    end)
    |> Enum.into(%{})
  end

  def rating(_map, 0, heights) do
    heights[0]
    |> Map.new(fn pos -> {pos, 1} end)
  end

  def rating(map, n, heights) do
    heights[n]
    |> Enum.map(fn pos ->
      rating_sum =
        adjacent(pos)
        |> Enum.map(fn adj_pos -> Map.get(map, adj_pos, 0) end)
        |> Enum.sum()

      {pos, rating_sum}
    end)
    |> Enum.into(%{})
  end

  defp read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, x} ->
      line
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.filter(fn {char, _} -> char != "." end)
      |> Enum.map(fn {digit, y} -> {{x, y}, String.to_integer(digit)} end)
    end)
    |> Enum.group_by(fn {_, v} -> v end, fn {k, _} -> k end)
  end
end
