defmodule AdventOfCode.Day13Test do
  use ExUnit.Case
  alias AdventOfCode.Day13

  test "p1: basic" do
    assert Day13.solve_p1("test/13_tc_01.input") == 480
  end

  test "p1: puzzle" do
    assert Day13.solve_p1("test/13_tc_puzzle.input") == 29388
  end

  test "p2: puzzle" do
    assert Day13.solve_p2("test/13_tc_puzzle.input") == 99_548_032_866_004
  end
end
