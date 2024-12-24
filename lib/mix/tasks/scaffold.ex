defmodule Mix.Tasks.Scaffold do
  use Mix.Task

  @shortdoc "Generates scaffold files for a new day's puzzle"

  def run([day]) do
    run([day, "util"])
  end

  def run([day, module_name]) do
    validate_day!(day)

    module = %{
      pascal_case:
        module_name |> String.split("_") |> Enum.map(&String.capitalize/1) |> Enum.join(""),
      snake_case:
        module_name |> String.split("_") |> Enum.map(&String.downcase/1) |> Enum.join("_")
    }

    with :ok <- create_directory(day),
         :ok <- create_module_file(day, module),
         :ok <- create_main_file(day, module),
         :ok <- create_test_file(day),
         :ok <- create_input_files(day) do
      Mix.shell().info([:green, "✓ Successfully created scaffold for Day #{day}"])
    end
  end

  defp validate_day!(day) do
    case Integer.parse(day) do
      {num, ""} when num in 1..25 -> :ok
      _ -> Mix.raise("Day must be a number between 1 and 25")
    end
  end

  defp create_directory(day) do
    path = "lib/day/#{day}"

    if File.exists?(path) do
      Mix.shell().info([:yellow, "Directory #{path} already exists, skipping..."])
      :ok
    else
      File.mkdir_p!(path)
      :ok
    end
  end

  defp create_file(path, content) do
    if File.exists?(path) do
      Mix.shell().info([:yellow, "File #{path} already exists, skipping..."])
      :ok
    else
      File.write!(path, content)
      Mix.shell().info([:green, "Created #{path}"])
      :ok
    end
  end

  defp create_module_file(day, module) do
    content = """
    defmodule AdventOfCode.Day#{day}.#{module.pascal_case} do
      defstruct [:data]

      def from_file(filename) do
        data = filename
        |> File.read!()
        |> String.split("\\n", trim: true)
        |> Enum.map(fn line ->
          line
          |> String.split(" ", trim: true)
        end)

        %__MODULE__{data: data}
      end

      def solve(%__MODULE__{}) do
        1
      end
    end
    """

    create_file("lib/day/#{day}/#{module.snake_case}.ex", content)
  end

  defp create_main_file(day, module) do
    content = """
    defmodule AdventOfCode.Day#{day} do
      alias AdventOfCode.Day#{day}.#{module.pascal_case}

      def solve_p1(filename) do
        filename
        |> #{module.pascal_case}.from_file()
        |> #{module.pascal_case}.solve()
      end

      def solve_p2(filename) do
        filename
        |> #{module.pascal_case}.from_file()
        |> #{module.pascal_case}.solve()
      end
    end
    """

    create_file("lib/day/#{day}.ex", content)
  end

  defp create_test_file(day) do
    content = """
    defmodule AdventOfCode.Day#{day}Test do
      use ExUnit.Case
      alias AdventOfCode.Day#{day}

      test "p1: basic" do
        assert Day#{day}.solve_p1("test/fixtures/#{day}/01.txt") == 1
      end

      @tag :skip
      test "p1: puzzle" do
        assert Day#{day}.solve_p1("test/fixtures/#{day}/puzzle.txt") == 1
      end

      @tag :skip
      test "p2: basic" do
        assert Day#{day}.solve_p2("test/fixtures/#{day}/02.txt") == 1
      end

      @tag :skip
      test "p2: puzzle" do
        assert Day#{day}.solve_p2("test/fixtures/#{day}/puzzle.txt") == 1
      end
    end
    """

    create_file("test/#{day}_test.exs", content)
  end

  defp create_input_files(day) do
    File.mkdir_p!("test/fixtures/#{day}")
    create_file("test/fixtures/#{day}/01.txt", "")
    create_file("test/fixtures/#{day}/02.txt", "")
    create_file("test/fixtures/#{day}/puzzle.txt", "")
  end
end
