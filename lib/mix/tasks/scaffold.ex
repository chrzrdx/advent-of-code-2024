defmodule Mix.Tasks.Scaffold do
  use Mix.Task

  @shortdoc "Generates scaffold files for a new day's puzzle"

  def run([day]) do
    create_lib_file(day)
    create_test_file(day)
    create_input_files(day)
  end

  defp create_lib_file(day) do
    content = """
    defmodule AdventOfCode.Day#{day} do
      def solve_p1(filename) do
        read_input(filename)
        1
      end

      def solve_p2(filename) do
        read_input(filename)
        1
      end

      defp read_input(filename) do
        filename
        |> File.read!()
        |> String.split("\\n", trim: true)
      end
    end
    """

    File.write!("lib/#{day}.ex", content)
  end

  defp create_test_file(day) do
    content = """
    defmodule AdventOfCode.Day#{day}Test do
      use ExUnit.Case
      alias AdventOfCode.Day#{day}

      test "p1: basic" do
        assert Day#{day}.solve_p1("test/#{day}_tc_01.input") == 1
      end

      @tag :skip
      test "p1: puzzle" do
        assert Day#{day}.solve_p1("test/#{day}_tc_puzzle.input") == 1
      end

      @tag :skip
      test "p2: basic" do
        assert Day#{day}.solve_p2("test/#{day}_tc_02.input") == 1
      end

      @tag :skip
      test "p2: puzzle" do
        assert Day#{day}.solve_p2("test/#{day}_tc_puzzle.input") == 1
      end
    end
    """

    File.write!("test/#{day}_test.exs", content)
  end

  defp create_input_files(day) do
    File.write!("test/#{day}_tc_01.input", "")
    File.write!("test/#{day}_tc_02.input", "")
    File.write!("test/#{day}_tc_puzzle.input", "")
  end
end
