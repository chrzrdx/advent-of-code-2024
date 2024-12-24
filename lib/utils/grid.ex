defmodule AdventOfCode.Utils.Grid do
  @directions %{
    n: %{dx: 0, dy: -1},
    s: %{dx: 0, dy: 1},
    e: %{dx: 1, dy: 0},
    w: %{dx: -1, dy: 0},
    ne: %{dx: 1, dy: -1},
    se: %{dx: 1, dy: 1},
    nw: %{dx: -1, dy: -1},
    sw: %{dx: -1, dy: 1}
  }

  defstruct [:grid, :locations]

  def from_string(string) do
    grid =
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

    locations =
      Enum.group_by(
        grid,
        fn {_pos, char} -> char end,
        fn {pos, _char} -> pos end
      )

    %__MODULE__{grid: grid, locations: locations}
  end

  def directions(only \\ nil)
  def directions(nil), do: @directions
  def directions(only) when is_list(only), do: Map.take(@directions, only)

  def move({x, y}, direction, steps \\ 1) do
    dir = @directions[direction]
    {x + dir.dx * steps, y + dir.dy * steps}
  end

  def at(grid, position), do: Map.get(grid, position)

  def in_direction(grid, {x, y}, direction, steps \\ 1) do
    dir = @directions[direction]
    at(grid, {x + dir.dx * steps, y + dir.dy * steps})
  end
end
