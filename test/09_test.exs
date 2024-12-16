defmodule AdventOfCode.Day09Test do
  use ExUnit.Case
  alias AdventOfCode.Day09

  test "p1: basic" do
    assert Day09.solve_p1("test/fixtures/09/01.txt") == 1928
  end

  test "p1: puzzle" do
    assert Day09.solve_p1("test/fixtures/09/puzzle.txt") == 6_200_294_120_911
  end

  test "p2: basic" do
    assert Day09.solve_p2("test/fixtures/09/01.txt") == 2858
  end

  test "p2: puzzle" do
    assert Day09.solve_p2("test/fixtures/09/puzzle.txt") == 6_227_018_762_750
  end
end
