defmodule AdventOfCode.Day01 do
  alias AdventOfCode.Day01.{Parser, Locations}

  def solve_p1(filename) do
    {left, right} = Parser.parse(filename)

    Locations.distance(left, right)
  end

  def solve_p2(filename) do
    {left, right} = Parser.parse(filename)

    Locations.similarity(left, right)
  end
end
