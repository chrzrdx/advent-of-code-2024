defmodule AdventOfCode.Day3Test do
  use ExUnit.Case
  alias AdventOfCode.Day3

  test "p1: basic" do
    assert Day3.solve_p1("test/02_tc_01.input") == 1
  end

  test "p1: puzzle" do
    assert Day3.solve_p1("test/02_tc_puzzle.input") == 1
  end

  test "p2: basic" do
    assert Day3.solve_p2("test/02_tc_01.input") == 1
  end

  test "p2: puzzle" do
    assert Day3.solve_p2("test/02_tc_puzzle.input") == 1
  end
end
