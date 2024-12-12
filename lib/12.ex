defmodule AdventOfCode.Day12 do
  def solve_p1(filename) do
    filename
    |> read_input()
    |> then(&find_regions(&1, Map.keys(&1), []))
    |> Enum.map(&region_score/1)
    |> Enum.sum()
  end

  def solve_p2(filename) do
    read_input(filename)
    1
  end

  def find_regions(_map, [], regions), do: regions

  def find_regions(map, [current | queue], regions) do
    region = flood_fill(map, [current], %{})
    find_regions(map, queue -- Map.keys(region), [region | regions])
  end

  def flood_fill(_, [], visited), do: visited

  def flood_fill(map, [pos | queue], visited) do
    neighbours = get_neighbours(map, pos)
    new_queue = (neighbours -- Map.keys(visited)) ++ queue
    new_visited = Map.put(visited, pos, length(neighbours))
    flood_fill(map, new_queue, new_visited)
  end

  def get_neighbours(map, {x, y}) do
    [{x, y - 1}, {x, y + 1}, {x - 1, y}, {x + 1, y}]
    |> Enum.filter(&(map[&1] == map[{x, y}]))
  end

  def region_score(region), do: area(region) * perimeter(region)

  def area(region), do: map_size(region)

  def perimeter(region) do
    region
    |> Map.values()
    |> Enum.sum()
    |> then(&(4 * map_size(region) - &1))
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
      |> Enum.map(fn {char, y} -> {{x, y}, char} end)
    end)
    |> Map.new()
  end
end
