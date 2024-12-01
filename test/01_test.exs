defmodule AdventOfCode.Day1Test do
  use ExUnit.Case
  alias AdventOfCode.Day1

  test "p1: basic" do
    assert Day1.solve_p1("test/01_tc_01.input") == 11
  end

  test "p1: puzzle" do
    assert Day1.solve_p1("test/01_tc_puzzle.input") == 2_086_478
  end

  test "p2: basic" do
    assert Day1.solve_p2("test/01_tc_01.input") == 31
  end

  test "p2: puzzle" do
    assert Day1.solve_p2("test/01_tc_puzzle.input") == 24_941_624
  end
end
