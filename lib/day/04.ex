defmodule AdventOfCode.Day04 do
  alias AdventOfCode.Day04.WordSearch

  def solve_p1(filename) do
    filename
    |> WordSearch.from_file()
    |> WordSearch.count_xmas()
  end

  def solve_p2(filename) do
    filename
    |> WordSearch.from_file()
    |> WordSearch.count_cross_mas()
  end
end
