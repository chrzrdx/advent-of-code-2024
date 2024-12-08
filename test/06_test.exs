defmodule AdventOfCode.Day06Test do
  use ExUnit.Case
  alias AdventOfCode.Day06

  test "p1: basic" do
    assert Day06.solve_p1("test/06_tc_01.input") == 41
  end

  test "p1: puzzle" do
    assert Day06.solve_p1("test/06_tc_puzzle.input") == 5080
  end

  test "p2: basic" do
    assert Day06.solve_p2("test/06_tc_01.input") == 6
  end

  test "p2: puzzle" do
    assert Day06.solve_p2("test/06_tc_puzzle.input") == 1919
  end
end
