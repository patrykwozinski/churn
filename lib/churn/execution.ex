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
    Finder.find(dirs_to_scan, exts, files_to_ignore)
    |> Stream.map(fn file ->
      Processor.process(file, commit_since)
    end)
    |> Stream.filter(fn {status, _result} -> status == :ok end)
    |> Stream.map(fn {:ok, result} -> result end)
    |> Enum.to_list()
    |> Enum.sort_by(&Result.get_priority/1)

    :ok
  end
end
