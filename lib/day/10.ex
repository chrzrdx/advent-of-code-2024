defmodule AdventOfCode.Day10 do
  alias AdventOfCode.Day10.Trail

  def solve_p1(filename) do
    filename
    |> Trail.from_file()
    |> Trail.score_all_trailheads()
  end

  def solve_p2(filename) do
    filename
    |> Trail.from_file()
    |> Trail.rate_all_trailheads()
  end
end
