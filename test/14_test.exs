defmodule AdventOfCode.Day14Test do
  use ExUnit.Case
  alias AdventOfCode.Day14

  test "p1: basic" do
    assert Day14.solve_p1("test/14_tc_01.input") == 12
  end

  test "p1: puzzle" do
    assert Day14.solve_p1("test/14_tc_puzzle.input") == 229_980_828
  end

  @tag :skip
  test "p2: basic" do
    assert Day14.solve_p2("test/14_tc_02.input") == 1
  end

  @tag :skip
  test "p2: puzzle" do
    assert Day14.solve_p2("test/14_tc_puzzle.input") == 1
  end
end
