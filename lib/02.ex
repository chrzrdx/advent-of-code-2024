defmodule AdventOfCode.Day02 do
  def solve_p1(filename) do
    reports = read_input(filename)

    reports |> Enum.count(&safe?/1)
  end

  def solve_p2(filename) do
    reports = read_input(filename)

    Enum.count(reports, fn report ->
      safe?(report) or
        Enum.any?(0..(length(report) - 1), fn idx ->
          report |> List.delete_at(idx) |> safe?()
        end)
    end)
  end

  defp safe?(x), do: increasing?(x) or increasing?(Enum.reverse(x))

  defp increasing?([_]), do: true
  defp increasing?([a, b | rest]) when 1 <= b - a and b - a <= 3, do: increasing?([b | rest])
  defp increasing?(_), do: false

  defp read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer(&1))
    end)
  end
end
