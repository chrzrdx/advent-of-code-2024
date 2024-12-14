defmodule AdventOfCode.Day14 do
  def solve_p1(filename) do
    [robots, bathroom] = read_input(filename)

    after_n_seconds(robots, 100, bathroom)
    |> safety_factor(bathroom)
  end

  def solve_p2(filename) do
    read_input(filename)
    1
  end

  def after_n_seconds(robots, n, bathroom) do
    robots
    |> Enum.map(fn [px, py, vx, vy] ->
      [wrap(px + vx * n, bathroom.rows), wrap(py + vy * n, bathroom.cols), vx, vy]
    end)
  end

  def wrap(a, b) when rem(a, b) < 0, do: rem(a, b) + b
  def wrap(a, b), do: rem(a, b)

  def safety_factor(robots, bathroom) do
    robots
    |> Enum.map(fn [px, py, _, _] -> quadrant(px, py, bathroom) end)
    |> Enum.filter(fn q -> q != :na end)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.product()
  end

  def quadrant(px, py, bathroom) do
    cond do
      px in bathroom.q1.x and py in bathroom.q1.y -> :q1
      px in bathroom.q2.x and py in bathroom.q2.y -> :q2
      px in bathroom.q3.x and py in bathroom.q3.y -> :q3
      px in bathroom.q4.x and py in bathroom.q4.y -> :q4
      true -> :na
    end
  end

  def bathroom_quadrants(rows, cols) do
    midrow = div(rows, 2)
    midcol = div(cols, 2)

    q1 = %{x: 0..(midrow - 1), y: 0..(midcol - 1)}
    q2 = %{x: (midrow + 1)..(rows - 1), y: 0..(midcol - 1)}
    q3 = %{x: 0..(midrow - 1), y: (midcol + 1)..(cols - 1)}
    q4 = %{x: (midrow + 1)..(rows - 1), y: (midcol + 1)..(cols - 1)}

    %{q1: q1, q2: q2, q3: q3, q4: q4, rows: rows, cols: cols}
  end

  defp read_input(filename) do
    [grid | lines] =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)

    [[_, rows, cols]] = Regex.scan(~r/grid=(\d+),(\d+)/, grid)

    robots =
      lines
      |> Enum.map(fn line ->
        [[_, py, px, vy, vx]] = Regex.scan(~r/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/, line)
        [px, py, vx, vy] |> Enum.map(&String.to_integer/1)
      end)

    [robots, bathroom_quadrants(String.to_integer(rows), String.to_integer(cols))]
  end
end
