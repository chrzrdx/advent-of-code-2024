defmodule AdventOfCode.Day11 do
  def solve_p1(filename) do
    nums = read_input(filename)

    Enum.reduce(1..25, nums, fn _, acc ->
      blink_nums(acc)
    end)
    |> Enum.count()
  end

  def solve_p2(filename) do
    read_input(filename)
    1
  end

  def blink_nums(nums), do: Enum.flat_map(nums, &blink/1)

  def blink(n) when n == 0, do: [1]

  def blink(n) do
    string = "#{n}"
    num_digits = String.length(string)

    case Kernel.rem(num_digits, 2) do
      0 ->
        String.split_at(string, div(num_digits, 2))
        |> Tuple.to_list()
        |> Enum.map(&String.to_integer/1)

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
  end
end
