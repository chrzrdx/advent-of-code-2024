defmodule AdventOfCode.Day04Test do
  use ExUnit.Case
  alias AdventOfCode.Day04

  test "p1: basic" do
    assert Day04.solve_p1("test/04_tc_01.input") == 18
  end

  test "p1: puzzle" do
    assert Day04.solve_p1("test/04_tc_puzzle.input") == 2575
  end

  @tag :skip
  test "p2: basic" do
    assert Day04.solve_p2("test/04_tc_02.input") == 1
  end

  @tag :skip
  test "p2: puzzle" do
    assert Day04.solve_p2("test/04_tc_puzzle.input") == 1
  end
end
