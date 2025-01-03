defmodule AdventOfCode.Day12 do
  alias AdventOfCode.Day12.Farm

  def solve_p1(filename) do
    filename
    |> Farm.from_file()
    |> then(&Farm.find_regions(&1, Map.keys(&1), []))
    |> Enum.map(&(Farm.area(&1) * Farm.perimeter(&1)))
    |> Enum.sum()
  end

  def solve_p2(filename) do
    filename
    |> Farm.from_file()
    |> then(&Farm.find_regions(&1, Map.keys(&1), []))
    |> Enum.map(&(Farm.area(&1) * Farm.count_sides(&1)))
    |> Enum.sum()
  end
end
