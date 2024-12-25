defmodule AdventOfCode.Day13 do
  alias AdventOfCode.Day13.ClawMachine

  def solve_p1(filename) do
    get_claw_machines(filename)
    |> Enum.map(&ClawMachine.cost/1)
    |> Enum.sum()
  end

  def solve_p2(filename) do
    get_claw_machines(filename)
    |> Enum.map(&ClawMachine.increase_target_by_10_000_000_000_000/1)
    |> Enum.map(&ClawMachine.cost/1)
    |> Enum.sum()
  end

  defp get_claw_machines(filename) do
    filename
    |> File.read!()
    |> String.split("\n\n", trim: true)
    |> Enum.map(&ClawMachine.from_string/1)
  end
end
