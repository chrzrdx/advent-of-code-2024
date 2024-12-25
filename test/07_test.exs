defmodule AdventOfCode.Day07Test do
  use ExUnit.Case
  alias AdventOfCode.Day07

  test "p1: basic" do
    assert Day07.solve_p1("test/fixtures/07/01.txt") == 3749
  end

  test "p1: puzzle" do
    assert Day07.solve_p1("test/fixtures/07/puzzle.txt") == 7_710_205_485_870
  end

  test "p2: basic" do
    assert Day07.solve_p2("test/fixtures/07/01.txt") == 11387
  end

  test "p2: puzzle" do
    assert Day07.solve_p2("test/fixtures/07/puzzle.txt") == 20_928_985_450_275
  end
end
