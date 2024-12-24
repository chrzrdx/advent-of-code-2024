defmodule AdventOfCode.Day02 do
  alias AdventOfCode.Day02.Reports

  def solve_p1(filename) do
    filename
    |> Reports.from_file()
    |> Reports.count_safe_reports()
  end

  def solve_p2(filename) do
    filename
    |> Reports.from_file()
    |> Reports.count_safe_reports_with_maybe_skip()
  end
end
