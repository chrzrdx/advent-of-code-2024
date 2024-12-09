defmodule AdventOfCode.Day09 do
  def solve_p1(filename) do
    blocks = read_input(filename)

    total_used = Enum.count(blocks, &(&1 != :free))
    compacted_blocks = blocks |> Enum.take(total_used)

    blocks_to_move =
      blocks
      |> Enum.filter(&(&1 != :free))
      |> Enum.reverse()

    merge(compacted_blocks, blocks_to_move) |> checksum()
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
