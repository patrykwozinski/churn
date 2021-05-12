defmodule Churn.Processor.TimesEdited do
  @moduledoc false

  alias Churn.File

  @spec calculate(File.t(), String.t()) :: pos_integer()
  def calculate(%File{path: file_path}, commits_since) do
    [
      "git",
      "-C",
      Path.dirname(file_path),
      "rev-list",
      "--since",
      commits_since,
      "--no-merges",
      "--count",
      "HEAD",
      Path.basename(file_path)
    ]
    |> Enum.join(" ")
    |> System.cmd([])

    0
  end
end
