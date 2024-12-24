defmodule AdventOfCode.Day02.Reports do
  alias AdventOfCode.Day02.Report

  defstruct [:reports]

  def from_file(filename) do
    reports =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(" ", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    %__MODULE__{reports: reports}
  end

  def count_safe_reports(%__MODULE__{reports: reports}) do
    Enum.count(reports, &Report.safe?/1)
  end

  def count_safe_reports_with_maybe_skip(%__MODULE__{reports: reports}) do
    Enum.count(reports, fn report ->
      Report.safe?(report) or Report.safe_with_skip?(report)
    end)
  end
end
