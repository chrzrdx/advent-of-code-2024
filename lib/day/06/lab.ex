defmodule AdventOfCode.Day06.Lab do
  alias AdventOfCode.Utils.Grid
  alias AdventOfCode.Day06.Guard

  def from_file(filename) do
    map =
      filename
      |> File.read!()
      |> Grid.from_string()

    {map, find_guard(map)}
  end

  def find_guard(map) do
    map
    |> Grid.locations(["^"])
    |> Map.get("^")
    |> List.first()
  end

  def count_walked(visited) do
    MapSet.size(visited)
  end

  def possible_obstacles(map, start_pos) do
    {:ok, visited} = Guard.patrol(map, start_pos, :n)
    MapSet.delete(visited, start_pos)
  end

  def count_obstructions(map, start_pos) do
    possible_obstacles(map, start_pos)
    |> Enum.count(fn obstacle ->
      new_map = Map.put(map, obstacle, "#")

      case Guard.patrol(new_map, start_pos, :n) do
        {:ok, _} -> false
        {:loop, _} -> true
      end
    end)
  end
end
