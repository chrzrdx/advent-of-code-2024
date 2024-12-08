defmodule AdventOfCode.Day07Test do
  use ExUnit.Case
  alias AdventOfCode.Day07

  @tag :skip
  test "p1: basic" do
    assert Day07.solve_p1("test/07_tc_01.input") == 3749
  end

  @tag :skip
  test "p1: puzzle" do
    assert Day07.solve_p1("test/07_tc_puzzle.input") == 7_710_205_485_870
  end

  test "p2: basic" do
    assert Day07.solve_p2("test/07_tc_01.input") == 11387
  end

  test "p2: puzzle" do
    assert Day07.solve_p2("test/07_tc_puzzle.input") == 20_928_985_450_275
  end
end
