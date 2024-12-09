defmodule AdventOfCode.Day09Test do
  use ExUnit.Case
  alias AdventOfCode.Day09

  test "p1: basic" do
    assert Day09.solve_p1("test/09_tc_01.input") == 1928
  end

  test "p1: puzzle" do
    assert Day09.solve_p1("test/09_tc_puzzle.input") == 6_200_294_120_911
  end

  @tag :skip
  test "p2: basic" do
    assert Day09.solve_p2("test/09_tc_02.input") == 1
  end

  @tag :skip
  test "p2: puzzle" do
    assert Day09.solve_p2("test/09_tc_puzzle.input") == 1
  end
end
