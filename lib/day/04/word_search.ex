defmodule AdventOfCode.Day04.WordSearch do
  alias AdventOfCode.Utils.Grid

  def from_file(filename) do
    filename
    |> File.read!()
    |> Grid.from_string()
  end

  # word = "XMAS"
  def count_xmas(grid) do
    locations = Grid.locations(grid)

    Enum.sum_by(locations["X"], fn pos ->
      Enum.count([:n, :s, :e, :w, :ne, :se, :nw, :sw], fn dir ->
        Grid.in_direction(grid, pos, dir, 1) == "M" and
          Grid.in_direction(grid, pos, dir, 2) == "A" and
          Grid.in_direction(grid, pos, dir, 3) == "S"
      end)
    end)
  end

  # cross_pairs = [
  #   {"MAS", "MAS"},
  #   {"MAS", "SAM"},
  #   {"SAM", "MAS"},
  #   {"SAM", "SAM"}
  # ]
  def count_cross_mas(grid) do
    locations = Grid.locations(grid)

    Enum.count(locations["A"], fn pos ->
      nw = Grid.in_direction(grid, pos, :nw)
      ne = Grid.in_direction(grid, pos, :ne)
      sw = Grid.in_direction(grid, pos, :sw)
      se = Grid.in_direction(grid, pos, :se)

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
