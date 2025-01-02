defmodule AdventOfCode.Day11 do
  alias AdventOfCode.Day11.Stones

  def solve_p1(filename) do
    filename
    |> Stones.from_file()
    |> Stones.simulate_blinks(25)
    |> Stones.count()
  end

  def solve_p2(filename) do
    filename
    |> Stones.from_file()
    |> Stones.simulate_blinks(75)
    |> Stones.count()
  end
end
