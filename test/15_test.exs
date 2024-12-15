defmodule AdventOfCode.Day15Test do
  use ExUnit.Case
  alias AdventOfCode.Day15

  test "p1: basic 1" do
    assert Day15.Part1.solve_p1("test/15_tc_01.input") == 2028
  end

  test "p1: basic 2" do
    assert Day15.Part1.solve_p1("test/15_tc_02.input") == 10092
  end

  test "p1: puzzle" do
    assert Day15.Part1.solve_p1("test/15_tc_puzzle.input") == 1_414_416
  end

  test "p2: basic" do
    assert Day15.Part2.solve_p2("test/15_tc_02.input") == 1
  end

  @tag :skip
  test "p2: puzzle" do
    assert Day15.Part2.solve_p2("test/15_tc_puzzle.input") == 1
  end
end
