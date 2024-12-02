defmodule AdventOfCode.Day2Test do
  use ExUnit.Case
  alias AdventOfCode.Day2

  test "p1: basic" do
    assert Day2.solve_p1("test/02_tc_01.input") == 2
  end

  test "p1: puzzle" do
    assert Day2.solve_p1("test/02_tc_puzzle.input") == 252
  end

  test "p2: basic" do
    assert Day2.solve_p2("test/02_tc_01.input") == 4
  end

  test "p2: puzzle" do
    assert Day2.solve_p2("test/02_tc_puzzle.input") == 324
  end
end
