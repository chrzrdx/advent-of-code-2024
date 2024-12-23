defmodule AdventOfCode.Day03 do
  alias AdventOfCode.Day03.{Parser, Memory}

  def solve_p1(filename) do
    memory = Parser.parse(filename)

    Memory.sum_multiplications(memory)
  end

  def solve_p2(filename) do
    memory = Parser.parse(filename)

    memory
    |> Memory.remove_disabled_instructions()
    |> Memory.sum_multiplications()
  end
end
