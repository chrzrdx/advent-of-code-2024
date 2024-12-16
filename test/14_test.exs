defmodule AdventOfCode.Day14Test do
  use ExUnit.Case
  alias AdventOfCode.Day14

  test "p1: basic" do
    assert Day14.solve_p1("test/fixtures/14/01.txt") == 12
  end

  test "p1: puzzle" do
    assert Day14.solve_p1("test/fixtures/14/puzzle.txt") == 229_980_828
  end

  @tag :skip
  test "p2: basic" do
    assert Day14.solve_p2("test/fixtures/14/02.txt") == 1
  end

  test "p2: puzzle" do
    assert Day14.solve_p2("test/fixtures/14/puzzle.txt") == 1
  end
end
