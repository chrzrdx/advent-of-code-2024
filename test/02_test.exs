defmodule AdventOfCode.Day02Test do
  use ExUnit.Case
  alias AdventOfCode.Day02

  test "p1: basic" do
    assert Day02.solve_p1("test/fixtures/02/01.txt") == 2
  end

  test "p1: puzzle" do
    assert Day02.solve_p1("test/fixtures/02/puzzle.txt") == 252
  end

  test "p2: basic" do
    assert Day02.solve_p2("test/fixtures/02/01.txt") == 4
  end

  test "p2: puzzle" do
    assert Day02.solve_p2("test/fixtures/02/puzzle.txt") == 324
  end
end
