defmodule AdventOfCode.Day06 do
  @north {-1, 0}
  @south {1, 0}
  @east {0, 1}
  @west {0, -1}

  def solve_p1(filename) do
    {map, start_pos} = read_input(filename)
    map_after_walking = walk(map, start_pos, @north)
    count_walked(map_after_walking)
  end

  def solve_p2(filename) do
    read_input(filename)
    1
  end

  def walk(map, {x, y} = pos, {xoffset, yoffset} = dir) do
    new_pos = {x + xoffset, y + yoffset}

    case map[new_pos] do
      "." -> walk(Map.put(map, new_pos, "^"), new_pos, dir)
      "^" -> walk(Map.put(map, new_pos, "^"), new_pos, dir)
      "#" -> walk(map, pos, turn_right(dir))
      nil -> map
    end
  end

  def turn_right(dir) do
    case dir do
      @north -> @east
      @east -> @south
      @south -> @west
      @west -> @north
    end
  end

  def count_walked(map) do
    map
    |> Map.values()
    |> Enum.count(fn c -> c == "^" end)
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
