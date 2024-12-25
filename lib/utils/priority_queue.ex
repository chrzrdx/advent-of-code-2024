defmodule AdventOfCode.Utils.PriorityQueue do
  @moduledoc """
  A priority queue implementation wrapping :gb_trees.
  """

  defstruct [:queue, :comparator]

  def new(comparator \\ &<=/2) do
    %__MODULE__{
      queue: :gb_trees.empty(),
      comparator: comparator
    }
  end

  def from_list(list, comparator \\ &<=/2) do
    queue =
      Enum.reduce(list, :gb_trees.empty(), fn
        {priority, value}, acc -> :gb_trees.insert(priority, value, acc)
        element, acc -> :gb_trees.insert(element, nil, acc)
      end)

    %__MODULE__{queue: queue, comparator: comparator}
  end

  def to_list(%__MODULE__{queue: queue}), do: :gb_trees.to_list(queue)

  def push(%__MODULE__{queue: queue} = pq, {priority, value}) do
    %{pq | queue: :gb_trees.insert(priority, value, queue)}
  end

  def pop(%__MODULE__{queue: queue} = pq) do
    case :gb_trees.is_empty(queue) do
      true ->
        :empty

      false ->
        {priority, value, new_queue} = :gb_trees.take_smallest(queue)
        {:ok, {priority, value}, %{pq | queue: new_queue}}
    end
  end

  def peek(%__MODULE__{queue: queue}) do
    case :gb_trees.is_empty(queue) do
      true ->
        :empty

      false ->
        {priority, value} = :gb_trees.smallest(queue)
        {:ok, {priority, value}}
    end
  end

  def update(%__MODULE__{queue: queue} = pq, priority, fun) when is_function(fun, 1) do
    case :gb_trees.lookup(priority, queue) do
      {:value, current_value} ->
        new_value = fun.(current_value)
        %{pq | queue: :gb_trees.update(priority, new_value, queue)}

      :none ->
        pq
    end
  end

  def pluck(%__MODULE__{} = pq, predicate) when is_function(predicate, 2) do
    iterator = :gb_trees.iterator(pq.queue)
    do_pluck_iterate(iterator, pq.queue, predicate)
  end

  defp do_pluck_iterate(iterator, queue, predicate) do
    case :gb_trees.next(iterator) do
      {priority, value, next_iterator} ->
        if predicate.(priority, value) do
          {:ok, {priority, value}, %{queue: :gb_trees.delete(priority, queue)}}
        else
          do_pluck_iterate(next_iterator, queue, predicate)
        end
      :none ->
        :empty
    end
  end

  def delete(%__MODULE__{queue: queue} = pq, priority) do
    %{pq | queue: :gb_trees.delete_any(priority, queue)}
  end

  def empty?(%__MODULE__{queue: queue}), do: :gb_trees.is_empty(queue)

  def size(%__MODULE__{queue: queue}), do: :gb_trees.size(queue)
end
