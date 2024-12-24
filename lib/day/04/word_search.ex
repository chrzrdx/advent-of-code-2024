defmodule AdventOfCode.Day04.WordSearch do
  @directions %{
    n: %{dx: 0, dy: -1},
    s: %{dx: 0, dy: 1},
    e: %{dx: 1, dy: 0},
    w: %{dx: -1, dy: 0},
    ne: %{dx: 1, dy: -1},
    se: %{dx: 1, dy: 1},
    nw: %{dx: -1, dy: -1},
    sw: %{dx: -1, dy: 1}
  }

  defstruct [:grid, :locations]

  def from_file(filename) do
    grid =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, y} ->
        line
        |> String.split("", trim: true)
        |> Enum.with_index()
        |> Enum.map(fn {char, x} -> {{x, y}, char} end)
      end)

    locations = Enum.group_by(grid, fn {_pos, char} -> char end, fn {pos, _char} -> pos end)

    %__MODULE__{grid: Enum.into(grid, %{}), locations: locations}
  end

  def count_xmas(%__MODULE__{grid: grid, locations: locations}) do
    # word = "XMAS"

    Enum.sum_by(locations["X"], fn {x, y} ->
      Enum.count(@directions, fn {_, dir} ->
        Map.get(grid, {x + dir.dx * 1, y + dir.dy * 1}) == "M" and
          Map.get(grid, {x + dir.dx * 2, y + dir.dy * 2}) == "A" and
          Map.get(grid, {x + dir.dx * 3, y + dir.dy * 3}) == "S"
      end)
    end)
  end

  def count_cross_mas(%__MODULE__{grid: grid, locations: locations}) do
    # cross_pairs = [
    #   {"MAS", "MAS"},
    #   {"MAS", "SAM"},
    #   {"SAM", "MAS"},
    #   {"SAM", "SAM"}
    # ]

    Enum.count(locations["A"], fn {x, y} ->
      nw = Map.get(grid, {x + @directions.nw.dx, y + @directions.nw.dy})
      ne = Map.get(grid, {x + @directions.ne.dx, y + @directions.ne.dy})
      sw = Map.get(grid, {x + @directions.sw.dx, y + @directions.sw.dy})
      se = Map.get(grid, {x + @directions.se.dx, y + @directions.se.dy})

      case {nw, se, ne, sw} do
        {"M", "S", "M", "S"} -> true
        {"M", "S", "S", "M"} -> true
        {"S", "M", "M", "S"} -> true
        {"S", "M", "S", "M"} -> true
        _ -> false
      end
    end)
  end
end
