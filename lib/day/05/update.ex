defmodule AdventOfCode.Day05.Update do
  alias AdventOfCode.Day05.SafetyManual

  defstruct [:pages, :ordered_pages]

  def new(pages) do
    %__MODULE__{
      pages: pages,
      ordered_pages: nil
    }
  end

  def order(%__MODULE__{} = update, %SafetyManual{} = manual) do
    ordered =
      Enum.sort(update.pages, fn a, b ->
        SafetyManual.valid_order?(manual, a, b)
      end)

    %{update | ordered_pages: ordered}
  end

  def correctly_ordered?(%__MODULE__{pages: pages, ordered_pages: pages}), do: true
  def correctly_ordered?(%__MODULE__{}), do: false

  def middle_page(%__MODULE__{ordered_pages: pages}) do
    Enum.at(pages, div(length(pages), 2))
  end
end
