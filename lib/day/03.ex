defmodule AdventOfCode.Day03 do
  alias AdventOfCode.Day03.Memory

  def solve_p1(filename) do
    filename
    |> Memory.from_file()
    |> Memory.sum_multiplications()
  end

  def solve_p2(filename) do
    filename
    |> Memory.from_file()
    |> Memory.remove_disabled_instructions()
    |> Memory.sum_multiplications()
  end
end
