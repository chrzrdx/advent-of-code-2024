defmodule AdventOfCode.Day11Test do
  use ExUnit.Case
  alias AdventOfCode.Day11

  test "p1: basic" do
    assert Day11.solve_p1("test/11_tc_01.input") == 55312
  end

  test "p1: puzzle" do
    assert Day11.solve_p1("test/11_tc_puzzle.input") == 197_357
  end

  @tag :skip
  test "p2: basic" do
    assert Day11.solve_p2("test/11_tc_02.input") == 1
  end

  @tag :skip
  test "p2: puzzle" do
    assert Day11.solve_p2("test/11_tc_puzzle.input") == 1
  end
end
