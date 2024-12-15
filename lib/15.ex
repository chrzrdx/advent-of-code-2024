defmodule AdventOfCode.Day15 do
  def solve_p1(filename) do
    {world, moves} = read_input(filename)

    moves
    |> Enum.reduce(world, fn move, acc ->
      move(
        acc,
        case move do
          "<" -> {0, -1}
          ">" -> {0, 1}
          "^" -> {-1, 0}
          "v" -> {1, 0}
        end
      )
    end)
    |> then(&score/1)
  end

  def solve_p2(filename) do
    {original_world, moves} = read_input(filename)

    original_world
    |> resize_world()
    |> display()

    1
  end

  def move(world, {dx, dy}) do
    {x, y} = pos = world.robot
    next_pos = {x + dx, y + dy}

    case Map.get(world.warehouse, next_pos) do
      "." ->
        %{
          world
          | robot: next_pos,
            warehouse:
              Map.merge(
                world.warehouse,
                %{
                  pos => ".",
                  next_pos => "@"
                }
              )
        }

      "O" ->
        case next_empty?(world, {x, y}, {dx, dy}) do
          nil ->
            world

          empty_pos ->
            %{
              world
              | robot: next_pos,
                warehouse:
                  Map.merge(
                    world.warehouse,
                    %{pos => ".", next_pos => "@", empty_pos => "O"}
                  )
            }
        end

      _ ->
        world
    end
  end

  def next_empty?(world, {x, y}, {dx, dy}) do
    next_pos = {x + dx, y + dy}

    case Map.get(world.warehouse, next_pos) do
      "." -> next_pos
      "O" -> next_empty?(world, next_pos, {dx, dy})
      _ -> nil
    end
  end

  def score(world) do
    world.warehouse
    |> Enum.filter(fn {_, v} -> v == "O" end)
    |> Enum.map(fn {{x, y}, _} -> x * 100 + y end)
    |> Enum.sum()
  end

  defp read_input(filename) do
    filename
    |> File.read!()
    |> String.split("\n\n", trim: true)
    |> then(fn [map, moves] ->
      {parse_map(map), parse_moves(moves)}
    end)
  end

  defp parse_map(map_string) do
    map_2d =
      map_string
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {line, x} ->
        line
        |> String.split("", trim: true)
        |> Enum.with_index()
        |> Enum.map(fn {char, y} -> {{x, y}, char} end)
      end)

    rows = length(map_2d)
    cols = length(map_2d |> List.first())

    warehouse =
      map_2d
      |> List.flatten()
      |> Enum.into(%{})

    %{
      warehouse: warehouse,
      rows: rows,
      cols: cols,
      robot: find_robot(warehouse)
    }
  end

  defp find_robot(warehouse) do
    warehouse
    |> Enum.find(fn {_, v} -> v == "@" end)
    |> then(&elem(&1, 0))
  end

  defp resize_world(world) do
    resized_warehouse =
      world.warehouse
      |> Enum.flat_map(fn {{x, y}, char} ->
        case char do
          "#" -> [{{x, 2 * y}, "#"}, {{x, 2 * y + 1}, "#"}]
          "." -> [{{x, 2 * y}, "."}, {{x, 2 * y + 1}, "."}]
          "O" -> [{{x, 2 * y}, "["}, {{x, 2 * y + 1}, "]"}]
          "@" -> [{{x, 2 * y}, "@"}, {{x, 2 * y + 1}, "."}]
        end
      end)
      |> Enum.into(%{})

    %{
      warehouse: resized_warehouse,
      rows: world.rows * 2,
      cols: world.cols * 2,
      robot: find_robot(resized_warehouse)
    }
  end

  defp parse_moves(moves) do
    moves
    |> then(&Regex.replace(~r/\n/, &1, ""))
    |> String.split("", trim: true)
  end

  defp display(world) do
    IO.write("\n")

    for x <- 0..(world.rows - 1) do
      for y <- 0..(world.cols - 1) do
        IO.write(Map.get(world.warehouse, {x, y}, "."))
      end

      IO.write("\n")
    end

    world
  end
end
