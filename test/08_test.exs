defmodule AdventOfCode.Day08Test do
  use ExUnit.Case
  alias AdventOfCode.Day08

  test "p1: basic" do
    assert Day08.solve_p1("test/fixtures/08/01.txt") == 3
  end

  test "p1: more antennae" do
    assert Day08.solve_p1("test/fixtures/08/02.txt") == 14
  end

  test "p1: puzzle" do
    assert Day08.solve_p1("test/fixtures/08/puzzle.txt") == 247
  end

  test "p2: basic" do
    assert Day08.solve_p2("test/fixtures/08/01.txt") == 9
  end

  test "p2: more antennae" do
    assert Day08.solve_p2("test/fixtures/08/02.txt") == 34
  end

  test "p2: puzzle" do
    assert Day08.solve_p2("test/fixtures/08/puzzle.txt") == 861
  end
end
