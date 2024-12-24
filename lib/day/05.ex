defmodule AdventOfCode.Day05 do
  alias AdventOfCode.Day05.{Parser, Update}

  def solve_p1(filename) do
    {safety_manual, updates} = Parser.parse(filename)

    updates
    |> Enum.map(&Update.order(&1, safety_manual))
    |> Enum.filter(&Update.correctly_ordered?/1)
    |> Enum.sum_by(&Update.middle_page/1)
  end

  def solve_p2(filename) do
    {safety_manual, updates} = Parser.parse(filename)

    updates
    |> Enum.map(&Update.order(&1, safety_manual))
    |> Enum.reject(&Update.correctly_ordered?/1)
    |> Enum.sum_by(&Update.middle_page/1)
  end
end
