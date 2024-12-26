defmodule AdventOfCode.Utils.PriorityQueue do
  def new() do
    :gb_trees.empty()
  end

  def from_list(list) do
    Enum.reduce(list, :gb_trees.empty(), fn
      {priority, value}, acc -> :gb_trees.insert(priority, value, acc)
      element, acc -> :gb_trees.insert(element, nil, acc)
    end)
  end

  def to_list(queue), do: :gb_trees.to_list(queue)

  def push(queue, {priority, value}) do
    :gb_trees.insert(priority, value, queue)
  end

  def pop(queue) do
    case :gb_trees.is_empty(queue) do
      true ->
        :empty

      false ->
        {priority, value, new_queue} = :gb_trees.take_smallest(queue)
        {:ok, {priority, value}, new_queue}
    end
  end

  def peek(queue) do
    case :gb_trees.is_empty(queue) do
      true ->
        :empty

      false ->
        {priority, value} = :gb_trees.smallest(queue)
        {:ok, {priority, value}}
    end
  end

  def update(queue, priority, fun) when is_function(fun, 1) do
    case :gb_trees.lookup(priority, queue) do
      {:value, current_value} ->
        new_value = fun.(current_value)
        :gb_trees.update(priority, new_value, queue)

      :none ->
        queue
    end
  end

  def pluck(queue, predicate) when is_function(predicate, 2) do
    iterator = :gb_trees.iterator(queue)
    do_pluck_iterate(iterator, queue, predicate)
  end

  defp do_pluck_iterate(iterator, queue, predicate) do
    case :gb_trees.next(iterator) do
      {priority, value, next_iterator} ->
        if predicate.(priority, value) do
          {:ok, {priority, value}, :gb_trees.delete(priority, queue)}
        else
          do_pluck_iterate(next_iterator, queue, predicate)
        end

      :none ->
        :empty
    end
  end

  def delete(queue, priority) do
    :gb_trees.delete_any(priority, queue)
  end

  def empty?(queue), do: :gb_trees.is_empty(queue)

  def size(queue), do: :gb_trees.size(queue)
end
