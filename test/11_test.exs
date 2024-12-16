defmodule AdventOfCode.Day11Test do
  use ExUnit.Case
  alias AdventOfCode.Day11

  test "p1: basic" do
    assert Day11.solve_p1("test/fixtures/11/01.txt") == 55312
  end

  test "p1: puzzle" do
    assert Day11.solve_p1("test/fixtures/11/puzzle.txt") == 197_357
  end

  test "p2: puzzle" do
    assert Day11.solve_p2("test/fixtures/11/puzzle.txt") == 234_568_186_890_978
  end
end
