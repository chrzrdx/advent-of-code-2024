defmodule AdventOfCode.Day06.Guard do
  alias AdventOfCode.Utils.Grid

  def patrol(map, pos, direction, visited \\ MapSet.new(), steps_taken \\ MapSet.new()) do
    new_pos = Grid.move(pos, direction)
    new_steps = MapSet.put(steps_taken, {pos, direction})
    new_visited = MapSet.put(visited, pos)

    cond do
      {pos, direction} in steps_taken ->
        {:loop, new_visited}

      not Map.has_key?(map, new_pos) ->
        {:ok, new_visited}

      Map.get(map, new_pos) == "#" ->
        patrol(map, pos, turn_right(direction), new_visited, new_steps)

      true ->
        patrol(map, new_pos, direction, new_visited, new_steps)
    end
  end

  defp turn_right(:n), do: :e
  defp turn_right(:e), do: :s
  defp turn_right(:s), do: :w
  defp turn_right(:w), do: :n
end
