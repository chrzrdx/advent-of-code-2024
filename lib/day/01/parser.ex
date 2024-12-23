defmodule AdventOfCode.Day01.Parser do
  def parse(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> then(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
    end)
    |> Enum.unzip()
  end
end
