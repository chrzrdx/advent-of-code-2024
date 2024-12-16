defmodule AdventOfCode.Day12Test do
  use ExUnit.Case
  alias AdventOfCode.Day12

  test "p1: basic 1" do
    assert Day12.solve_p1("test/fixtures/12/01.txt") == 140
  end

  test "p1: basic 2" do
    assert Day12.solve_p1("test/fixtures/12/02.txt") == 772
  end

  test "p1: basic 3" do
    assert Day12.solve_p1("test/fixtures/12/03.txt") == 1930
  end

  test "p1: puzzle" do
    assert Day12.solve_p1("test/fixtures/12/puzzle.txt") == 1_387_004
  end

  test "p2: basic 1" do
    assert Day12.solve_p2("test/fixtures/12/01.txt") == 80
  end

  test "p2: basic 2" do
    assert Day12.solve_p2("test/fixtures/12/02.txt") == 436
  end

  test "p2: basic 3" do
    assert Day12.solve_p2("test/fixtures/12/03.txt") == 1206
  end

  test "p2: basic 4" do
    assert Day12.solve_p2("test/fixtures/12/04.txt") == 236
  end

  test "p2: basic 5" do
    assert Day12.solve_p2("test/fixtures/12/05.txt") == 368
  end

  test "p2: puzzle" do
    assert Day12.solve_p2("test/fixtures/12/puzzle.txt") == 844_198
  end
end
