defmodule AdventOfCode.Day02.Report do
  def safe?(x), do: increasing?(x) or increasing?(Enum.reverse(x))

  def safe_with_skip?(x) do
    Enum.with_index(x)
    |> Enum.any?(fn {_, idx} ->
      x |> List.delete_at(idx) |> safe?()
    end)
  end

  defp increasing?([_]), do: true
  defp increasing?([a, b | rest]) when 1 <= b - a and b - a <= 3, do: increasing?([b | rest])
  defp increasing?(_), do: false
end
