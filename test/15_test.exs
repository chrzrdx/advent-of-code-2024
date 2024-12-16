defmodule AdventOfCode.Day15Test do
  use ExUnit.Case
  alias AdventOfCode.Day15

  test "p1: basic 1" do
    assert Day15.Part1.solve_p1("test/fixtures/15/01.txt") == 2028
  end

  test "p1: basic 2" do
    assert Day15.Part1.solve_p1("test/fixtures/15/02.txt") == 10092
  end

  test "p1: puzzle" do
    assert Day15.Part1.solve_p1("test/fixtures/15/puzzle.txt") == 1_414_416
  end

  test "p2: basic" do
    assert Day15.Part2.solve_p2("test/fixtures/15/02.txt") == 9021
  end

  test "p2: puzzle" do
    assert Day15.Part2.solve_p2("test/fixtures/15/puzzle.txt") == 1_386_070
  end
end
