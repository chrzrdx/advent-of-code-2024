defmodule AdventOfCode.Day11.Stones do
  defstruct [:frequencies]

  def from_file(filename) do
    frequencies =
      filename
      |> File.read!()
      |> String.trim()
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()

    %__MODULE__{frequencies: frequencies}
  end

  def simulate_blinks(%__MODULE__{} = stones, num_blinks) do
    Enum.reduce(1..num_blinks, stones, fn _, acc -> blink(acc) end)
  end

  def blink(%__MODULE__{} = stones) do
    new_frequencies =
      stones.frequencies
      |> Enum.flat_map(fn {stone, count} ->
        split_stone(stone) |> Enum.map(&{&1, count})
      end)
      |> Enum.reduce(%{}, fn {stone, count}, acc ->
        Map.update(acc, stone, count, &(&1 + count))
      end)

    %__MODULE__{frequencies: new_frequencies}
  end

  def split_stone(0), do: [1]

  def split_stone(n) do
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

  def count(%__MODULE__{} = stones) do
    Enum.sum_by(stones.frequencies, fn {_, count} -> count end)
  end
end
