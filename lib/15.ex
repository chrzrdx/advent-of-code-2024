defmodule AdventOfCode.Day15.Part1 do
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

  def move(world, {dx, dy}) do
    {x, y} = pos = world.robot
    next_pos = {x + dx, y + dy}

    case world.warehouse[next_pos] do
      "." ->
        update_positions(world, pos, next_pos)

      "O" ->
        case next_empty?(world, pos, {dx, dy}) do
          nil -> world
          empty_pos -> update_positions(world, pos, next_pos, empty_pos)
        end

      _ ->
        world
    end
  end

  defp update_positions(world, from, to) do
    %{world | robot: to, warehouse: %{world.warehouse | from => ".", to => "@"}}
  end

  defp update_positions(world, from, to, box_pos) do
    %{world | robot: to, warehouse: %{world.warehouse | from => ".", to => "@", box_pos => "O"}}
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

  def read_input(filename) do
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

  def find_robot(warehouse) do
    warehouse
    |> Enum.find(fn {_, v} -> v == "@" end)
    |> then(&elem(&1, 0))
  end

  defp parse_moves(moves) do
    moves
    |> then(&Regex.replace(~r/\n/, &1, ""))
    |> String.split("", trim: true)
  end
end

defmodule AdventOfCode.Day15.Part2 do
  alias AdventOfCode.Day15.Part1

  def solve_p2(filename) do
    {world, _moves} = read_input(filename)

    [".", ">", "<", "<", "<", "<", "<", "<"]
    |> Enum.reduce(world, fn move, acc ->
      case move do
        "<" ->
          move_horizontal(acc, {0, -1})

        ">" ->
          move_horizontal(acc, {0, 1})

        "^" ->
          move_vertical(acc, {-1, 0})

        "v" ->
          move_vertical(acc, {1, 0})

        _ ->
          world
      end
      |> display()
    end)
    |> then(&score/1)
  end

  def move_vertical(world, {dx, dy}) do
    {x, y} = pos = world.robot
    next_pos = {x + dx, y + dy}

    case Map.get(world.warehouse, next_pos) do
      nil ->
        world

      "#" ->
        world

      "." ->
        %{
          world
          | robot: move_robot(world.robot, {dx, dy}),
            warehouse: %{world.warehouse | pos => ".", next_pos => "@"}
        }

      _ ->
        do_move_vertical(world, next_pos, {dx, dy}, %{pos => ".", next_pos => "@"})
    end
  end

  def do_move_vertical(world, next_pos, {dx, dy}, updates) do
    %{
      world
      | robot: move_robot(world.robot, {dx, dy}),
        warehouse: Map.merge(world.warehouse, updates)
    }
  end

  def move_horizontal(world, {dx, dy}) do
    {x, y} = pos = world.robot
    next_pos = {x + dx, y + dy}

    case Map.get(world.warehouse, next_pos) do
      nil -> world
      "#" -> world
      _ -> do_move_horizontal(world, next_pos, {dx, dy}, %{pos => ".", next_pos => "@"})
    end
  end

  def do_move_horizontal(world, {x, y}, {dx, dy}, updates) do
    next_pos = {x + dx, y + dy}

    case Map.get(world.warehouse, {x, y}) do
      "." ->
        %{
          world
          | robot: move_robot(world.robot, {dx, dy}),
            warehouse: Map.merge(world.warehouse, updates)
        }

      c when c in ["[", "]"] ->
        do_move_horizontal(
          world,
          next_pos,
          {dx, dy},
          Map.put(updates, next_pos, c)
        )

      _ ->
        world
    end
  end

  def move_robot({x, y}, {dx, dy}) do
    {x + dx, y + dy}
  end

  def score(world) do
    world.warehouse
    |> Enum.filter(fn {_, v} -> v == "O" end)
    |> Enum.map(fn {{x, y}, _} -> x * 100 + y end)
    |> Enum.sum()
  end

  defp read_input(filename) do
    {world, moves} = Part1.read_input(filename)
    {resize_world(world), moves}
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
      rows: world.rows,
      cols: world.cols * 2,
      robot: Part1.find_robot(resized_warehouse)
    }
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
