defmodule AdventOfCode.Day3 do
  def solve_p1(filename) do
    read_input(filename)
    |> parse()
  end

  def solve_p2(filename) do
    read_input(filename)
    |> remove_disabled_instructions()
    |> parse()
  end

  defp parse(instructions) do
    ~r/mul\(([0-9]{1,3}),([0-9]{1,3})\)/
    |> Regex.scan(instructions)
    |> Enum.map(fn [_, a, b] -> String.to_integer(a) * String.to_integer(b) end)
    |> Enum.sum()
  end

  defp remove_disabled_instructions(instructions) do
    ~r/don't\(\).*do\(\)/U
    |> Regex.replace(instructions, "-")
  end

  defp read_input(filename) do
    filename
    |> File.read!()
    |> String.replace("\n", "-")
  end
end
