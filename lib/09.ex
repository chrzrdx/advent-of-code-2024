defmodule AdventOfCode.Day09 do
  def solve_p1(filename) do
    blocks = read_input(filename)

    only_used = blocks |> Enum.filter(fn x -> x != :free end)
    num_used = only_used |> Enum.count()

    num_free_to_fill_in =
      blocks
      |> Enum.take(num_used)
      |> Enum.count(fn x -> x == :free end)

    unchanged_blocks = blocks |> Enum.take(num_used)

    blocks_to_fill_in = only_used |> Enum.take(-num_free_to_fill_in) |> Enum.reverse()

    merge(unchanged_blocks, blocks_to_fill_in)
    |> checksum()
  end

  def solve_p2(filename) do
    read_input(filename)
    1
  end

  def merge(blocks, fill_blocks) do
    {result, _} =
      Enum.reduce(blocks, {[], fill_blocks}, fn
        :free, {acc, [fill | rest]} -> {[fill | acc], rest}
        block, {acc, fill} -> {[block | acc], fill}
      end)

    Enum.reverse(result)
  end

  def checksum(blocks) do
    blocks
    |> Enum.with_index()
    |> Enum.map(fn {block, index} -> block * index end)
    |> Enum.sum()
  end

  defp read_input(filename) do
    filename
    |> File.read!()
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.with_index()
    |> Enum.flat_map(fn
      {[used, free], file_index} ->
        used_blocks = Enum.map(0..(used - 1)//1, fn _ -> file_index end)
        free_blocks = Enum.map(0..(free - 1)//1, fn _ -> :free end)
        used_blocks ++ free_blocks

      {[used], file_index} ->
        used_blocks = Enum.map(0..(used - 1)//1, fn _ -> file_index end)
        used_blocks
    end)
  end
end
