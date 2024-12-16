defmodule AdventOfCode.Day01Test do
  use ExUnit.Case
  alias AdventOfCode.Day01

  test "p1: basic" do
    assert Day01.solve_p1("test/fixtures/01/01.txt") == 11
  end

  test "p1: puzzle" do
    assert Day01.solve_p1("test/fixtures/01/puzzle.txt") == 2_086_478
  end

  test "p2: basic" do
    assert Day01.solve_p2("test/fixtures/01/01.txt") == 31
  end

  test "p2: puzzle" do
    assert Day01.solve_p2("test/fixtures/01/puzzle.txt") == 24_941_624
  end
end
