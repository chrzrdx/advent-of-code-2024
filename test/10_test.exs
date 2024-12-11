defmodule AdventOfCode.Day10Test do
  use ExUnit.Case
  alias AdventOfCode.Day10

  test "p1: basic 1" do
    assert Day10.solve_p1("test/10_tc_01.input") == 1
  end

  test "p1: basic 2" do
    assert Day10.solve_p1("test/10_tc_02.input") == 2
  end

  test "p1: basic 3" do
    assert Day10.solve_p1("test/10_tc_03.input") == 4
  end

  test "p1: basic 4" do
    assert Day10.solve_p1("test/10_tc_04.input") == 3
  end

  test "p1: basic 5" do
    assert Day10.solve_p1("test/10_tc_05.input") == 36
  end

  test "p1: puzzle" do
    assert Day10.solve_p1("test/10_tc_puzzle.input") == 825
  end

  test "p2: basic 1" do
    assert Day10.solve_p2("test/10_tc_06.input") == 3
  end

  test "p2: basic 2" do
    assert Day10.solve_p2("test/10_tc_07.input") == 13
  end

  test "p2: basic 3" do
    assert Day10.solve_p2("test/10_tc_08.input") == 227
  end

  test "p2: basic 4" do
    assert Day10.solve_p2("test/10_tc_09.input") == 81
  end

  test "p2: puzzle" do
    assert Day10.solve_p2("test/10_tc_puzzle.input") == 1805
  end
end
