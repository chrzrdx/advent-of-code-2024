defmodule AdventOfCode.Day11 do
  def solve_p1(filename), do: solve(filename, 25)

  def solve_p2(filename), do: solve(filename, 75)

  def solve(filename, iterations) do
    nums = read_input(filename)

    Enum.reduce(1..iterations, nums, fn _, acc ->
      blink_nums(acc)
    end)
    |> Map.values()
    |> Enum.sum()
  end

  def blink_nums(nums) do
    Enum.flat_map(nums, fn {num, count} ->
      blink(num) |> Enum.map(fn n -> {n, count} end)
    end)
    |> Enum.reduce(%{}, fn {n, count}, acc ->
      Map.update(acc, n, count, &(&1 + count))
    end)
  end

  def blink(n) when n == 0, do: [1]

  def blink(n) do
    string = "#{n}"
    num_digits = String.length(string)

    case rem(num_digits, 2) do
      0 ->
        string
        |> String.split_at(div(num_digits, 2))
        |> then(fn {a, b} -> [String.to_integer(a), String.to_integer(b)] end)

      1 ->
        [n * 2024]
    end
  end

  defp read_input(filename) do
    filename
    |> File.read!()
    |> String.trim()
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies()
  end
end
