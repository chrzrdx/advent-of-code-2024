defmodule AdventOfCode.Day05 do
  def solve_p1(filename) do
    {rules, updates} = read_input(filename)

    updates
    |> Enum.map(&order(rules, &1))
    |> Enum.filter(&original_update_correct?/1)
    |> Enum.map(fn {update, _} -> update end)
    |> Enum.map(&middle_page/1)
    |> Enum.sum()
  end

  def solve_p2(filename) do
    {rules, updates} = read_input(filename)

    updates
    |> Enum.map(&order(rules, &1))
    |> Enum.filter(&(not original_update_correct?(&1)))
    |> Enum.map(fn {_, ordered} -> ordered end)
    |> Enum.map(&middle_page/1)
    |> Enum.sum()
  end

  def order(rules, update) do
    ordered_update =
      Enum.sort(update, fn a, b ->
        MapSet.member?(rules, "#{a}|#{b}")
      end)

    {update, ordered_update}
  end

  def original_update_correct?({update, ordered_update}) do
    Enum.zip(update, ordered_update) |> Enum.all?(fn {a, b} -> a == b end)
  end

  def middle_page(update), do: Enum.at(update, Kernel.div(length(update), 2))

  defp read_input(filename) do
    [part1, part2] =
      filename
      |> File.read!()
      |> String.split("\n\n", trim: true)

    rules =
      part1
      |> String.split("\n", trim: true)
      |> Enum.into(MapSet.new())

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
