defmodule AdventOfCode.Day02 do
  alias AdventOfCode.Day02.{Parser, Report}

  def solve_p1(filename) do
    reports = Parser.parse(filename)

    reports
    |> Enum.count(&Report.safe?/1)
  end

  def solve_p2(filename) do
    reports = Parser.parse(filename)

    reports
    |> Enum.count(fn report ->
      Report.safe?(report) or Report.safe_with_skip?(report)
    end)
  end
end
