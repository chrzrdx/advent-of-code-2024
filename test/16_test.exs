defmodule AdventOfCode.Day16Test do
  use ExUnit.Case
  alias AdventOfCode.Day16

  test "p1: basic 1" do
    assert Day16.solve_p1("test/fixtures/16/01.txt") == 7036
  end

  @tag :skip
  test "p1: basic 2" do
    assert Day16.solve_p1("test/fixtures/16/02.txt") == 11048
  end

  @tag :skip
  test "p1: puzzle" do
    assert Day16.solve_p1("test/fixtures/16/puzzle.txt") == 1
  end

  @tag :skip
  test "p2: basic" do
    assert Day16.solve_p2("test/fixtures/16/02.txt") == 1
  end

  @tag :skip
  test "p2: puzzle" do
    assert Day16.solve_p2("test/fixtures/16/puzzle.txt") == 1
  end
end
