defmodule AdventOfCode.Day1Test do
  use ExUnit.Case
  alias AdventOfCode.Day1

  test "basic" do
    assert Day1.solve("test/01_tc_01.input") == 11
  end

  test "solve" do
    assert Day1.solve("test/01_tc_puzzle.input") == 2_086_478
  end
end
