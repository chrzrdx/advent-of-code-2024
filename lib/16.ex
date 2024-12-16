defmodule AdventOfCode.Day16 do
  def solve_p1(filename) do
    read_input(filename)
    |> IO.inspect()

    1
  end

  def solve_p2(filename) do
    read_input(filename)
    1
  end

  defp read_input(filename) do
    groups =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, x} ->
        line
        |> String.split("", trim: true)
        |> Enum.with_index()
        |> Enum.filter(fn {char, _} -> char != "#" end)
        |> Enum.map(fn {char, y} -> {char, {x, y}} end)
      end)
      |> Enum.group_by(fn {k, _v} -> k end, fn {_k, v} -> v end)

    vertices =
      (Map.get(groups, "S") ++ Map.get(groups, "E") ++ Map.get(groups, ".")) |> MapSet.new()

    graph =
      vertices
      |> Enum.map(fn {x, y} ->
        neighbours =
          [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]
          |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
          |> Enum.filter(&MapSet.member?(vertices, &1))

        {{x, y}, neighbours}
      end)
      |> Enum.into(%{})

    %{
      graph: graph,
      start: Map.get(groups, "S") |> hd(),
      end: Map.get(groups, "E") |> hd(),
      dir: {0, 1}
    }
  end

  def rotate_90({dx, dy}), do: {dy, -dx}
  def rotate_270({dx, dy}), do: {-dy, dx}
end
