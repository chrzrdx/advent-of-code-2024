defmodule AdventOfCode.Day03.Memory do
  def sum_multiplications(memory) do
    ~r/mul\(([0-9]{1,3}),([0-9]{1,3})\)/
    |> Regex.scan(memory)
    |> Enum.sum_by(fn [_, a, b] -> String.to_integer(a) * String.to_integer(b) end)
  end

  def remove_disabled_instructions(memory) do
    ~r/don't\(\).*do\(\)/U
    |> Regex.replace(memory, "-")
  end
end
