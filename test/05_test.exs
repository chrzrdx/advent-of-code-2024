defmodule AdventOfCode.Day05Test do
  use ExUnit.Case
  alias AdventOfCode.Day05

  test "p1: basic" do
    assert Day05.solve_p1("test/05_tc_01.input") == 143
  end

  test "p1: puzzle" do
    assert Day05.solve_p1("test/05_tc_puzzle.input") == 6242
  end

  test "p2: basic" do
    assert Day05.solve_p2("test/05_tc_01.input") == 123
  end

  test "p2: puzzle" do
    assert Day05.solve_p2("test/05_tc_puzzle.input") == 5169
  end
end
