defmodule AdventOfCode.Day05Test do
  use ExUnit.Case
  alias AdventOfCode.Day05

  test "p1: basic" do
    assert Day05.solve_p1("test/fixtures/05/01.txt") == 143
  end

  test "p1: puzzle" do
    assert Day05.solve_p1("test/fixtures/05/puzzle.txt") == 6242
  end

  test "p2: basic" do
    assert Day05.solve_p2("test/fixtures/05/01.txt") == 123
  end

  test "p2: puzzle" do
    assert Day05.solve_p2("test/fixtures/05/puzzle.txt") == 5169
  end
end
