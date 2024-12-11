defmodule AdventOfCode.Day10 do
  def solve_p1(filename) do
    heights =
      read_input(filename)
      |> Enum.group_by(fn {_, v} -> v end, fn {k, _} -> k end)

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
    heights =
      read_input(filename)
      |> Enum.group_by(fn {_, v} -> v end, fn {k, _} -> k end)

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

  def trailhead(_trails, 0, heights) do
    heights[0]
    |> Enum.map(fn pos -> {pos, MapSet.new([pos])} end)
    |> Enum.into(%{})
  end

  def trailhead(trails, n, heights) do
    heights[n]
    |> Enum.map(fn {x, y} ->
      up = Map.get(trails, {x, y - 1}, MapSet.new())
      down = Map.get(trails, {x, y + 1}, MapSet.new())
      left = Map.get(trails, {x - 1, y}, MapSet.new())
      right = Map.get(trails, {x + 1, y}, MapSet.new())

      trails_at_pos =
        up
        |> MapSet.union(down)
        |> MapSet.union(left)
        |> MapSet.union(right)

      {{x, y}, trails_at_pos}
    end)
    |> Enum.into(%{})
  end

  def rating(_map, 0, heights) do
    heights[0]
    |> Enum.map(fn {x, y} -> {{x, y}, 1} end)
    |> Enum.into(%{})
  end

  def rating(map, n, heights) do
    heights[n]
    |> Enum.map(fn {x, y} ->
      up = Map.get(map, {x, y - 1}, 0)
      down = Map.get(map, {x, y + 1}, 0)
      left = Map.get(map, {x - 1, y}, 0)
      right = Map.get(map, {x + 1, y}, 0)

      {{x, y}, up + down + left + right}
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
    |> Enum.into(%{})
  end
end
