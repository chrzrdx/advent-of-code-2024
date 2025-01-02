defmodule AdventOfCode.Day10.Trail do
  defstruct [:heights]

  def from_file(filename) do
    heights =
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

    %__MODULE__{heights: heights}
  end

  defp adjacent({x, y}) do
    [{x, y - 1}, {x, y + 1}, {x - 1, y}, {x + 1, y}]
  end

  def score_all_trailheads(%__MODULE__{} = trail) do
    MapSet.new()
    |> trailhead(0, trail)
    |> trailhead(1, trail)
    |> trailhead(2, trail)
    |> trailhead(3, trail)
    |> trailhead(4, trail)
    |> trailhead(5, trail)
    |> trailhead(6, trail)
    |> trailhead(7, trail)
    |> trailhead(8, trail)
    |> trailhead(9, trail)
    |> Enum.sum_by(fn {_, trails} -> MapSet.size(trails) end)
  end

  defp trailhead(_trails, 0, %__MODULE__{heights: heights}) do
    heights[0]
    |> Map.new(fn pos -> {pos, MapSet.new([pos])} end)
  end

  defp trailhead(trails, n, %__MODULE__{heights: heights}) do
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

  def rate_all_trailheads(%__MODULE__{} = trail) do
    Map.new()
    |> rating(0, trail)
    |> rating(1, trail)
    |> rating(2, trail)
    |> rating(3, trail)
    |> rating(4, trail)
    |> rating(5, trail)
    |> rating(6, trail)
    |> rating(7, trail)
    |> rating(8, trail)
    |> rating(9, trail)
    |> Enum.sum_by(fn {_, v} -> v end)
  end

  defp rating(_map, 0, %__MODULE__{heights: heights}) do
    heights[0]
    |> Map.new(fn pos -> {pos, 1} end)
  end

  defp rating(map, n, %__MODULE__{heights: heights}) do
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
end
