defmodule AdventOfCode.Day08Test do
  use ExUnit.Case
  alias AdventOfCode.Day08

  test "p1: basic" do
    assert Day08.solve_p1("test/08_tc_01.input") == 3
  end

  test "p1: more antennae" do
    assert Day08.solve_p1("test/08_tc_02.input") == 14
  end

  test "p1: puzzle" do
    assert Day08.solve_p1("test/08_tc_puzzle.input") == 247
  end

  test "p2: basic" do
    assert Day08.solve_p2("test/08_tc_01.input") == 9
  end

  test "p2: more antennae" do
    assert Day08.solve_p2("test/08_tc_02.input") == 34
  end

  test "p2: puzzle" do
    assert Day08.solve_p2("test/08_tc_puzzle.input") == 861
  end
end
