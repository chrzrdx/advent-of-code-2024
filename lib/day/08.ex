defmodule AdventOfCode.Day08 do
  alias AdventOfCode.Day08.Lab

  def solve_p1(filename) do
    filename
    |> Lab.from_file()
    |> Lab.find_pair_antinodes()
    |> Enum.count()
  end

  def solve_p2(filename) do
    filename
    |> Lab.from_file()
    |> Lab.find_linear_antinodes()
    |> Enum.count()
  end
end
