defmodule AdventOfCode.Day12 do
  def solve_p1(filename) do
    {map, vertices} = read_input(filename)

    all_regions(map, vertices)
    |> Enum.map(&(area(&1) * perimeter(&1)))
    |> Enum.sum()
  end

  def solve_p2(filename) do
    read_input(filename)
    1
  end

  def all_regions(map, to_visit, regions \\ []) do
    case MapSet.size(to_visit) do
      0 ->
        regions

      _ ->
        current = Enum.at(to_visit, 0)
        r = region(map, [current], %{})

        visited = Map.keys(r) |> MapSet.new()
        remaining_to_visit = MapSet.difference(to_visit, visited)

        all_regions(map, remaining_to_visit, [r | regions])
    end
  end

  def region(_, [], visited), do: visited

  def region(map, [current | to_visit], visited) do
    adjacent = connected(map, current)
    unvisited = Enum.filter(adjacent, &(!Map.has_key?(visited, &1))) ++ to_visit
    updated_visited = Map.put(visited, current, length(adjacent))
    region(map, unvisited, updated_visited)
  end

  def connected(map, {x, y}) do
    [{x, y - 1}, {x, y + 1}, {x - 1, y}, {x + 1, y}]
    |> Enum.filter(fn pos -> map[pos] == map[{x, y}] end)
  end

  def area(region), do: length(Map.keys(region))

  def perimeter(region) do
    Map.values(region)
    |> Enum.map(&(4 - &1))
    |> Enum.sum()
  end

  defp read_input(filename) do
    map =
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

    vertices = MapSet.new(Map.keys(map))

    {map, vertices}
  end
end
