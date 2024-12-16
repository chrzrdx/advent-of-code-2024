defmodule AdventOfCode.Day10Test do
  use ExUnit.Case
  alias AdventOfCode.Day10

  test "p1: basic 1" do
    assert Day10.solve_p1("test/fixtures/10/01.txt") == 1
  end

  test "p1: basic 2" do
    assert Day10.solve_p1("test/fixtures/10/02.txt") == 2
  end

  test "p1: basic 3" do
    assert Day10.solve_p1("test/fixtures/10/03.txt") == 4
  end

  test "p1: basic 4" do
    assert Day10.solve_p1("test/fixtures/10/04.txt") == 3
  end

  test "p1: basic 5" do
    assert Day10.solve_p1("test/fixtures/10/05.txt") == 36
  end

  test "p1: puzzle" do
    assert Day10.solve_p1("test/fixtures/10/puzzle.txt") == 825
  end

  test "p2: basic 1" do
    assert Day10.solve_p2("test/fixtures/10/06.txt") == 3
  end

  test "p2: basic 2" do
    assert Day10.solve_p2("test/fixtures/10/07.txt") == 13
  end

  test "p2: basic 3" do
    assert Day10.solve_p2("test/fixtures/10/08.txt") == 227
  end

  test "p2: basic 4" do
    assert Day10.solve_p2("test/fixtures/10/09.txt") == 81
  end

  test "p2: puzzle" do
    assert Day10.solve_p2("test/fixtures/10/puzzle.txt") == 1805
  end
end
