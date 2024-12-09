defmodule AdventOfCode.Day08Test do
  use ExUnit.Case
  alias AdventOfCode.Day08

  test "p1: basic" do
    assert Day08.solve_p1("test/08_tc_01.input") == 14
  end

  test "p1: puzzle" do
    assert Day08.solve_p1("test/08_tc_puzzle.input") == 247
  end

  @tag :skip
  test "p2: basic" do
    assert Day08.solve_p2("test/08_tc_01.input") == 1
  end

  @tag :skip
  test "p2: puzzle" do
    assert Day08.solve_p2("test/08_tc_puzzle.input") == 1
  end
end
