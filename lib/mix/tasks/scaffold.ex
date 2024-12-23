defmodule Mix.Tasks.Scaffold do
  use Mix.Task

  @shortdoc "Generates scaffold files for a new day's puzzle"

  def run([day]) do
    run([day, "util"])
  end

  def run([day, solution_module]) do
    validate_day!(day)
    module = String.capitalize(solution_module)

    with :ok <- create_directory(day),
         :ok <- create_parser_file(day),
         :ok <- create_util_file(day, module),
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

  defp create_parser_file(day) do
    content = """
    defmodule AdventOfCode.Day#{day}.Parser do
      def parse(filename) do
        filename
        |> File.read!()
        |> String.split("\\n", trim: true)
        |> Enum.map(fn line ->
          line
          |> String.split(" ", trim: true)
        end)
      end
    end
    """

    create_file("lib/day/#{day}/parser.ex", content)
  end

  defp create_util_file(day, module) do
    content = """
    defmodule AdventOfCode.Day#{day}.#{module} do
      def process(input) do
        input
      end
    end
    """

    create_file("lib/day/#{day}/#{String.downcase(module)}.ex", content)
  end

  defp create_main_file(day, module) do
    content = """
    defmodule AdventOfCode.Day#{day} do
      alias AdventOfCode.Day#{day}.{Parser, #{module}}

      def solve_p1(filename) do
        Parser.parse(filename)

        1
      end

      def solve_p2(filename) do
        Parser.parse(filename)

        1
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
