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
    reversed_blocks =
      read_input(filename)
      |> Enum.reduce({0, []}, fn {num, block}, {start, acc} ->
        {start + num, [{start, num, block} | acc]}
      end)
      |> (fn {_, blocks} -> blocks end).()

    to_move =
      reversed_blocks
      |> Enum.filter(fn {_, _, block} -> block != :free end)

    blocks_set = reversed_blocks |> MapSet.new()

    Enum.reduce(to_move, blocks_set, fn {start, num, block}, blocks_set_acc ->
      case get_farthest_free_space_to_left_idx(blocks_set_acc, {start, num, block}) do
        {fstart, fnum, :free} ->
          new_fstart = fstart + num
          new_fnum = fnum - num

          blocks_set_acc
          |> MapSet.delete({start, num, block})
          |> MapSet.delete({fstart, fnum, :free})
          |> MapSet.put({start, num, :free})
          |> MapSet.put({fstart, num, block})
          |> MapSet.put({new_fstart, new_fnum, :free})
          |> compact_free()

        _ ->
          blocks_set_acc
      end
    end)
    |> Enum.sort_by(fn {start, _, _} -> start end)
    |> expand()
    |> checksum()
  end

  def compact_free(blocks_set) do
    maybe_fragmented =
      blocks_set
      |> Enum.filter(fn {_, _, block} -> block == :free end)

    compacted =
      maybe_fragmented
      |> Enum.sort_by(fn {start, _, _} -> start end)
      |> Enum.reduce([], fn {start, num, :free}, compacted_acc ->
        case compacted_acc do
          [] ->
            [{start, num, :free}]

          [{cstart, cnum, :free} | rest] ->
            if cstart + cnum == start do
              [{cstart, num + cnum, :free} | rest]
            else
              [{start, num, :free} | compacted_acc]
            end
        end
      end)
      |> Enum.filter(fn {_, num, _} -> num > 0 end)

    blocks_set
    |> MapSet.difference(MapSet.new(maybe_fragmented))
    |> MapSet.union(MapSet.new(compacted))
  end

  def get_farthest_free_space_to_left_idx(blocks_set, {start, num, _}) do
    blocks_set
    |> Enum.filter(fn
      {fstart, fnum, :free} -> fstart < start and fnum >= num
      _ -> false
    end)
    |> Enum.min_by(fn {fstart, _, _} -> fstart end, fn -> nil end)
  end

  def expand(compacted) do
    compacted
    |> Enum.flat_map(fn
      {num, block} ->
        for _ <- 0..(num - 1)//1, do: block

      {_start, num, block} ->
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
    |> Enum.map(fn
      {:free, _index} -> 0
      {block, index} -> block * index
    end)
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
