defmodule Churn.Execution do
  @moduledoc """
  The main mechanism responsible for running analyse of printing results on the screen.
  """

  alias Churn.Configuration
  alias Churn.File.Finder
  alias Churn.Processor

  @spec run(Configuration.t()) :: :ok
  def run(%Configuration{
        directories_to_scan: dirs_to_scan,
        file_extensions: exts,
        files_to_ignore: files_to_ignore
      }) do
    Finder.find(dirs_to_scan, exts, files_to_ignore)
    |> Task.async_stream(&Processor.process/1)

    :ok
  end
end
