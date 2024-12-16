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
    {world, moves} = read_input(filename)

    moves
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
        block =
          get_block(world, next_pos)

        blocks_to_move =
          do_move_vertical(world, MapSet.new([block]), {dx, dy}, MapSet.new())

        if MapSet.size(blocks_to_move) == 0 do
          world
        else
          clear_updates =
            blocks_to_move
            |> Enum.flat_map(fn {x, y} -> [{{x, y}, "."}, {{x, y + 1}, "."}] end)
            |> Enum.into(%{})

          move_updates =
            blocks_to_move
            |> Enum.flat_map(fn {x, y} ->
              [{{x + dx, y + dy}, "["}, {{x + dx, y + dy + 1}, "]"}]
            end)
            |> Enum.into(%{})

          %{
            world
            | robot: move_robot(world.robot, {dx, dy}),
              warehouse:
                world.warehouse
                |> Map.merge(clear_updates)
                |> Map.merge(move_updates)
                |> Map.merge(%{pos => ".", next_pos => "@"})
          }
        end
    end
  end

  def do_move_vertical(world, blocks_to_push, dir, blocks_to_move) do
    if MapSet.size(blocks_to_push) == 0 do
      blocks_to_move
    else
      block = Enum.at(blocks_to_push, 0)
      remaining_blocks = MapSet.delete(blocks_to_push, block)

      case push_block(world, block, dir) do
        {:blocked, _} ->
          MapSet.new()

        {:ok, new_blocks_to_push} ->
          do_move_vertical(
            world,
            MapSet.union(remaining_blocks, MapSet.new(new_blocks_to_push)),
            dir,
            MapSet.put(blocks_to_move, block)
          )
      end
    end
  end

  def get_block(world, {x, y}) do
    case Map.get(world.warehouse, {x, y}) do
      "[" -> {x, y}
      "]" -> {x, y - 1}
      _ -> nil
    end
  end

  def push_block(world, {x, y}, {dx, dy}) do
    next_left = {x + dx, y + dy}
    next_right = {x + dx, y + 1 + dy}

    case {Map.get(world.warehouse, next_left), Map.get(world.warehouse, next_right)} do
      {_, "#"} ->
        {:blocked, []}

      {"#", _} ->
        {:blocked, []}

      _ ->
        {
          :ok,
          [get_block(world, next_left), get_block(world, next_right)] |> Enum.filter(& &1)
        }
    end
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
    |> Enum.filter(fn {_, v} -> v == "[" end)
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

  # defp display(world) do
  #   IO.write("\n")

  #   for x <- 0..(world.rows - 1) do
  #     for y <- 0..(world.cols - 1) do
  #       IO.write(Map.get(world.warehouse, {x, y}, "."))
  #     end

  #     IO.write("\n")
  #   end

  #   world
  # end
end
