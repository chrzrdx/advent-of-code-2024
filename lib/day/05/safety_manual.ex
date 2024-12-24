defmodule AdventOfCode.Day05.SafetyManual do
  defstruct [:rules]

  def new(rules) do
    %__MODULE__{rules: MapSet.new(rules)}
  end

  def valid_order?(manual, a, b) do
    MapSet.member?(manual.rules, "#{a}|#{b}")
  end
end
