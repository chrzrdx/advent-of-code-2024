defmodule AdventOfCode.Day08.Lab do
  alias AdventOfCode.Utils.Grid

  defstruct [:grid, :rows, :cols]

  def from_file(filename) do
    grid =
      filename
      |> File.read!()
      |> Grid.from_string()

    {{max_x, max_y}, _} = Enum.max_by(grid, fn {pos, _} -> pos end)

    %__MODULE__{
      grid: Map.reject(grid, fn {_, char} -> char == "." end),
      rows: max_x + 1,
      cols: max_y + 1
    }
  end

  def find_pair_antinodes(%__MODULE__{} = lab) do
    lab.grid
    |> Grid.locations()
    |> Enum.flat_map(fn {_, positions} ->
      positions
      |> make_pairs()
      |> Enum.flat_map(&calculate_antinodes(&1, lab))
    end)
    |> MapSet.new()
  end

  def find_linear_antinodes(%__MODULE__{} = lab) do
    lab.grid
    |> Grid.locations()
    |> Enum.flat_map(fn {_, positions} ->
      positions
      |> make_pairs()
      |> Enum.flat_map(&calculate_linear_antinodes(&1, lab))
    end)
    |> MapSet.new()
  end

  defp make_pairs(positions) do
    for a <- positions, b <- positions, a < b do
      {a, b}
    end
  end

  defp calculate_antinodes({pos1, pos2}, lab) do
    {x1, y1} = pos1
    {x2, y2} = pos2
    {dx, dy} = {x1 - x2, y1 - y2}

    [{x1 + dx, y1 + dy}, {x2 - dx, y2 - dy}]
    |> Enum.filter(&within_bounds?(lab, &1))
  end

  defp calculate_linear_antinodes({pos1, pos2}, lab) do
    {x1, y1} = pos1
    {x2, y2} = pos2
    {dx, dy} = {x1 - x2, y1 - y2}

    follow_path(pos1, {dx, dy}, lab) ++ follow_path(pos2, {-dx, -dy}, lab)
  end

  defp follow_path(start, {dx, dy}, lab) do
    Stream.iterate(start, fn {x, y} -> {x + dx, y + dy} end)
    |> Enum.take_while(&within_bounds?(lab, &1))
  end

  defp within_bounds?(%__MODULE__{rows: rows, cols: cols}, {x, y}) do
    x >= 0 and x < rows and y >= 0 and y < cols
  end
end
