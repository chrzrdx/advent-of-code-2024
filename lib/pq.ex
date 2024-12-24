defmodule PriorityQueue do
  defstruct tree: :gb_trees.empty()

  def new(), do: %PriorityQueue{}

  def insert(%PriorityQueue{tree: tree} = pq, value, priority) do
    new_tree = :gb_trees.insert(priority, value, tree)
    %PriorityQueue{pq | tree: new_tree}
  end

  def update(%PriorityQueue{tree: tree} = pq, value, priority) do
    new_tree = :gb_trees.update(priority, value, tree)
    %PriorityQueue{pq | tree: new_tree}
  end

  def pop(%PriorityQueue{tree: tree}) do
    case :gb_trees.is_empty(tree) do
      true -> {:error, :empty_queue}
      false ->
        {min_priority, min_value, new_tree} = :gb_trees.take_smallest(tree)
        {:ok, {min_value, min_priority}, %PriorityQueue{tree: new_tree}}
    end
  end

  def is_empty(%PriorityQueue{tree: tree}), do: :gb_trees.is_empty(tree)
end

p = PriorityQueue
q = p.new() |> p.insert(:a, 3) |> p.insert(:b, 4) |> p.insert(:c, 2) |> p.insert(:d, 5) |> p.insert(:e, 1)
p.pop(q)
