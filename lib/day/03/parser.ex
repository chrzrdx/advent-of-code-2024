defmodule AdventOfCode.Day03.Parser do
  def parse(filename) do
    filename
    |> File.read!()
    |> String.replace("\n", "-")
  end
end
