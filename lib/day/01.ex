defmodule AdventOfCode.Day01 do
  alias AdventOfCode.Day01.Locations

  def solve_p1(filename) do
    filename
    |> Locations.from_file()
    |> Locations.distance()
  end

  def solve_p2(filename) do
    filename
    |> Locations.from_file()
    |> Locations.similarity()
  end
end
