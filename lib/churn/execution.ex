defmodule Churn.Execution do
  @moduledoc """
  The main mechanism responsible for running analyse of printing results on the screen.
  """

  alias Churn.Configuration
  alias Churn.File.Finder
  alias Churn.Processor
  alias Churn.Processor.Result

  @spec run(Configuration.t()) :: :ok
  def run(%Configuration{
        directories_to_scan: dirs_to_scan,
        file_extensions: exts,
        files_to_ignore: files_to_ignore,
        commit_since: commit_since
      }) do
    results =
      Finder.find(dirs_to_scan, exts, files_to_ignore)
      |> Stream.map(fn file ->
        Processor.process(file, commit_since)
      end)
      |> Stream.filter(fn {status, _result} -> status == :ok end)
      |> Stream.map(fn {:ok, result} -> result end)
      |> Enum.to_list()

    max_times_changed =
      results
      |> Enum.map(& &1.times_changed)
      |> Enum.max()

    max_complexity =
      results
      |> Enum.map(& &1.complexity)
      |> Enum.max()

    results
    |> Enum.sort_by(&Result.get_priority/1, :desc)
    |> Enum.map(fn result ->
      Result.with_score(result, max_times_changed, max_complexity)
    end)

    :ok
  end
end
