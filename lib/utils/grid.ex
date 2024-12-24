defmodule AdventOfCode.Utils.Grid do
  @directions %{
    n: {0, -1},
    s: {0, 1},
    e: {1, 0},
    w: {-1, 0},
    ne: {1, -1},
    nw: {-1, -1},
    se: {1, 1},
    sw: {-1, 1}
  }

  def from_string(string) do
    string
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, x} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {char, y} ->
        {{x, y}, char}
      end)
    end)
    |> Map.new()
  end

  def directions(only \\ nil)
  def directions(nil), do: @directions
  def directions(only) when is_list(only), do: Map.take(@directions, only)

  def move({x, y}, direction, steps \\ 1) do
    {dx, dy} = @directions[direction]
    {x + dx * steps, y + dy * steps}
  end

  def at(grid, position), do: Map.get(grid, position)

  def in_direction(grid, {x, y}, direction, steps \\ 1) do
    {dx, dy} = @directions[direction]
    at(grid, {x + dx * steps, y + dy * steps})
  end

  def neighbors(pos, directions \\ Map.keys(@directions)) do
    Enum.map(directions, &move(pos, &1))
  end

  def locations(grid) do
    Enum.group_by(
      grid,
      fn {_pos, char} -> char end,
      fn {pos, _char} -> pos end
    )
  end

  def locations(grid, chars), do: Map.take(locations(grid), chars)
end
