defmodule AdventOfCode.Day02.Report do
  def safe?(report), do: increasing?(report) or increasing?(Enum.reverse(report))

  def safe_with_skip?(report) do
    report
    |> Stream.with_index(fn _, idx -> List.delete_at(report, idx) end)
    |> Enum.any?(&safe?/1)
  end

  defp increasing?([_]), do: true
  defp increasing?([a, b | rest]) when 1 <= b - a and b - a <= 3, do: increasing?([b | rest])
  defp increasing?(_), do: false
end
