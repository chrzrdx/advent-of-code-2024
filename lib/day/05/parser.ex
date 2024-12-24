defmodule AdventOfCode.Day05.Parser do
  alias AdventOfCode.Day05.{SafetyManual, Update}

  def parse(filename) do
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
