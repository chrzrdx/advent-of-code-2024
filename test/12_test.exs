defmodule AdventOfCode.Day12Test do
  use ExUnit.Case
  alias AdventOfCode.Day12

  test "p1: basic 1" do
    assert Day12.solve_p1("test/12_tc_01.input") == 140
  end

  test "p1: basic 2" do
    assert Day12.solve_p1("test/12_tc_02.input") == 772
  end

  test "p1: basic 3" do
    assert Day12.solve_p1("test/12_tc_03.input") == 1930
  end

  test "p1: puzzle" do
    assert Day12.solve_p1("test/12_tc_puzzle.input") == 1_387_004
  end

  test "p2: basic 1" do
    assert Day12.solve_p2("test/12_tc_01.input") == 80
  end

  @tag :skip
  test "p2: basic 2" do
    assert Day12.solve_p2("test/12_tc_02.input") == 436
  end

  @tag :skip
  test "p2: basic 3" do
    assert Day12.solve_p2("test/12_tc_03.input") == 1206
  end

  @tag :skip
  test "p2: basic 4" do
    assert Day12.solve_p2("test/12_tc_04.input") == 236
  end

  @tag :skip
  test "p2: basic 5" do
    assert Day12.solve_p2("test/12_tc_05.input") == 368
  end

  @tag :skip
  test "p2: puzzle" do
    assert Day12.solve_p2("test/12_tc_puzzle.input") == 1
  end
end
