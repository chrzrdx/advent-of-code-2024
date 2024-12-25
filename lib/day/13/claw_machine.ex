defmodule AdventOfCode.Day13.ClawMachine do
  defstruct [:button_a, :button_b, :target]

  def cost(%__MODULE__{button_a: {a, b}, button_b: {c, d}, target: {e, f}}) do
    try do
      x = div(d * e - c * f, d * a - c * b)
      y = div(b * e - a * f, b * c - a * d)

      if a * x + c * y == e and b * x + d * y == f, do: 3 * x + y, else: 0
    rescue
      _ -> 0
    end
  end

  def from_string(input) do
    [[_, a, b]] = Regex.scan(~r/Button A: X\+(\d+), Y\+(\d+)/, input)
    [[_, c, d]] = Regex.scan(~r/Button B: X\+(\d+), Y\+(\d+)/, input)
    [[_, e, f]] = Regex.scan(~r/Prize: X\=(\d+), Y\=(\d+)/, input)

    %__MODULE__{
      button_a: {String.to_integer(a), String.to_integer(b)},
      button_b: {String.to_integer(c), String.to_integer(d)},
      target: {String.to_integer(e), String.to_integer(f)}
    }
  end

  def increase_target_by_10_000_000_000_000(%__MODULE__{target: {e, f}} = machine) do
    %__MODULE__{machine | target: {10_000_000_000_000 + e, 10_000_000_000_000 + f}}
  end
end
