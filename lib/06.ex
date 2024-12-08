defmodule AdventOfCode.Day06 do
  @north {-1, 0}
  @south {1, 0}
  @east {0, 1}
  @west {0, -1}

  def solve_p1(filename) do
    {map, start_pos} = read_input(filename)
    {:ok, map_after_walking} = walk(map, start_pos, @north)
    count_walked(map_after_walking)
  end

  def solve_p2(filename) do
    {map, start_pos} = read_input(filename)

    possible_obstacles(map, start_pos)
    |> Enum.map(fn obstacle ->
      new_map = Map.put(map, obstacle, "#")

      case walk(new_map, start_pos, @north) do
        {:ok, _} -> 0
        {:loop, _} -> 1
      end
    end)
    |> Enum.sum()
  end

  def walk(map, {x, y} = pos, {xoffset, yoffset} = dir, steps_taken \\ %{}) do
    new_pos = {x + xoffset, y + yoffset}
    new_steps_taken = Map.put(steps_taken, {pos, dir}, true)

    if steps_taken[{pos, dir}] do
      {:loop, map}
    else
      case map[new_pos] do
        "." -> walk(Map.put(map, new_pos, "^"), new_pos, dir, new_steps_taken)
        "^" -> walk(Map.put(map, new_pos, "^"), new_pos, dir, new_steps_taken)
        "#" -> walk(map, pos, turn_right(dir), new_steps_taken)
        nil -> {:ok, map}
      end
    end
  end

  def turn_right(@north), do: @east
  def turn_right(@east), do: @south
  def turn_right(@south), do: @west
  def turn_right(@west), do: @north

  def count_walked(map) do
    map
    |> Map.values()
    |> Enum.count(fn c -> c == "^" end)
  end

  def possible_obstacles(map, start_pos) do
    {:ok, walked_map} = walk(map, start_pos, @north)

    walked_map
    |> Map.keys()
    |> Enum.filter(fn pos -> pos != start_pos and walked_map[pos] == "^" end)
  end

  defp read_input(filename) do
    positions =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {line, x} ->
        line
        |> String.split("", trim: true)
        |> Enum.with_index()
        |> Enum.map(fn {char, y} -> {{x, y}, char} end)
      end)
      |> List.flatten()

    {start_position, _} = Enum.find(positions, fn {_, char} -> char == "^" end)

    {Enum.into(positions, %{}), start_position}
  end
end
