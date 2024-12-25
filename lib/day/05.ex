defmodule AdventOfCode.Day05 do
  alias AdventOfCode.Day05.{Update, SafetyManual, Update}

  def solve_p1(filename) do
    {safety_manual, updates} = read_input(filename)

    updates
    |> Enum.map(&Update.order(&1, safety_manual))
    |> Enum.filter(&Update.correctly_ordered?/1)
    |> Enum.sum_by(&Update.middle_page/1)
  end

  def solve_p2(filename) do
    {safety_manual, updates} = read_input(filename)

    updates
    |> Enum.map(&Update.order(&1, safety_manual))
    |> Enum.reject(&Update.correctly_ordered?/1)
    |> Enum.sum_by(&Update.middle_page/1)
  end

  defp read_input(filename) do
    [part1, part2] =
      filename
      |> File.read!()
      |> String.split("\n\n", trim: true)

    safety_manual =
      part1
      |> String.split("\n", trim: true)
      |> SafetyManual.new()

    updates =
      part2
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> Update.new()
      end)

    {safety_manual, updates}
  end
end
