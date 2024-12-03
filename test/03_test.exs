defmodule AdventOfCode.Day3Test do
  use ExUnit.Case
  alias AdventOfCode.Day3

  test "p1: basic" do
    assert Day3.solve_p1("test/03_tc_01.input") == 161
  end

  test "p1: puzzle" do
    assert Day3.solve_p1("test/03_tc_puzzle.input") == 178_794_710
  end

  test "p2: basic" do
    assert Day3.solve_p2("test/03_tc_02.input") == 48
  end

  test "p2: puzzle" do
    assert Day3.solve_p2("test/03_tc_puzzle.input") == 76_729_637
  end
end
