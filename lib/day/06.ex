defmodule AdventOfCode.Day06 do
  alias AdventOfCode.Day06.{Lab, Guard}

  def solve_p1(filename) do
    {map, start_pos} = Lab.from_file(filename)
    {:ok, visited} = Guard.patrol(map, start_pos, :n)
    Lab.count_walked(visited)
  end

  def solve_p2(filename) do
    {map, start_pos} = Lab.from_file(filename)
    Lab.count_obstructions(map, start_pos)
  end
end
