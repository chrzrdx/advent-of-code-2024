defmodule AdventOfCode.Day07 do
  def solve_p1(filename) do
    read_input(filename)
    |> Enum.filter(&solvable_p1?/1)
    |> Enum.map(fn {target, _} -> target end)
    |> Enum.sum()
  end

  def solve_p2(filename) do
    read_input(filename)
    |> Enum.filter(&solvable_p2?/1)
    |> IO.inspect()
    |> Enum.map(fn {target, _} -> target end)
    |> Enum.sum()
  end

  def solvable_p1?({target, [first | rest]}) do
    solvable_p1?(target, first, rest)
  end

  def solvable_p1?(target, current, []), do: target == current
  def solvable_p1?(target, current, _nums) when current > target, do: false

  def solvable_p1?(target, current, [top | rest]) do
    solvable_p1?(target, current * top, rest) or
      solvable_p1?(target, current + top, rest)
  end

  def solvable_p2?({target, [first | rest]}) do
    solvable_p2?(target, first, rest, [{:+, first}])
  end

  def solvable_p2?(target, current, [], _ops), do: target == current

  def solvable_p2?(target, current, [top | rest] = nums, ops) do
    IO.inspect({target, current, nums, ops, nil})

    solvable_p2?(target, current * top, rest, [{:*, top} | ops]) or
      solvable_p2?(target, current + top, rest, [{:+, top} | ops]) or
      concat_and_solvable_p2?(target, current, nums, ops)
  end

  def concat_and_solvable_p2?(
        target,
        current,
        [top | rest] = nums,
        [{last_op, last_num} | rest_ops] = ops
      ) do
    joined = String.to_integer("#{last_num}#{top}")

    IO.inspect({target, current, nums, ops, joined})

    previous =
      case last_op do
        :* -> Kernel.div(current, last_num)
        :+ -> current - last_num
      end

    case last_op do
      :* ->
        solvable_p2?(target, previous * joined, rest, [{:*, joined} | rest_ops])

      :+ ->
        solvable_p2?(target, previous + joined, rest, [{:+, joined} | rest_ops])
    end
  end

  defp read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [first, rest] = String.split(line, ":", trim: true)
      target = String.to_integer(first)
      nums = rest |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
      {target, nums}
    end)
  end
end
