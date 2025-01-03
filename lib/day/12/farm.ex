defmodule AdventOfCode.Day12.Farm do
  alias AdventOfCode.Utils.Grid

  def from_file(filename) do
    filename
    |> File.read!()
    |> Grid.from_string()
  end

  def count_sides(region) do
    [:n, :s, :w, :e]
    |> Enum.map(&count_segments(region, &1))
    |> Enum.sum()
  end

  def count_segments(region, dir) do
    ordered =
      region
      |> Map.filter(fn {_, v} -> dir not in v end)
      |> Map.keys()

    case dir do
      :n -> ordered |> Enum.sort()
      :s -> ordered |> Enum.sort()
      :w -> ordered |> Enum.sort_by(fn {x, y} -> {y, x} end)
      :e -> ordered |> Enum.sort_by(fn {x, y} -> {y, x} end)
    end
    |> do_count_segments([], dir)
    |> then(&length/1)
  end

  def do_count_segments([], [], _dir), do: []
  def do_count_segments([], groups, _dir), do: groups
  def do_count_segments([top | blocks], [], dir), do: do_count_segments(blocks, [[top]], dir)

  def do_count_segments([curr | blocks], [line | lines], dir) do
    top = hd(line)

    if connected?(curr, top, dir) do
      do_count_segments(blocks, [[curr | line] | lines], dir)
    else
      do_count_segments(blocks, [[curr], line | lines], dir)
    end
  end

  def connected?({x, y}, {x2, y2}, dir) do
    case dir do
      :n -> x == x2 and y2 == y - 1
      :s -> x == x2 and y2 == y - 1
      :w -> x2 == x - 1 and y == y2
      :e -> x2 == x - 1 and y == y2
    end
  end

  def find_regions(_map, [], regions), do: regions

  def find_regions(map, [current | queue], regions) do
    region = flood_fill(map, [current], %{})
    find_regions(map, queue -- Map.keys(region), [region | regions])
  end

  def flood_fill(_, [], visited), do: visited

  def flood_fill(map, [pos | queue], visited) do
    {neighbours, connections} = get_neighbours(map, pos) |> Enum.unzip()
    new_queue = (neighbours -- Map.keys(visited)) ++ queue
    new_visited = Map.put(visited, pos, connections)
    flood_fill(map, new_queue, new_visited)
  end

  def get_neighbours(map, pos) do
    Grid.neighbours(pos, :cardinal)
    |> Enum.map(fn {direction, coord} -> {coord, direction} end)
    |> Enum.filter(fn {coord, _} -> map[coord] == map[pos] end)
  end

  def area(region), do: map_size(region)

  def perimeter(region) do
    region
    |> Map.values()
    |> Enum.map(&length/1)
    |> Enum.sum()
    |> then(&(4 * map_size(region) - &1))
  end
end
