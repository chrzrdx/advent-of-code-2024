defmodule AdventOfCode.Utils.Grid do
  @directions %{
    n: {-1, 0},
    s: {1, 0},
    e: {0, 1},
    w: {0, -1},
    ne: {-1, 1},
    nw: {-1, -1},
    se: {1, 1},
    sw: {1, -1}
  }

  @cardinal_directions [:n, :s, :e, :w]

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

  def neighbours(pos, type \\ :all)
  def neighbours(pos, :all), do: neighbours(pos, Map.keys(@directions))
  def neighbours(pos, :cardinal), do: neighbours(pos, @cardinal_directions)

  def neighbours(pos, directions) when is_list(directions) do
    Enum.map(directions, fn dir -> {dir, move(pos, dir)} end)
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
