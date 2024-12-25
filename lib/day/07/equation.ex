defmodule AdventOfCode.Day07.Equation do
  defstruct [:target, :nums]

  def new(target, nums) do
    %__MODULE__{target: target, nums: nums}
  end

  def solvable?(%__MODULE__{target: target, nums: [first | rest]}, ops) do
    solvable?(target, rest, first, ops)
  end

  def solvable?(target, [] = _nums, current, _ops), do: target == current
  def solvable?(target, _nums, current, _ops) when current > target, do: false

  def solvable?(target, [top | rest], current, ops) do
    Enum.any?(ops, fn op ->
      solvable?(target, rest, op.(current, top), ops)
    end)
  end

  def concat(a, b), do: String.to_integer("#{a}#{b}")
end
