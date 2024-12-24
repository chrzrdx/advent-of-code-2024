defmodule AdventOfCode.Day01.Locations do
  defstruct [:left, :right]

  def from_file(filename) do
    {left, right} =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(" ", trim: true)
        |> then(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
      end)
      |> Enum.unzip()

    %__MODULE__{left: left, right: right}
  end

  def distance(%__MODULE__{left: left, right: right}) do
    sorted_left = Enum.sort(left)
    sorted_right = Enum.sort(right)

    sorted_left
    |> Stream.zip(sorted_right)
    |> Enum.sum_by(fn {a, b} -> abs(a - b) end)
  end

  def similarity(%__MODULE__{left: left, right: right}) do
    freq = Enum.frequencies(right)

    Enum.sum_by(left, fn a -> a * Map.get(freq, a, 0) end)
  end
end
