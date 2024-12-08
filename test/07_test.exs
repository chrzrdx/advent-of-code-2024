defmodule AdventOfCode.Day07Test do
  use ExUnit.Case
  alias AdventOfCode.Day07

  test "p1: basic" do
    assert Day07.solve_p1("test/07_tc_01.input") == 3749
  end

  test "p1: puzzle" do
    assert Day07.solve_p1("test/07_tc_puzzle.input") == 7_710_205_485_870
  end

  @tag :skip
  test "p2: basic" do
    assert Day07.solve_p2("test/07_tc_02.input") == 1
  end

  @tag :skip
  test "p2: puzzle" do
    assert Day07.solve_p2("test/07_tc_puzzle.input") == 1
  end
end
