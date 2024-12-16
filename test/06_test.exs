defmodule AdventOfCode.Day06Test do
  use ExUnit.Case
  alias AdventOfCode.Day06

  test "p1: basic" do
    assert Day06.solve_p1("test/fixtures/06/01.txt") == 41
  end

  test "p1: puzzle" do
    assert Day06.solve_p1("test/fixtures/06/puzzle.txt") == 5080
  end

  test "p2: basic" do
    assert Day06.solve_p2("test/fixtures/06/01.txt") == 6
  end

  test "p2: puzzle" do
    assert Day06.solve_p2("test/fixtures/06/puzzle.txt") == 1919
  end
end
