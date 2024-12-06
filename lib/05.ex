defmodule AdventOfCode.Day05 do
  def solve_p1(filename) do
    {ordering_rules, updates} = read_input(filename)

    updates
    |> Enum.filter(&correct_order?(&1, ordering_rules))
    |> Enum.map(fn list -> Enum.at(list, Kernel.div(length(list), 2)) end)
    |> Enum.sum()
  end

  def solve_p2(filename) do
    read_input(filename)
    1
  end

  def correct_order?([head | tail], ordering_rules) do
    correct_order?(tail, ordering_rules, MapSet.new([head]))
  end

  defp correct_order?([], _ordering_rules, _current_order), do: true

  defp correct_order?([head | tail], ordering_rules, current_order) do
    case ordering_rules[head] != nil and MapSet.subset?(current_order, ordering_rules[head]) do
      true -> correct_order?(tail, ordering_rules, MapSet.put(current_order, head))
      false -> false
    end
  end

  defp read_input(filename) do
    [part1, part2] =
      filename
      |> File.read!()
      |> String.split("\n\n", trim: true)

    ordering_rules =
      part1
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split("|", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.group_by(
        fn [_, b] -> b end,
        fn [a, _] -> a end
      )
      |> Map.new(fn {k, v} -> {k, MapSet.new(v)} end)

    updates =
      part2
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    {ordering_rules, updates}
  end
end
