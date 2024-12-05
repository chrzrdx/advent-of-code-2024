defmodule AdventOfCode.Day04 do
  @directions %{
    n: {0, -1},
    s: {0, 1},
    e: {1, 0},
    w: {-1, 0},
    ne: {1, -1},
    se: {1, 1},
    nw: {-1, -1},
    sw: {-1, 1}
  }

  def solve_p1(filename) do
    pos_map = read_input(filename)
    word = "XMAS"
    start_positions = get_start_pos(pos_map, String.first(word))

    Enum.sum(
      Enum.map(start_positions, fn pos ->
        Enum.count(@directions, fn {_,dir} ->
          word_in_direction?(word, pos, dir, pos_map)
        end)
      end)
    )
  end

  defp word_in_direction?(word, {x, y}, {xoffset, yoffset}, pos_map) do
    String.graphemes(word)
    |> Enum.with_index()
    |> Enum.all?(fn {char, idx} ->
      Map.get(pos_map, {x + xoffset * idx, y + yoffset * idx}) == char
    end)
  end

  def solve_p2(filename) do
    read_input(filename)
    1
  end

  defp get_start_pos(pos_map, start_char) do
    pos_map
    |> Enum.filter(fn {_, char} -> char == start_char end)
    |> Enum.map(fn {k, _} -> k end)
  end

  defp read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.map(fn {line, y} ->
      line
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {char, x} -> {{x, y}, char} end)
    end)
    |> List.flatten()
    |> Enum.into(%{})
  end
end
