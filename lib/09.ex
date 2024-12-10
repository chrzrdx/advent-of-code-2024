defmodule AdventOfCode.Day09 do
  def solve_p1(filename) do
    blocks = filename |> read_input() |> expand()

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

  def expand(compacted) do
    compacted
    |> Enum.flat_map(fn {num, block} ->
      for _ <- 0..(num - 1)//1, do: block
    end)
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
    |> Enum.with_index()
    |> Enum.map(fn {num_blocks, index} ->
      case Kernel.rem(index, 2) do
        0 -> {num_blocks, Kernel.div(index, 2)}
        _ -> {num_blocks, :free}
      end
    end)
  end
end
