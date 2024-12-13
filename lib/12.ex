defmodule AdventOfCode.Day12 do
  def solve_p1(filename) do
    filename
    |> read_input()
    |> then(&find_regions(&1, Map.keys(&1), []))
    |> Enum.map(&region_score/1)
    |> Enum.sum()
  end

  def solve_p2(filename) do
    filename
    |> read_input()
    |> then(&find_regions(&1, Map.keys(&1), []))
    |> Enum.map(fn region ->
      lines =
        [:up, :down, :left, :right]
        |> Enum.map(&count_segments(region, &1))
        |> Enum.sum()

      area(region) * lines
    end)
    |> Enum.sum()
  end

  def count_segments(region, dir) do
    ordered =
      region
      |> Map.filter(fn {_, v} -> dir not in v end)
      |> Map.keys()

    case dir do
      :up -> ordered |> Enum.sort()
      :down -> ordered |> Enum.sort()
      :left -> ordered |> Enum.sort_by(fn {x, y} -> {y, x} end)
      :right -> ordered |> Enum.sort_by(fn {x, y} -> {y, x} end)
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
      :up -> x == x2 and y2 == y - 1
      :down -> x == x2 and y2 == y - 1
      :left -> x2 == x - 1 and y == y2
      :right -> x2 == x - 1 and y == y2
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

  def get_neighbours(map, {x, y}) do
    [{{x, y - 1}, :left}, {{x, y + 1}, :right}, {{x - 1, y}, :up}, {{x + 1, y}, :down}]
    |> Enum.filter(fn {pos, _} -> map[pos] == map[{x, y}] end)
  end

  def region_score(region), do: area(region) * perimeter(region)

  def area(region), do: map_size(region)

  def perimeter(region) do
    region
    |> Map.values()
    |> Enum.map(&length/1)
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
