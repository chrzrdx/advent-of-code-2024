defmodule AdventOfCode.Day3Test do
  use ExUnit.Case
  alias AdventOfCode.Day3

  test "p1: basic" do
    assert Day3.solve_p1("test/fixtures/03/01.txt") == 161
  end

  test "p1: puzzle" do
    assert Day3.solve_p1("test/fixtures/03/puzzle.txt") == 178_794_710
  end

  test "p2: basic" do
    assert Day3.solve_p2("test/fixtures/03/02.txt") == 48
  end

  test "p2: puzzle" do
    assert Day3.solve_p2("test/fixtures/03/puzzle.txt") == 76_729_637
  end
end
