defmodule Churn.File.FinderTest do
  use ExUnit.Case

  alias Churn.File
  alias Churn.File.Finder

  test "it finds files with specific extension" do
    # [Given] parameters for root directory and .md extension
    path = fixtures_root_path()
    extensions = ["md"]
    ignores = []

    # [When] seeking files
    [result_file] = Finder.find([path], extensions, ignores)

    # [Then] found file that matches extension
    expected_file_path = Path.join([path, "test.md"])

    assert result_file == %File{path: expected_file_path}
  end

  test "it returns empty list of files when all ignored" do
    # [Given] parameters for root path, all exts and all files ignored
    path = fixtures_root_path()
    extensions = ["md", "txt"]

    ignores = [
      Path.join([path, "test.md"]),
      Path.join([path, "test.txt"])
    ]

    # [When] seeking files
    results = Finder.find([path], extensions, ignores)

    # [Then] result list should be empty
    assert results == []
  end

  defp fixtures_root_path, do: "test/fixtures/finder"
end
