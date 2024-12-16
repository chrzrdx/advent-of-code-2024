defmodule AdventOfCode.Day04Test do
  use ExUnit.Case
  alias AdventOfCode.Day04

  test "p1: basic" do
    assert Day04.solve_p1("test/fixtures/04/01.txt") == 18
  end

  test "p1: puzzle" do
    assert Day04.solve_p1("test/fixtures/04/puzzle.txt") == 2575
  end

  test "p2: basic" do
    assert Day04.solve_p2("test/fixtures/04/01.txt") == 9
  end

  test "p2: puzzle" do
    assert Day04.solve_p2("test/fixtures/04/puzzle.txt") == 2041
  end
end
