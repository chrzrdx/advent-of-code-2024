defmodule AdventOfCode.Day16 do
  alias AdventOfCode.Day16.Graph
  alias AdventOfCode.Day16.Path

  @max_score :infinity

  def solve_p1(filename) do
    read_input(filename)
    |> find_min_weight_path()
  end

  def solve_p2(filename) do
    read_input(filename)
    1
  end

  def find_min_weight_path(graph) do
    find_min_weight_path(graph, Path.new(graph.start, {0, 1}), @max_score)
  end

  def find_min_weight_path(graph, path, min_score) when path.position == graph.end do
    min(path.score, min_score)
  end

  def find_min_weight_path(graph, path, min_score) do
    cond do
      path.score >= min_score ->
        min_score

      not Graph.contains?(graph, path.position) ->
        @max_score

      true ->
        straight = go(path, graph, :straight, min_score)
        left = go(path, graph, :left, min(min_score, straight))
        right = go(path, graph, :right, min(min(min_score, straight), left))

        [straight, left, right]
        |> Enum.min()
    end
  end

  def go(path, graph, direction, min_score) do
    {new_direction, score} =
      case direction do
        :straight -> {path.direction, 1}
        :left -> {rotate_90(path.direction), 1001}
        :right -> {rotate_270(path.direction), 1001}
      end

    new_pos = move(path.position, new_direction)

    if Path.visited?(path, new_pos) do
      @max_score
    else
      new_path = Path.add(path, new_pos, new_direction, score)
      find_min_weight_path(graph, new_path, min_score)
    end
  end

  defp move({x, y}, {dx, dy}), do: {x + dx, y + dy}
  defp rotate_90({dx, dy}), do: {dy, -dx}
  defp rotate_270({dx, dy}), do: {-dy, dx}

  defp read_input(filename) do
    {vertices, markers} =
      filename
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.reduce({MapSet.new(), %{}}, fn {line, x}, {vertices, markers} ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce({vertices, markers}, fn
          {"S", y}, {v, m} -> {MapSet.put(v, {x, y}), Map.put(m, :start, {x, y})}
          {"E", y}, {v, m} -> {MapSet.put(v, {x, y}), Map.put(m, :end, {x, y})}
          {".", y}, {v, m} -> {MapSet.put(v, {x, y}), m}
          _, acc -> acc
        end)
      end)

    Graph.new(vertices, markers.start, markers.end)
  end
end

defmodule AdventOfCode.Day16.Graph do
  defstruct [:vertices, :start, :end]

  def new(vertices, start, end_pos) do
    %__MODULE__{
      vertices: vertices,
      start: start,
      end: end_pos
    }
  end

  def contains?(graph, pos), do: pos in graph.vertices
end

defmodule AdventOfCode.Day16.Path do
  defstruct [:position, :direction, :score, :visited]

  def new(pos, dir) do
    %__MODULE__{
      position: pos,
      direction: dir,
      score: 0,
      visited: MapSet.new([pos])
    }
  end

  def add(path, new_pos, new_dir, score_increment) do
    %__MODULE__{
      position: new_pos,
      direction: new_dir,
      score: path.score + score_increment,
      visited: MapSet.put(path.visited, new_pos)
    }
  end

  def visited?(path, pos), do: pos in path.visited
end
