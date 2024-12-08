defmodule AdventOfCode.Day05 do
  def solve_p1(filename) do
    {rules, updates} = read_input(filename)

    updates
    |> Enum.filter(&correct_order?(rules, &1))
    |> Enum.map(fn list -> Enum.at(list, Kernel.div(length(list), 2)) end)
    |> Enum.sum()
  end

  def solve_p2(filename) do
    {rules, updates} = read_input(filename)

    updates
    |> Enum.filter(fn update -> not correct_order?(update, rules) end)
    |> Enum.map(fn list -> Enum.at(list, Kernel.div(length(list), 2)) end)
    |> Enum.sum()
  end

  def correct_order?(rules, [first | rest] = _update) do
    correct_order?(rules, [first], rest)
  end

  def correct_order?(_rules, _in_order, []), do: true

  def correct_order?(rules, [top | rest_in_order], [next | rest]) do
    case rules[next] != nil and MapSet.member?(rules[next], top) do
      true -> correct_order?(rules, [next, top | rest_in_order], rest)
      false -> false
    end
  end

  defp read_input(filename) do
    [part1, part2] =
      filename
      |> File.read!()
      |> String.split("\n\n", trim: true)

    rules =
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

    {rules, updates}
  end
end
